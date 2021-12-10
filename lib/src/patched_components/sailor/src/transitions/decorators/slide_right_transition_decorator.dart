import 'package:flutter/material.dart';
import '../transition_component.dart';
import '../transiton_decorator.dart';

class SlideRightTransitionDecorator extends TransitionDecorator {
  SlideRightTransitionDecorator({
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
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: transitionComponent!.buildChildWithTransition(
          context, animation, secondaryAnimation, child),
    );
  }
}