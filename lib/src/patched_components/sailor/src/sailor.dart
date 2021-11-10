import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../sailor.dart';
import 'errors/param_not_provided.dart';
import 'errors/param_not_registered.dart';
import 'errors/route_not_found.dart';
import 'logger/app_logger.dart';
import 'models/arguments_wrapper.dart';
import 'navigator_observers/sailor_stack_observer.dart';
import 'transitions/transition_factory.dart';
import 'ui/page_not_found.dart';

enum NavigationType { push, pushReplace, pushAndRemoveUntil, popAndPushNamed }

/// Sailor manages routing, registering routes with transitions, navigating to
/// routes, closing routes. It is a thin layer on top of [Navigator] to help
/// you encapsulate and manage routing at one place.
class Sailor {
  Sailor({
    this.options = const SailorOptions(isLoggingEnabled: true),
  }) {
    AppLogger.init(isLoggerEnabled: options.isLoggingEnabled);
    if (options.navigatorKey != null) {
      _navigatorKey = options.navigatorKey;
    } else {
      _navigatorKey = GlobalKey<NavigatorState>();
    }
  }

  /// Configuration options for [Sailor].
  ///
  /// Check out [SailorOptions] for available options.
  final SailorOptions options;

  /// Store all the mappings of route names and corresponding [SailorRoute]
  /// Used to generate routes
  final Map<String, SailorRoute> _routeNameMappings = {};

  /// Store all the mappings of route names and corresponding [SailorParam]s
  final Map<String, Map<String, SailorParam>> _routeParamsMappings = {};

  /// A navigator key lets Sailor grab the [NavigatorState] from a [MaterialApp]
  /// or a [CupertinoApp]. All navigation operations (push, pop, etc) are carried
  /// out using this [NavigatorState].
  ///
  /// This is the same [NavigatorState] that is returned by [Navigator.of(context)]
  /// (when there is only a single [Navigator] in Widget tree, i.e. from [MaterialApp]
  /// or [CupertinoApp]).
  GlobalKey<NavigatorState>? _navigatorKey;

  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  final SailorStackObserver _navigationStackObserver = SailorStackObserver();

  SailorStackObserver get navigationStackObserver => _navigationStackObserver;

  /// Get the registered routes names as a list.
  List<String> getRegisteredRouteNames() {
    return _routeNameMappings.keys.toList();
  }

