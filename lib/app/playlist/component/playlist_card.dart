import "package:flutter/material.dart";

import "../../../components/common_inkwell.dart";
import "../../../components/common_text.dart";
import "../../../components/neu_container.dart";

import "../../../utils/constants.dart";

class PlaylistCard extends StatelessWidget {
  PlaylistCard(
      {super.key,
      required this.name,
      required this.items,
      required this.onPress});
  final String? name;
  final String items;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: NeuContainer(
        padding: 0,
        child: Container(
            height: 100,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  const Positioned(
                      top: -40,
                      left: -60,
                      child: Image(
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                          image: AssetImage("assets/icons/record.png"))),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      child: CommonText(
                          text: name.toString(),
                          color: primaryWhite,
                          weight: FontWeight.w600,
                          fontSize: 22,
                          maxLines: 2,
                          overFlow: TextOverflow.ellipsis),
                    ),
                  ),
                  CommonInkwell(
                    space: 0,
                    radius: 15,
                    onPress: onPress,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: black.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonText(
                                text: "$items items",
                                fontSize: 14,
                                color: primaryWhite.withOpacity(0.7),
                                weight: FontWeight.w400),
                            Icon(Icons.play_circle_rounded,
                                color: primaryWhite, size: 30),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
