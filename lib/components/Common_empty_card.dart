// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'common_text.dart';
import 'neu_container.dart';

class CommonEmptyCard extends StatelessWidget {
  String? img;
  String? text;
  CommonEmptyCard({
    super.key,
    this.img,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: NeuContainer(
        padding: 0,
        child: Container(
          // height: 140,
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                  height: 80,
                  width: 80,
                  fit: BoxFit.contain,
                  image: AssetImage(img ?? "assets/icons/empty.png")),
              const SizedBox(height: 15),
              CommonText(
                  text: text ?? "No Item Found!",
                  fontSize: 16,
                  textAlign: TextAlign.center,
                  color: grey.withOpacity(0.5),
                  weight: FontWeight.w500),
            ],
          ),
        ),
      ),
    );
  }
}
