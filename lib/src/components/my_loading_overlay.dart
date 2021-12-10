import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class MyLoadingOverLay extends StatefulWidget {
  const MyLoadingOverLay({
<<<<<<< Updated upstream
    Key? key,
    required this.isLoading,
    this.showSpinner = false,
    this.transparent = false,
    required this.child,
=======
    Key key,
    @required this.isLoading,
    this.showSpinner = false,
    this.transparent = false,
    @required this.child,
>>>>>>> Stashed changes
  }) : super(key: key);

  final Widget child;
  final bool isLoading;
  final bool showSpinner;
  final bool transparent;

  @override
  _MyLoadingOverLayState createState() => _MyLoadingOverLayState();
}

class _MyLoadingOverLayState extends State<MyLoadingOverLay> {
<<<<<<< Updated upstream
  late Timer _timer;
=======
  Timer _timer;
>>>>>>> Stashed changes
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(1500.milliseconds, (_) => setState(() {}));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: widget.isLoading,
      color: widget.transparent ? Colors.transparent : Colors.black38,
      progressIndicator: Center(
        child: widget.showSpinner
            ? Container(
                margin: const EdgeInsets.only(left: 40.0, right: 40.0),
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(strokeWidth: 2.0),
                ),
              )
            : CustomAnimation<double>(
<<<<<<< Updated upstream
                control: CustomAnimationControl.playFromStart,
=======
                control: CustomAnimationControl.PLAY_FROM_START,
>>>>>>> Stashed changes
                tween: 0.0.tweenTo(pi * 2),
                duration: 500.milliseconds,
                curve: Curves.easeInOut,
                builder: (context, child, value) => Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(value),
                  alignment: Alignment.center,
                  child: child,
                ),
                child: Image.asset(
                  'assets/img/main_logo.png',
                  height: 200,
                ),
              ),
      ),
      child: widget.child,
    );
  }
}
