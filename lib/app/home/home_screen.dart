import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymusic/app/home/component/customer_drawer.dart';
import 'package:mymusic/components/common_inkwell.dart';
import 'package:mymusic/utils/constants.dart';

import '../../components/common_text.dart';
import '../../components/neu_container.dart';
import '../../components/outline_container.dart';
import 'component/home_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: CommonText(text:"Home", fontSize: 22),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search_rounded),visualDensity: VisualDensity.compact),
          IconButton(onPressed: (){}, icon: Icon(Icons.info_rounded),visualDensity: VisualDensity.compact)
        ],
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Padding(
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
                                    image:
                                        AssetImage("assets/icons/record.png"))),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CommonText(
                                          text: "Newly Added",
                                          color: primaryWhite,
                                          weight: FontWeight.w400,
                                          fontSize: 14),
                                      Container(
                                        width: _w * 0.5,
                                        child: CommonText(
                                            text:
                                                "Music Song Name 123123 123 123 zxc 123 123",
                                            color: primaryWhite,
                                            weight: FontWeight.w600,
                                            fontSize: 20,
                                            maxLines: 2,
                                            overFlow: TextOverflow.ellipsis),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          CommonText(
                                              text: "Folder Name",
                                              color: primaryWhite,
                                              weight: FontWeight.w400,
                                              fontSize: 14),
                                          const SizedBox(width: 5),
                                          CommonText(
                                              text: "04:32",
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
                                      outlineColor: black.withOpacity(0.6),
                                      color: black.withOpacity(0.2),
                                      child: CommonInkwell(
                                        onPress: () {},
                                        space: 5,
                                        radius: 25,
                                        child: Row(
                                          children: [
                                            const SizedBox(width: 5),
                                            CommonText(text: "Listen"),
                                            const SizedBox(width: 5),
                                            const Icon(
                                                Icons.play_circle_rounded),
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
              ),
              const SizedBox(height: 20),
              HomeTitle(
                text: "Albums",
                onPress: () {},
              ),
              // const SizedBox(height: 20),
              Container(
                height: 160,
                // color: red,
                child: ListView.builder(
                    itemCount: albumData.length,
                    shrinkWrap: true,
                    // physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      var items = albumData[index];
                      return Row(
                        children: [
                          const SizedBox(width: 15),
                          NeuContainer(
                              padding: 0,
                              child: Container(
                                  height: 120,
                                  width: 120,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: AssetImage(items["image"]))),
                                    child: Container(
                                      margin: EdgeInsets.only(top: 70),
                                      decoration: BoxDecoration(
                                          color: black.withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: CommonInkwell(
                                        radius: 15,
                                        space: 0,
                                        onPress: () {},
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                  width: 80,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CommonText(
                                                          text: items["name"],
                                                          fontSize: 12,
                                                          weight:
                                                              FontWeight.w600,
                                                          color: primaryWhite,
                                                          maxLines: 1,
                                                          overFlow: TextOverflow
                                                              .ellipsis),
                                                      CommonText(
                                                          text: "$index items",
                                                          fontSize: 10,
                                                          color: primaryWhite
                                                              .withOpacity(0.7),
                                                          weight:
                                                              FontWeight.w400)
                                                    ],
                                                  )),
                                              Icon(Icons.play_circle_rounded,
                                                  color: primaryWhite,
                                                  size: 30),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))),
                          index == albumData.length - 1
                              ? const SizedBox(width: 15)
                              : const SizedBox(width: 0)
                        ],
                      );
                    }),
              ),
              const SizedBox(height: 10),
              HomeTitle(
                text: "Songs",
                onPress: () {},
              ),
              const SizedBox(height: 20),
              ListView.builder(
                  itemCount: 8,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        Padding(
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
                                              text:
                                                  "Song Name 01 zxc asd qwe 312 123 312 ",
                                              fontSize: 14,
                                              weight: FontWeight.w600,
                                              maxLines: 1,
                                              overFlow: TextOverflow.ellipsis)),
                                      CommonText(
                                          text: "03:32",
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
                                  onPress: () {},
                                  child: Icon(Icons.play_circle_rounded,
                                      color: grey, size: 36)),
                            ],
                          )),
                        ),
                        const SizedBox(height: 13),
                      ],
                    );
                  }),
              const SizedBox(height: 20),
            ]),
      ),
    );
  }

//
//--------------- Custom Functions
//

  List<Map<String?, dynamic>> albumData = [
    {"name": "Downloads", "image": "assets/images/cover01.jpg"},
    {"name": "Musics", "image": "assets/images/cover02.jpg"},
    {"name": "Songs", "image": "assets/images/cover03.jpg"},
    {"name": "Album Name 123 XYZ", "image": "assets/images/cover04.jpg"}
  ];
}
