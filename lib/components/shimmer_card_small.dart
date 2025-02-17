import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/constants.dart';
import 'neu_container.dart';

class ShimmerCardSmall extends StatelessWidget {
  const ShimmerCardSmall({
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
          radius: 12,
          child: Container(
            height: 60,
            width: double.infinity,
            padding: EdgeInsets.all(12),
            child: Image(
                height: 60,
                width: 60,
                fit: BoxFit.contain,
                image: AssetImage("assets/icons/record_fill.png"),
                color: grey.withOpacity(0.1)),
          ),
        ),
      ),
    );
  }
}
