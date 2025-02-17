// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";

import "../../../components/common_inkwell.dart";
import "../../../components/common_text.dart";
import "../../../components/outline_container.dart";
import "../../../utils/constants.dart";

class HomeTitle extends StatelessWidget {
  String text;
   final Function() onPress;
   HomeTitle({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
              text: text, weight: FontWeight.w600, fontSize: 20),
          OutlineContainer(
              padding: 0,
              radius: 25,
              outlineColor: grey.withOpacity(0.2),
              color: black.withOpacity(0.05),
              child: CommonInkwell(
                onPress: onPress,
                space: 2,
                radius: 25,
                child: Row(
                  children: [
                    const SizedBox(width: 5),
                    CommonText(text: "See all"),
                    const SizedBox(width: 5),
                     Icon(Icons.arrow_forward_ios_rounded,
                        size: 15, color: grey.withOpacity(0.8)),
                    const SizedBox(width: 5),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}