  /// Retrieves the arguments passed in when calling the [navigate] function.
  ///
  /// Returned arguments are casted with the type provided, the type will always
  /// be a subtype of [BaseArguments].
  ///
  /// Make sure to provide the appropriate type, that is, provide the same type
  /// as the one passed while calling [navigate], else a cast error will be
  /// thrown.
  static T? args<T extends BaseArguments?>(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is ArgumentsWrapper) {
      return args.baseArguments as T?;
    }
  }

  static T? param<T>(BuildContext context, String key) {
    final routeSettings = ModalRoute.of(context)!.settings;
    final argumentsWrapper = routeSettings.arguments! as ArgumentsWrapper;
    final isParamNotRegistered =
        argumentsWrapper.routeParams == null || !argumentsWrapper.routeParams!.containsKey(key);

    if (isParamNotRegistered) {
      throw ParamNotRegisteredError(
        paramKey: key,
        routeName: routeSettings.name,
      );
    }

    // Check for request paramter type with registered paramter type.
    final paramRegisterdType = argumentsWrapper.routeParams![key]!.paramType; // Type with which param was registed
    if (T != paramRegisterdType) {
      // AppLogger.instance
      // ..warning("========================================")
      // ..warning("Mismatching Paramter Type!")
      // ..warning(
      //     "Requested param '$key' with type '$T', but was declared with type '$paramRegisterdType'.\n")
      // ..warning(
      //     "Make sure to pass the type of variable which used when declaring the 'SailorParam<T>'.")
      // ..warning("========================================");
    }

    final defaultParamValue = argumentsWrapper.routeParams![key]!.defaultValue;
    final paramFromNavigationCall = argumentsWrapper.params != null ? argumentsWrapper.params![key] : null;
    return (paramFromNavigationCall ?? defaultParamValue) as T?;
  }

  /// Add a new route to [Sailor].
  ///
  /// Route is stored in [_routeNameMappings].
  ///
  /// If a route is provided with a name that was previously added, it will
  /// override the old one.
  void addRoute(SailorRoute route) {
    if (_routeNameMappings.containsKey(route.name)) {
      AppLogger.instance!.warning("'${route.name}' has already been registered before. Overriding it!");
    }

    // Prepare route params
    final routeParams = <String, SailorParam>{};

    if (route.params != null) {
      for (final sailorParam in route.params!) {
        if (routeParams.containsKey(sailorParam.name)) {
          AppLogger.instance!
              .warning("'${sailorParam.name}' param has already been specified for route $route. Overriding it!");
        }

        routeParams[sailorParam.name] = sailorParam;
      }
    }

    _routeNameMappings[route.name] = route;
    _routeParamsMappings[route.name] = routeParams;
  }

  /// Add a list of routes at once.
  ///
  /// Calls [addRoute] for each route in the list.
  void addRoutes(List<SailorRoute> routes) {
    for (final route in routes) {
      addRoute(route);
    }
  }

  /// Makes this a callable class. Delegates to [navigate].
  Future<T> call<T>(
    String name, {
    BaseArguments? args,
    NavigationType navigationType = NavigationType.push,
    dynamic result,
    bool Function(Route<dynamic> route)? removeUntilPredicate,
    List<SailorTransition>? transitions,
    Duration? transitionDuration,
    Map<String, dynamic>? params,
    CustomSailorTransition? customTransition,
  }) {
    assert(navigationType != NavigationType.pushAndRemoveUntil || removeUntilPredicate != null);

    _checkAndThrowRouteNotFound(name, args, navigationType);

    return navigate<T>(
      name,
      navigationType: navigationType,
      result: result,
      removeUntilPredicate: removeUntilPredicate,
      args: args,
      transitions: transitions,
      transitionDuration: transitionDuration,
      params: params,
      customTransition: customTransition,
    );
  }

  /// Function used to navigate pages.
  ///
  /// [name] is the route name that was registered using [addRoute].
  ///
  /// [args] are optional arguments that can be passed to the next page.
  /// To retrieve these arguments use [args] method on [Sailor].
  ///
  /// [navigationType] can be specified to choose from various navigation
  /// strategies such as [NavigationType.push], [NavigationType.pushReplace],
  /// [NavigationType.pushAndRemoveUntil].
  ///
  /// [removeUntilPredicate] should be provided if using
  /// [NavigationType.pushAndRemoveUntil] strategy.
  ///
  /// [transitions] is a list of transitions to be used when switching between
  /// pages. [transitionDuration] and [transitionCurve] are duration and curve
  /// used for these transitions.
  ///
  /// [params] are key pair values that can be passed when navigating to a route.
  ///
  /// Provide a custom transition with [customTransition] to sailor instead of using
  /// inbuilt transitions, if not provided, sailor will revert to use its default
  /// transitions or delegate to system's own transitions.
  Future<T> navigate<T>(
    String name, {
    BaseArguments? args,
    NavigationType navigationType = NavigationType.push,
    dynamic result,
    bool Function(Route<dynamic> route)? removeUntilPredicate,
    List<SailorTransition>? transitions,
    Duration? transitionDuration,
    Curve? transitionCurve,
    Map<String, dynamic>? params,
    CustomSailorTransition? customTransition,
  }) {
    assert(navigationType != NavigationType.pushAndRemoveUntil || removeUntilPredicate != null);

    _checkAndThrowRouteNotFound(name, args, navigationType);

    return _navigate(
      name,
      args,
      navigationType,
      result,
      removeUntilPredicate,
      transitions,
      transitionDuration,
      transitionCurve,
      params,
      customTransition,
    ).then((value) => value as T);
  }

  /// Push multiple routes at the same time.
  ///
  /// [routeArgsPairs] is a list of [RouteArgsPair]. Each [RouteArgsPair]
  /// contains the name of a route and its corresponding argument (if any).
  Future<List> navigateMultiple(
    List<RouteArgsPair> routeArgsPairs,
  ) {
    assert(routeArgsPairs.isNotEmpty);

    final pageResponses = <Future>[];

    // For each route check if it exists.
    // Push the route.

    for (final routeArgs in routeArgsPairs) {
      _checkAndThrowRouteNotFound(
        routeArgs.name,
        routeArgs.args,
        // TODO(gurleensethi): Give user the ability to use any type of NavigationType
        NavigationType.push,
      );

      final response = _navigate(
        routeArgs.name,
        routeArgs.args,
        // TODO(gurleensethi): Give user the ability to use any type of NavigationType
        NavigationType.push,
        null,
        null,
        routeArgs.transitions,
        routeArgs.transitionDuration,
        routeArgs.transitionCurve,
        null,
        routeArgs.customTransition,
      );

      pageResponses.add(response);
    }

    return Future.wait(pageResponses);
  }

  /// Actual navigation is delegated by [navigate] method to this method.
  ///
  /// [name] is the route name that was registered using [addRoute].
  ///
  /// [args] are optional arguments that can be passed to the next page.
  /// To retrieve these arguments use [arguments] method on [Sailor].
  ///
  /// [navigationType] can be specified to choose from various navigation
  /// strategies such as [NavigationType.push], [NavigationType.pushReplace],
  /// [NavigationType.pushAndRemoveUntil].
  ///
  /// [removeUntilPredicate] should be provided is using
  /// [NavigationType.pushAndRemoveUntil] strategy.
  ///
  /// [transitions] is a list of transitions to be used when switching between
  /// pages. [transitionDuration] and [transitionCurve] are duration and curve
  /// used for these transitions.
  ///
  /// [params] are key pair values that can be passed when navigating to a route.
  Future<dynamic> _navigate(
    String name,
    BaseArguments? args,
    NavigationType navigationType,
    dynamic result,
    bool Function(Route<dynamic> route)? removeUntilPredicate,
    List<SailorTransition>? transitions,
    Duration? transitionDuration,
    Curve? transitionCurve,
    Map<String, dynamic>? params,
    CustomSailorTransition? customTransition,
  ) async {
    final routeParams = _routeParamsMappings[name];
    if (routeParams != null) {
      routeParams.forEach((key, value) {
        // Type of paramter passed should be the same
        // when type is declared.
        if (params!.containsKey(value.name) && params[value.name] != null) {
          final passedParamType = params[value.name].runtimeType;
          if (passedParamType != value.paramType) {
            AppLogger.instance!.warning('Invalid Parameter Type! '
                "'${value.name}' is declared with a type '${value.paramType}', "
                "but a '$passedParamType' was passed!");
          }
        }

        // All paramters that are 'required' should be passed.
        final bool isMissingRequiredParam = value.isRequired && (!params.containsKey(value.name));

        if (isMissingRequiredParam) {
          AppLogger.instance!.warning(ParameterNotProvidedError(
            paramKey: value.name,
            routeName: name,
          ).toString());
        }
      });
    }

    final argsWrapper = ArgumentsWrapper(
      baseArguments: args,
      transitions: transitions,
      transitionDuration: transitionDuration,
      transitionCurve: transitionCurve,
      params: params,
      routeParams: _routeParamsMappings[name],
      customTransition: customTransition,
    );

    // Evaluate if the route can be opend using route guard.
    final route = _routeNameMappings[name];

    if (route != null && route.routeGuards != null && route.routeGuards!.isNotEmpty) {
      bool canOpen = true;
      for (final SailorRouteGuard routeGuard in route.routeGuards!) {
        final result = await routeGuard.canOpen(
          navigatorKey!.currentContext,
          argsWrapper.baseArguments,
          ParamMap(name, routeParams, params),
        );
        if (result != true) {
          canOpen = false;
          break;
        }
      }
      if (canOpen != true) {
        AppLogger.instance!.warning("'$name' route rejected by route guard!");
        return null;
      }
    }

    switch (navigationType) {
      case NavigationType.push:
        return navigatorKey!.currentState!.pushNamed(name, arguments: argsWrapper);
      case NavigationType.pushReplace:
        return navigatorKey!.currentState!.pushReplacementNamed(name, result: result, arguments: argsWrapper);
      case NavigationType.pushAndRemoveUntil:
        return navigatorKey!.currentState!.pushNamedAndRemoveUntil(name, removeUntilPredicate!, arguments: argsWrapper);
      case NavigationType.popAndPushNamed:
        return navigatorKey!.currentState!.popAndPushNamed(name, result: result, arguments: argsWrapper);
    }
  }

  /// If the route is not registered throw an error
  /// Make sure to use the correct name while calling navigate.
  void _checkAndThrowRouteNotFound(
    String name,
    BaseArguments? args,
    NavigationType navigationType,
  ) {
    if (!_routeNameMappings.containsKey(name)) {
      if (options.handleNameNotFoundUI) {
        navigatorKey!.currentState!.push(
          MaterialPageRoute(builder: (BuildContext context) {
            return PageNotFound(
              routeName: name,
              args: args,
              navigationType: navigationType,
            );
          }),
        );
      }
      throw RouteNotFoundError(name: name);
    }
  }

  /// Delegation for [Navigator.pop].
  void pop([dynamic result]) {
    navigatorKey!.currentState!.pop(result);
  }

  /// Delegation for [Navigator.popUntil].
  void popUntil(bool Function(Route<dynamic>) predicate) {
    navigatorKey!.currentState!.popUntil(predicate);
  }

  /// Generates the [RouteFactory] which builds a [Route] on request.
  ///
  /// These routes are built using the [SailorRoute]s provided using
  /// [addRoute] method.
  RouteFactory generator() {
    return (settings) {
      final route = _routeNameMappings[settings.name!];

      if (route == null) return null;

      // TODO(gurleensethi): Check if this is a sailor route or a normal route.
      ArgumentsWrapper? argsWrapper = settings.arguments as ArgumentsWrapper?;

      // If for some reason the arguments passed themself are null.
      argsWrapper ??= ArgumentsWrapper();

      final BaseArguments? baseArgs = argsWrapper.baseArguments;

      // Select which transitions to use.
      // Priority:
      //   1. Transitions provided when route is called.
      //   2. Default transitions when route was registered.
      //   3. Default transition from SailorOptions.
      final List<SailorTransition> transitions = [];

      final bool areTransitionsProvidedInNavigate =
          argsWrapper.transitions != null && argsWrapper.transitions!.isNotEmpty;
      final bool areTransitionsProvidedInRouteDeclaration =
          route.defaultTransitions != null && route.defaultTransitions!.isNotEmpty;
      final bool areTransitionsProvidedInSailorOptions = options.defaultTransitions != null;

      if (areTransitionsProvidedInNavigate) {
        transitions.addAll(argsWrapper.transitions!);
      } else if (areTransitionsProvidedInRouteDeclaration) {
        transitions.addAll(route.defaultTransitions!);
      } else if (areTransitionsProvidedInSailorOptions) {
        transitions.addAll(options.defaultTransitions!);
      }

      final transitionDuration =
          argsWrapper.transitionDuration ?? route.defaultTransitionDuration ?? options.defaultTransitionDuration;

      final transitionCurve =
          argsWrapper.transitionCurve ?? route.defaultTransitionCurve ?? options.defaultTransitionCurve;

      final customTransition = argsWrapper.customTransition ?? route.customTransition ?? options.customTransition;

      bool shouldUseCustomTransition = customTransition != null;
      if (argsWrapper.customTransition != null) {
        shouldUseCustomTransition = true;
      } else if (areTransitionsProvidedInNavigate) {
        shouldUseCustomTransition = false;
      } else if (route.customTransition != null) {
        shouldUseCustomTransition = true;
      } else if (areTransitionsProvidedInRouteDeclaration) {
        shouldUseCustomTransition = false;
      } else if (options.customTransition != null) {
        shouldUseCustomTransition = true;
      } else if (areTransitionsProvidedInSailorOptions) {
        shouldUseCustomTransition = false;
      }

      final RouteSettings routeSettings = RouteSettings(
        name: settings.name,
        arguments: argsWrapper.copyWith(
          baseArguments: baseArgs ?? route.defaultArgs,
        ),
      );

      return TransitionFactory.buildTransition(
        transitions: transitions,
        duration: transitionDuration,
        curve: transitionCurve,
        settings: routeSettings,
        customTransition: shouldUseCustomTransition ? customTransition : null,
        builder: (context) => route.builder(
          context,
          baseArgs ?? route.defaultArgs,
          ParamMap(
            route.name,
            argsWrapper!.routeParams,
            argsWrapper.params,
          ),
        ),
      );
    };
  }

  static RouteFactory unknownRouteGenerator() {
    return (settings) {
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) {
          return PageNotFound(
            routeName: settings.name!,
            args: settings.arguments as BaseArguments?,
          );
        },
      );
    };
  }
}

class ParamMap {
  final String _routeName;
  final Map<String, SailorParam>? _routeParams;
  final Map<String, dynamic>? _params;

  ParamMap(this._routeName, this._routeParams, this._params);

  T? param<T>(String key) {
    final isParamNotRegistered = _routeParams == null || !_routeParams!.containsKey(key);

    if (isParamNotRegistered) {
      throw ParamNotRegisteredError(
        paramKey: key,
        routeName: _routeName,
      );
    }

    final defaultParamValue = _routeParams![key]!.defaultValue;
    final paramFromNavigationCall = _params != null ? _params![key] : null;
    return (paramFromNavigationCall ?? defaultParamValue) as T?;
  }
}
