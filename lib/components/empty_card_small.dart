import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'common_text.dart';
import 'neu_container.dart';

class EmptyCardSmall extends StatelessWidget {
  const EmptyCardSmall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: NeuContainer(
        padding: 0,
        child: Container(
          height: 60,
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Image(
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                  image: AssetImage("assets/icons/empty.png")),
              const SizedBox(width: 10),
              CommonText(
                  text: "No Item Found!",
                  fontSize: 12,
                  color: grey.withOpacity(0.5),
                  weight: FontWeight.w600),
            ],
          ),
        ),
      ),
    );
  }
}
