// ignore_for_file: must_be_immutable

import "package:flutter/material.dart";

import "../../../components/common_inkwell.dart";
import "../../../components/common_text.dart";
import "../../../components/neu_container.dart";
import "../../../utils/constants.dart";

class SongListItem extends StatelessWidget {
  String name;
  String duration;
   final Function() onPress;
 
  SongListItem({
    super.key,
    required this.name,
    required this.duration,
    required this.onPress,

 
  });

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: NeuContainer(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(
                  image: AssetImage("assets/icons/record.png"),
                  height: 45,
                  width: 45,
                  fit: BoxFit.contain),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: _w * 0.55,
                      child: CommonText(
                          text: name,
                          fontSize: 14,
                          weight: FontWeight.w600,
                          maxLines: 1,
                          overFlow: TextOverflow.ellipsis)),
                  const SizedBox(height: 5),
                  CommonText(
                      text: duration,
                      fontSize: 12,
                      weight: FontWeight.w400,
                      color: grey,
                      maxLines: 1,
                      overFlow: TextOverflow.ellipsis)
                ],
              ),
            ],
          ),
          CommonInkwell(
              space: 0,
              onPress: onPress,
              child: Icon(Icons.play_circle_rounded, color: grey, size: 36)),
        ],
      )),
    );
  }
}