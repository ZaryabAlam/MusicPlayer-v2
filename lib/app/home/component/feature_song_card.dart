import"package:flutter/material.dart";
import "package:on_audio_query/on_audio_query.dart";

import "../../../components/common_inkwell.dart";
import "../../../components/common_text.dart";
import "../../../components/neu_container.dart";
import "../../../components/outline_container.dart";
import "../../../utils/constants.dart";
import "../../../utils/time_format.dart";

class featureSongCard extends StatelessWidget {
  featureSongCard({
    super.key,
    required this.audioFile,
    required bool isDarkMode,
    required this.onPress,
    
  }) : _isDarkMode = isDarkMode;
  final SongModel audioFile;
  final bool _isDarkMode;
    final Function() onPress;

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: NeuContainer(
        padding: 0,
        child: Container(
            height: 120,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Stack(
                children: [
                  const Positioned(
                      top: -30,
                      left: -60,
                      child: Image(
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                          image: AssetImage("assets/icons/record.png"))),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                                text: "Newly Added",
                                color: primaryWhite,
                                weight: FontWeight.w400,
                                fontSize: 14),
                            Container(
                              width: _w * 0.5,
                              child: CommonText(
                                  text: audioFile.title,
                                  color: primaryWhite,
                                  weight: FontWeight.w600,
                                  fontSize: 20,
                                  maxLines: 2,
                                  overFlow: TextOverflow.ellipsis),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CommonText(
                                    text: audioFile.album ?? "---",
                                    color: primaryWhite,
                                    weight: FontWeight.w400,
                                    fontSize: 14),
                                const SizedBox(width: 5),
                                CommonText(
                                    text: formatDurationMilliseconds(
                                        audioFile.duration ?? 00),
                                    color: primaryWhite,
                                    weight: FontWeight.w300,
                                    fontSize: 12),
                              ],
                            ),
                          ],
                        ),
                        OutlineContainer(
                            padding: 0,
                            radius: 25,
                            outlineColor: _isDarkMode
                                ? white.withOpacity(0.5)
                                : black.withOpacity(0.5),
                            color: black.withOpacity(0.2),
                            child: CommonInkwell(
                              onPress: onPress,
                              space: 5,
                              radius: 25,
                              child: Row(
                                children: [
                                  const SizedBox(width: 5),
                                  CommonText(text: "Listen"),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.play_circle_rounded),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}