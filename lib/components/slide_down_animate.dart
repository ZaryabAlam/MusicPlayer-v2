import "package:flutter/material.dart";
import "package:flutter_animate/flutter_animate.dart";

class SlideDownAnimate extends StatefulWidget {
  final List<Widget> children;
  final int? delay;
  SlideDownAnimate({super.key, required this.children, this.delay});

  @override
  State<SlideDownAnimate> createState() => _SlideDownAnimateState();
}

class _SlideDownAnimateState extends State<SlideDownAnimate> {
  @override
  Widget build(BuildContext context) {
    return Animate(effects: [
      FadeEffect(delay: 50.ms, duration: 1000.ms),
      SlideEffect(
          delay: 100.ms,
          begin: Offset(0, -1),
          end: Offset.zero,
          curve: Curves.easeIn,
          duration: Duration(milliseconds: widget.delay ?? 300))
    ], child: Column(children: widget.children));
  }
}