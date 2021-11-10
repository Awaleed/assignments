import 'package:flutter/material.dart';

import '../transition_component.dart';
import '../transiton_decorator.dart';

class ZoomInTransitionDecorator extends TransitionDecorator {
  ZoomInTransitionDecorator({required TransitionComponent transitionComponent})
      : super(transitionComponent: transitionComponent);

  @override
  Widget buildChildWithTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return ScaleTransition(
      scale: animation,
      child: transitionComponent!.buildChildWithTransition(
          context, animation, secondaryAnimation, child),
    );
  }
}
