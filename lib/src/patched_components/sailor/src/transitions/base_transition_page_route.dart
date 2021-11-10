import 'package:flutter/material.dart';

import '../../sailor.dart';
import 'transition_component.dart';

class BaseTransitionPageRoute extends PageRouteBuilder {
  final TransitionComponent transitionComponent;
  final Duration? duration;
  final Curve? curve;
  final bool useDefaultPageTransition;
  final CustomSailorTransition? customTransition;

  BaseTransitionPageRoute({
    required this.transitionComponent,
    required WidgetBuilder? builder,
    required RouteSettings? settings,
    this.duration,
    this.curve,
    this.useDefaultPageTransition = false,
    this.customTransition,
  }) : super(
            pageBuilder: (context, anim1, anim2) => builder!(context),
            settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (customTransition != null) {
      return customTransition!
          .buildTransition(context, animation, secondaryAnimation, child);
    }

    if (useDefaultPageTransition) {
      return Theme.of(context).pageTransitionsTheme.buildTransitions(
          this, context, animation, secondaryAnimation, child);
    }

    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve ?? Curves.linear,
    );

    return transitionComponent.buildChildWithTransition(
        context, curvedAnimation, secondaryAnimation, child);
  }

  @override
  Duration get transitionDuration =>
      duration ?? const Duration(milliseconds: 300);
}
