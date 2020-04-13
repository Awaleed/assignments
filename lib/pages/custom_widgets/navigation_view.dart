import 'package:flutter/material.dart';

class NavigationView {
  NavigationView({
    Widget child,
    Color color,
    TickerProvider vsync,
  })  : _child = child,
        _color = color,
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = controller.drive(CurveTween(
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    ));
  }

  final Widget _child;
  final Color _color;
  final AnimationController controller;
  Animation<double> _animation;

  FadeTransition transition(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Scaffold(
        appBar: AppBar(backgroundColor: _color,title: Text('appPar'),),
        body: _child,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
