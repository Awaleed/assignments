import 'package:flutter/material.dart';

import '../../sailor.dart';
import 'base_transition_page_route.dart';
import 'concrete_transition_component.dart';
import 'decorators/fade_in_transition_decorator.dart';
import 'decorators/slide_bottom_transition_decorator.dart';
import 'decorators/slide_left_transition_decorator.dart';
import 'decorators/slide_right_transition_decorator.dart';
import 'decorators/slide_top_transition_decorator.dart';
import 'decorators/zoom_in_transition_decorator.dart';
import 'transition_component.dart';

class TransitionFactory {
  static PageRoute buildTransition({
    RouteSettings? settings,
    WidgetBuilder? builder,
    Duration? duration,
    Curve? curve,
    List<SailorTransition>? transitions,
    CustomSailorTransition? customTransition,
  }) {
    TransitionComponent transitionComponent = ConcreteTransitionComponent();

    // ?.forEach((transition)
    if (transitions != null) {
      for (final transition in transitions) {
        switch (transition) {
          case SailorTransition.slideFromLeft:
            transitionComponent = SlideLeftTransitionDecorator(
                transitionComponent: transitionComponent);
            break;
          case SailorTransition.slideFromBottom:
            transitionComponent = SlideDownTransitionDecorator(
                transitionComponent: transitionComponent);
            break;
          case SailorTransition.slideFromTop:
            transitionComponent = SlideTopTransitionDecorator(
                transitionComponent: transitionComponent);
            break;
          case SailorTransition.slideFromRight:
            transitionComponent = SlideRightTransitionDecorator(
                transitionComponent: transitionComponent);
            break;
          case SailorTransition.zoomIn:
            transitionComponent = ZoomInTransitionDecorator(
                transitionComponent: transitionComponent);
            break;
          case SailorTransition.fadeIn:
            transitionComponent = FadeInTransitionDecorator(
                transitionComponent: transitionComponent);
            break;
        }
      }
    }

    return BaseTransitionPageRoute(
      settings: settings,
      builder: builder,
      transitionComponent: transitionComponent,
      duration: duration,
      curve: curve,
      useDefaultPageTransition: transitions == null || transitions.isEmpty,
      customTransition: customTransition,
    );
  }
}
