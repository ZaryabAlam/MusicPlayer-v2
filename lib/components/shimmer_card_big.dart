import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/constants.dart';
import 'neu_container.dart';

class ShimmerCardBig extends StatelessWidget {
  const ShimmerCardBig({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      onPlay: (controller) => controller.repeat(),
      effects: [ShimmerEffect(color: grey.withOpacity(0.3), duration: 1500.ms)],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: NeuContainer(
          padding: 0,
          child: Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Image(
                height: 80,
                width: 80,
                fit: BoxFit.contain,
                image: AssetImage("assets/icons/record_fill.png"),
                color: grey.withOpacity(0.1)),
          ),
        ),
      ),
    );
  }
}
