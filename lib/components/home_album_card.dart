import"package:flutter/material.dart";

import "../utils/constants.dart";
import "common_inkwell.dart";
import "common_text.dart";
import "neu_container.dart";

class HomeAlbumCard extends StatelessWidget {
  final String folderName;
  final String image;
  final String itemCount;
  final Function() onPress;
  const HomeAlbumCard({
    super.key,
    required this.folderName,
    required this.image,
    required this.itemCount,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return NeuContainer(
        padding: 0,
        child: Container(
            height: 120,
            width: 120,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(image: AssetImage(image))),
              child: Container(
                margin: EdgeInsets.only(top: 70),
                decoration: BoxDecoration(
                    color: black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(15)),
                child: CommonInkwell(
                  radius: 15,
                  space: 0,
                  onPress: onPress,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 80,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(
                                    text: folderName,
                                    fontSize: 12,
                                    weight: FontWeight.w600,
                                    color: primaryWhite,
                                    maxLines: 1,
                                    overFlow: TextOverflow.ellipsis),
                                CommonText(
                                   
                                    text:
                                        "$itemCount items",
                                    fontSize: 10,
                                    color: primaryWhite.withOpacity(0.7),
                                    weight: FontWeight.w400)
                              ],
                            )),
                        Icon(Icons.play_circle_rounded,
                            color: primaryWhite, size: 30),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}