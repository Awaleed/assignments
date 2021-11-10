import 'package:flutter/material.dart';

class IndexedTransitionSwitcher extends StatefulWidget {
  const IndexedTransitionSwitcher({
    required this.index,
    required this.children,
    required this.transitionBuilder,
    this.reverse = false,
    this.duration = const Duration(milliseconds: 300),
  });

  final int index;

  final List<Widget>? children;

  final Widget Function(Widget child, Animation<double> primaryAnimation, Animation<double> secondaryAnimation)
      transitionBuilder;

  final Duration duration;

  final bool reverse;

  @override
  _IndexedTransitionSwitcherState createState() => _IndexedTransitionSwitcherState();
}

class _IndexedTransitionSwitcherState extends State<IndexedTransitionSwitcher> with TickerProviderStateMixin {
  late List<_ChildEntry> _childEntries;

  @override
  void initState() {
    super.initState();

    _childEntries = widget.children!.asMap().entries.map((entry) => _createPageEntry(entry.key, entry.value)).toList();
  }

  @override
  void didUpdateWidget(IndexedTransitionSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.index != oldWidget.index) {
      final _ChildEntry newChild = _childEntries.where((entry) => entry.index == widget.index).first;
      final _ChildEntry oldChild = _childEntries.where((entry) => entry.index == oldWidget.index).first;

      if (widget.reverse) {
        newChild.primaryController.value = 1;
        newChild.secondaryController.reverse(from: 1);

        oldChild.secondaryController.value = 0;
        oldChild.primaryController.reverse(from: 1).then((value) => setState(() {
              oldChild.onStage = false;
              oldChild.primaryController.reset();
              oldChild.secondaryController.reset();
            }));
      } else {
        newChild.secondaryController.value = 0;
        newChild.primaryController.forward(from: 0);

        oldChild.primaryController.value = 1;
        oldChild.secondaryController.forward().then((value) => setState(() {
              oldChild.onStage = false;
              oldChild.primaryController.reset();
              oldChild.secondaryController.reset();
            }));
      }

      _childEntries.remove(newChild);
      _childEntries.remove(oldChild);
      _childEntries.addAll(widget.reverse ? [newChild, oldChild] : [oldChild, newChild]);
      newChild.onStage = true;
    }
  }

  _ChildEntry _createPageEntry(int index, Widget child) {
    final AnimationController primaryController = AnimationController(
      value: widget.index == index ? 1.0 : 0,
      duration: widget.duration,
      vsync: this,
    );
    final AnimationController secondaryController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    return _ChildEntry(
      key: UniqueKey(),
      index: index,
      primaryController: primaryController,
      secondaryController: secondaryController,
      transitionChild: widget.transitionBuilder(child, primaryController, secondaryController),
      onStage: widget.index == index,
    );
  }

  @override
  void dispose() {
    for (final _ChildEntry entry in _childEntries) {
      entry.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: _childEntries
            .map<Widget>(
              (entry) => Offstage(
                key: entry.key,
                offstage: !entry.onStage,
                child: entry.transitionChild,
              ),
            )
            .toList(),
      );
}

class _ChildEntry {
  _ChildEntry(
      {required this.index,
      required this.key,
      required this.primaryController,
      required this.secondaryController,
      required this.transitionChild,
      required this.onStage});

  final int index;

  final Key key;

  final AnimationController primaryController;

  final AnimationController secondaryController;

  final Widget transitionChild;

  bool onStage;

  void dispose() {
    primaryController.dispose();
    secondaryController.dispose();
  }
}
