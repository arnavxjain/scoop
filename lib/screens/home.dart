import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scoop/model/model.dart';
import 'package:scoop/network/network.dart';
import 'package:scoop/screens/scoop.dart';
import 'package:scoop/screens/settings.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sheet/sheet.dart';

late List<SourceObj> sources;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

TextStyle base(double fontSize){
  return TextStyle(
      fontFamily: "SF Pro Display",
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: -1
  );
}

TextStyle baseLight(double fontSize){
  return TextStyle(
      fontFamily: "SF Pro Display",
      color: Colors.white,
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.7
  );
}

TextStyle blueInk(double fontSize) {
  return TextStyle(
      fontFamily: "SF Pro Display",
      color: Color(0xFF007AFF),
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      letterSpacing: -0.7
  );
}

TextStyle baseOpacedDown(double fontSize){
  return TextStyle(
      fontFamily: "SF Pro Display",
      color: Colors.white.withOpacity(0.7),
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      letterSpacing: -0.7
  );
}

class _HomeState extends State<Home> {

  List options = [
    'India',
    'USA',
    'UK',
    'UAE',
    'Singapore',
    'Canada'
  ];

  List valuations = [
    'in',
    'us',
    'gb',
    'ae',
    'sg',
    'ca'
  ];

  List types = [
    'general',
    'entertainment',
    'business',
    'health',
    'science',
    'sports',
    'technology'
  ];

  LocalStorage firstEntry = new LocalStorage("firstEntry");


  // business entertainment general health science sports technology

  int systemIndex = 0;
  int systemType = 0;

  String locale = "in";
  String category = "general";

