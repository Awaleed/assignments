import 'package:flutter/material.dart';

import '../transition_component.dart';
import '../transiton_decorator.dart';

class SlideDownTransitionDecorator extends TransitionDecorator {
  SlideDownTransitionDecorator({
    TransitionComponent? transitionComponent,
  }) : super(transitionComponent: transitionComponent);

  @override
  Widget buildChildWithTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 1.0),
        end: Offset.zero,
      ).animate(animation),
      child: transitionComponent!.buildChildWithTransition(
          context, animation, secondaryAnimation, child),
    );
  }
}
