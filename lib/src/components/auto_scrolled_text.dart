import 'dart:async';

import 'package:flutter/material.dart';

class AutoScrolledText extends StatefulWidget {
  const AutoScrolledText(
    this.text, {
    Key? key,
    this.style,
    this.speedFactor = 20,
  }) : super(key: key);

  final String text;
  final TextStyle? style;
  final int speedFactor;

  @override
  _AutoScrolledTextState createState() => _AutoScrolledTextState();
}

class _AutoScrolledTextState extends State<AutoScrolledText> with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  bool scroll = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() async {
      if (_scrollController.position.extentAfter == 0) {
        await Future.delayed(const Duration(seconds: 3));
        _scrollController.jumpTo(0);
        await Future.delayed(const Duration(seconds: 3));
        _scroll();
      }
    });
    Timer(const Duration(seconds: 1), () {
      _scroll();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scroll() {
    try {
      final maxExtent = _scrollController.position.maxScrollExtent;
      final distanceDifference = maxExtent - _scrollController.offset;
      final durationDouble = (distanceDifference / widget.speedFactor) * 1000;
      if (durationDouble > 1) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: durationDouble.toInt()),
          curve: Curves.linear,
        );
      }
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification && scroll) {
            Timer(const Duration(seconds: 1), () {
              _scroll();
            });
          }

          return true;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          child: Text(
            widget.text,
            maxLines: 1,
            style: widget.style ?? Theme.of(context).textTheme.caption,
          ),
        ),
      ),
    );
  }
}
