import 'package:flutter/material.dart';

import '../../sailor.dart';
import '../sailor.dart';

typedef RouteGuard = Future<bool> Function(
  BuildContext? context,
  BaseArguments? args,
  ParamMap paramMap,
);

abstract class SailorRouteGuard {
  SailorRouteGuard();

  Future<bool> canOpen(
    BuildContext? context,
    BaseArguments? args,
    ParamMap paramMap,
  );

  factory SailorRouteGuard.simple(RouteGuard canOpen) {
    return _SimpleRouteGuard(canOpen);
  }
}

class _SimpleRouteGuard extends SailorRouteGuard {
  final RouteGuard routeGuard;

  _SimpleRouteGuard(this.routeGuard) : super();

  @override
  Future<bool> canOpen(
    BuildContext? context,
    BaseArguments? args,
    ParamMap paramMap,
  ) {
    return routeGuard(context, args, paramMap);
  }
}