  String demoImgURL = "https://wideeducation.org/wp-content/uploads/2022/06/IKEA.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: NetworkSystem().sysInit(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // print(firstEntry.ready˳);
            return Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                image: DecorationImage(
                    image: NetworkImage(
                      snapshot.data!.imgURL,
                      // snapshot.data!.imgURL,
                    ), fit: BoxFit.cover),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 200.0, sigmaY: 200.0),
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 33),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Good Evening, Arnav", style: TextStyle(
                            fontFamily: "SF Pro Display",
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -1,
                          ),),
                          SizedBox(
                            width: 30,
                            height: 21,
                            child: CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Settings()));
                                },
                                child: Icon(Icons.account_circle_rounded, color: Colors.white, size: 27,)
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 17,),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.zero,
                      clipBehavior: Clip.hardEdge,
                      width: (MediaQuery.of(context).size.width) - 50,
                      height: (MediaQuery.of(context).size.width) - 50,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                            image: NetworkImage(snapshot.data!.imgURL),
                            fit: BoxFit.cover
                        ),
                        shadows: const [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 30.0,
                              spreadRadius: 5,
                              offset: Offset(
                                  0,
                                  6
                              )
                          )
                        ],
                        color: Colors.grey.withOpacity(0.75),
                        shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 18,
                            cornerSmoothing: 0.9,
                          ),
                        ),
                      ),
                      child: CupertinoButton(
                        onPressed: () {
                          showMaterialModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            expand: true,
                            context: context,
                            builder: (context) => Container(
                              padding: EdgeInsets.only(top: 50),
                              color: Colors.transparent,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 15, bottom: 20),
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 40,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Colors.grey.withOpacity(0.5)
                                      ),
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: NetworkSystem().sysInit(),
                                    builder: (BuildContext context, AsyncSnapshot snapshot2) {
                                      if (snapshot2.hasData) {
                                        // return Container(
                                        //     alignment: Alignment.bottomLeft,
                                        //     padding: EdgeInsets.zero,
                                        //     margin: EdgeInsets.zero,
                                        //     clipBehavior: Clip.hardEdge,
                                        //     width: (MediaQuery.of(context).size.width) - 50,
                                        //     height: (MediaQuery.of(context).size.width) - 50,
                                        //     decoration: ShapeDecoration(
                                        //       image: DecorationImage(
                                        //           image: NetworkImage(snapshot2.data!.imgURL),
                                        //           fit: BoxFit.cover
                                        //       ),
                                        //       shadows: const [
                                        //         BoxShadow(
                                        //             color: Colors.black26,
                                        //             blurRadius: 30.0,
                                        //             spreadRadius: 5,
                                        //             offset: Offset(
                                        //                 0,
                                        //                 6
                                        //             )
                                        //         )
                                        //       ],
                                        //       color: Colors.grey.withOpacity(0.75),
                                        //       shape: SmoothRectangleBorder(
                                        //         borderRadius: SmoothBorderRadius(
                                        //           cornerRadius: 18,
                                        //           cornerSmoothing: 0.9,
                                        //         ),
                                        //       ),
                                        //     )
                                        // );
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              padding: EdgeInsets.zero,
                                              margin: EdgeInsets.zero,
                                              width: (MediaQuery.of(context).size.width) - 50,
                                              height: (MediaQuery.of(context).size.width) - 50,
                                              // height: (MediaQuery.of(context).size.width) - 50,
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(snapshot2.data!.imgURL),
                                                  fit: BoxFit.cover,
                                                ),
                                                shadows: const [
                                                  BoxShadow(
                                                      color: Colors.black38,
                                                      blurRadius: 30.0,
                                                      spreadRadius: 5,
                                                      offset: Offset(
                                                          0,
                                                          10
                                                      )
                                                  )
                                                ],
                                                color: Colors.grey.withOpacity(0.75),
                                                shape: SmoothRectangleBorder(
                                                  borderRadius: SmoothBorderRadius(
                                                    cornerRadius: 20,
                                                    cornerSmoothing: 0.9,
                                                  ),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(15),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(height: 1),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(100),
                                                          boxShadow: [
                                                          ]
                                                      ),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(100),
                                                        ),
                                                        child: SizedBox(
                                                            child: CupertinoButton(
                                                                padding: EdgeInsets.zero,
                                                                child: Icon(Ionicons.share_outline, color: Colors.white, size: 20,),
                                                                onPressed: () {
                                                                  Share.share(snapshot.data!.url, subject: snapshot.data!.title);
                                                                }
                                                            )
                                                        ),
                                                      ),
                                                    ).frosted(
                                                        blur: 7,
                                                        borderRadius: BorderRadius.circular(100),
                                                        frostColor: Colors.black.withOpacity(0.1)
                                                      // fro
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              padding: EdgeInsets.symmetric(horizontal: 26),
                                              child: Column(
                                                children: [
                                                  Text(snapshot.data!.title,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18,
                                                        letterSpacing: -0.5,
                                                        color: Colors.white
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        height: 20,
                                                        // width: 100,
                                                        child: CupertinoButton(
                                                          padding: EdgeInsets.zero,
                                                          onPressed: () {

                                                          },
                                                          child: Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text(snapshot.data!.source, style: TextStyle(color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w600),),
                                                              Icon(FeatherIcons.chevronRight, size: 19, color: Colors.white.withOpacity(0.3),)
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 1,)
                                                    ],
                                                  ),
                                                  SizedBox(height: 14),
                                                  Text(snapshot.data!.content,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white.withOpacity(0.7),
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        letterSpacing: -0.4
                                                    ),
                                                  ),
                                                  snapshot.data!.content != "No Content Available." ? Row(
                                                    children: [
                                                      SizedBox(
                                                        child: CupertinoButton(
                                                          onPressed: () {
                                                            // Navigator.of(context).push(_createRoute(snapshot.data![index].url, snapshot.data![index].source));
                                                          },
                                                          padding: EdgeInsets.zero,
                                                          child: Text(
                                                            "Read Full Article",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 0.2,)
                                                    ],
                                                  ) : SizedBox()
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      } else {
                                        return CupertinoActivityIndicator();
                                      }
                                    },
                                  )
                                ],
                              ),
                            ).frosted(
                              blur: 30,
                              frostColor: Colors.black
                            )
                          );
                        },
                        padding: EdgeInsets.zero,
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 6),
                          shrinkWrap: true,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17,
                                      letterSpacing: -0.5,
                                      color: Colors.white
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text(snapshot.data!.source, style: TextStyle(color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 16)),
                              ],
                            ),
                          ],
                        ).frosted(
                          blur: 20,
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                          frostColor: Colors.black.withOpacity(0.1),
                          // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FeatherIcons.box, color: Colors.white,size: 20),
                          SizedBox(width: 5),
                          Text("Your news feed is ready", style: baseLight(18.0))
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    SizedBox(
                      width: 140,
                      height: 30,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        // behavior: HitTestBehavior.opaque,
                        onPressed: () {
                          NetworkSystem().showSources();
                          showMaterialModalBottomSheet(
                            useRootNavigator: true,
                            elevation: 10,
                            // elevation: 10,
                            // clipBehavior: Clip.hardEdge,
                            duration: Duration(milliseconds: 300),
                            // expand: true,
                            // bounce: true,
                            // elevation: ,
                            // useRootNavigator: true,
                            // barrierColor: Colors.black.withOpacity(0.7),
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) => Container(
                              clipBehavior: Clip.hardEdge,
                              // padding: EdgeInsets.all(24),
                              height: MediaQuery.of(context).size.height-55,
                              decoration: ShapeDecoration(
                                color: Color(0xFF1C1C1E),
                                shape: SmoothRectangleBorder(
                                  borderRadius: SmoothBorderRadius(
                                    cornerRadius: 26,
                                    cornerSmoothing: 0.9,
                                  ),
                                ),
                              ),
                              child: _sources(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("View all sources", style: baseOpacedDown(15)),
                            Icon(FeatherIcons.chevronRight, size: 18, color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox(width: 10)),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 26.0),
                      // padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      decoration: ShapeDecoration(
                        // color: Colors.grey.withOpacity(0.12),
                        shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 14,
                            cornerSmoothing: 0.9,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(CupertinoIcons.globe, color: Colors.white),
                              SizedBox(width: 5),
                              Text("News Region", style: base(17),),
                            ],
                          ),
                          SizedBox(
                            height: 38,
                            child: CupertinoButton(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey.withOpacity(0.2),
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                              onPressed: () {
                                showMaterialModalBottomSheet(
                                  duration: Duration(milliseconds: 300),
                                  // expand: true,
                                  // bounce: true,
                                  // elevation: ,
                                  // useRootNavigator: true,
                                  // barrierColor: Colors.black.withOpacity(0.7),
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => Container(
                                    height: (MediaQuery.of(context).size.height)*0.3,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF1C1C1E),
                                      shape: SmoothRectangleBorder(
                                        borderRadius: SmoothBorderRadius(
                                          cornerRadius: 26,
                                          cornerSmoothing: 0.9,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 20, right: 24, left: 24),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: 10),
                                              SizedBox(
                                                height: 20,
                                                child: CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Done",
                                                    style: blueInk(18),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: (MediaQuery.of(context).size.height)*0.2,
                                          // padding: EdgeInsets.all(24),
                                          //'Global',
                                          //     'India',
                                          //     'USA',
                                          //     'UK',
                                          //     'Oman',
                                          //     'Qatar',
                                          //     'Thailand'
                                          child: CupertinoPicker(
                                            looping: true,
                                            itemExtent: 37.0,
                                            children: <Widget>[
                                              for (String each in options) Padding(
                                                  padding: const EdgeInsets.only(top: 5.0),
                                                  child: Text(each, style: baseLight(21))
                                              )
                                            ],
                                            onSelectedItemChanged: (int index) {
                                              setState(() {
                                                systemIndex = index;
                                                // print(valuations[index]);
                                                locale = valuations[index];
                                                print(locale);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                // width: 120,
                                // padding: EdgeInsets.symmetric(horizontal: 13),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(options[valuations.indexOf(locale)], style: base(17)),
                                    Icon(FeatherIcons.chevronDown, color: Colors.white, size: 22,)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 7,),
                    Container(
                      // margin: EdgeInsets.symmetric(horizontal: 26.0),
                      // padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      decoration: ShapeDecoration(
                        // color: Colors.grey.withOpacity(0.12),
                        shape: SmoothRectangleBorder(
                          borderRadius: SmoothBorderRadius(
                            cornerRadius: 14,
                            cornerSmoothing: 0.9,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(CupertinoIcons.list_bullet_below_rectangle, color: Colors.white),
                              SizedBox(width: 5),
                              Text("News Category", style: base(17),),
                            ],
                          ),
                          SizedBox(
                            height: 38,
                            child: CupertinoButton(
                              borderRadius: BorderRadius.circular(10),
                              // color: Colors.grey.withOpacity(0.2),
                              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                              onPressed: () {
                                showMaterialModalBottomSheet(
                                  duration: Duration(milliseconds: 300),
                                  // expand: true,
                                  // bounce: true,
                                  // elevation: ,
                                  // useRootNavigator: true,
                                  barrierColor: Colors.black.withOpacity(0.7),
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => Container(
                                    height: (MediaQuery.of(context).size.height)*0.3,
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF1D1D1E),
                                      shape: SmoothRectangleBorder(
                                        borderRadius: SmoothBorderRadius(
                                          cornerRadius: 26,
                                          cornerSmoothing: 0.9,
                                        ),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(top: 20, left: 24, right: 24),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(width: 10),
                                              SizedBox(
                                                height: 20,
                                                child: CupertinoButton(
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Done",
                                                    style: blueInk(18),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: (MediaQuery.of(context).size.height)*0.2,
                                          // padding: EdgeInsets.all(24),
                                          child: CupertinoPicker(
                                            looping: true,
                                            itemExtent: 37.0,
                                            children: <Widget>[
                                              for (String typex in types) Padding(
                                                  padding: const EdgeInsets.only(top: 5.0),
                                                  child: Text(typex.toCapitalized(), style: baseLight(21))
                                              )
                                            ],
                                            onSelectedItemChanged: (int index) {
                                              setState(() {
                                                category = types[index];

                                                print(category);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                // width: 120,
                                // padding: EdgeInsets.symmetric(horizontal: 13),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(category.toCapitalized(), style: base(17)),
                                    Icon(FeatherIcons.chevronDown, color: Colors.white, size: 22)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    themeButton(Icons.play_arrow_rounded, "Start", () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ScoopStream(category: category, locale: locale)));
                    }),
                    const SizedBox(height: 36,),
                  ],
                ),
              ),
            );
          } else {
            return Container(color: Color(0xFF111111), child: Center(child: CupertinoActivityIndicator(radius: 14,)));
          }
        },
      ),
    );
  }

  themeButton(IconData shuffle, String text, dynamic tap) {
    return CupertinoButton(
      onPressed: tap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 6.0),
        decoration: ShapeDecoration(
          color: Colors.black87,
            shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
            cornerRadius: 14,
            cornerSmoothing: 0.9,
            ),
          ),
            shadows: const [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 14.0,
                  spreadRadius: 1,
                  offset: Offset(
                      0,
                      6
                  )
              )
            ]
        ),
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(shuffle, color: Color(0xFF4D7EFF), size: 24,),
              SizedBox(width: 3,),
              Text(text, style: TextStyle(color: Color(0xFF4D7EFF), fontWeight: FontWeight.bold, letterSpacing: -0.7, fontSize: 17),),
              const SizedBox(width: 4,)
            ],
          ),
        ),
      ),
    );
  }

  _sources() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 23, left: 21, right: 20, bottom: 20),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFF333333),
                width: 1.0
              )
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("News Sources", style: baseLight(18)),
              SizedBox(
                height: 20,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Done",
                    style: blueInk(18),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.94,
            height: 40,
            child: CupertinoSearchTextField(
              backgroundColor: Color(0xFF252525),
              borderRadius: BorderRadius.circular(11),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Icon(FeatherIcons.search, color: Colors.grey.withOpacity(0.7), size: 18,),
              ),
            )
          ),
        ),
        FutureBuilder<List<SourceObj>>(
          future: NetworkSystem().showSources(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Expanded(child: Center(child: CupertinoActivityIndicator(color: Colors.white.withOpacity(0.7),)));
            } else {
              List<SourceObj> sources = snapshot.data!;
              return Expanded(
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Scrollbar(
                    isAlwaysShown: true,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      itemCount: sources.length,
                      itemBuilder: (context, index) => _sourceDisplay(sources[index].name, sources[index].type),
                    ),
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }

  _sourceDisplay(String name, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: ShapeDecoration(
        color: Colors.grey.withOpacity(0.1),
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 12,
            cornerSmoothing: 0.9,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name, style: base(16),),
              SizedBox(height: 3,),
              Text(text.toCapitalized(), style: baseOpacedDown(12),),
            ],
          ),
          Container(
            width: 20,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              // color: Colors.grey.withOpacity(0.4)
            ),
            child: SizedBox(
              width: 30,
              height: 30,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  print("demos");
                },
                child: Icon(FeatherIcons.chevronRight, color: Colors.white.withOpacity(0.5), size: 22,)
              ),
            ),
          )
        ],
      ),
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}