import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'common_text.dart';
import 'neu_container.dart';

class EmptyCardBig extends StatelessWidget {
  const EmptyCardBig({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: NeuContainer(
        padding: 0,
        child: Container(
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Image(
                  height: 50,
                  width: 50,
                  fit: BoxFit.contain,
                  image: AssetImage("assets/icons/empty.png")),
                  const SizedBox(height: 10),
                  CommonText(
                    text: "No Item Found!",
                    fontSize: 14,
                    color: grey.withOpacity(0.5),
                    weight: FontWeight.w600
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
