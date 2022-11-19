import 'dart:ui';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sheet/sheet.dart';

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
    'Global',
    'India',
    'USA',
    'UK',
    'Oman',
    'Qatar',
    'Thailand'
  ];

  List valuations = [
    'gl',
    'in',
    'us',
    'uk',
    'om',
    'qtr',
    'th'
  ];

  List types = [
    'Politics',
    'Sports',
    'Healthcare',
    'Trending',
    'Business'
  ];

  List typeValuations = [
    'politics',
    'sports',
    'healthcare',
    'trending',
    'business'
  ];

  int systemIndex = 0;
  int systemType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            image: const DecorationImage(
                image: NetworkImage(
                  "https://cdn8.openculture.com/2018/02/26214611/Arlo-safe-e1519715317729.jpg",
                ), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 400.0, sigmaY: 400.0),
          child: Column(
            children: [
              const SizedBox(height: 70),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 33),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Scoop", style: TextStyle(
                      fontFamily: "SF Pro Display",
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),),
                    SizedBox(
                      height: 21,
                      width: 24,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          print("header button");
                        },
                        child: Icon(FeatherIcons.chevronRight, color: Colors.white,)
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 17,),
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                width: (MediaQuery.of(context).size.width) - 50,
                height: (MediaQuery.of(context).size.width) - 50,
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: NetworkImage("https://cdn8.openculture.com/2018/02/26214611/Arlo-safe-e1519715317729.jpg"),
                    fit: BoxFit.fill
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
                  color: Colors.red.withOpacity(0.75),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 18,
                      cornerSmoothing: 0.9,
                    ),
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
                    Text("Your new feed is ready", style: baseLight(18.0))
                  ],
                ),
              ),
              SizedBox(
                width: 130,
                height: 40,
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  // behavior: HitTestBehavior.opaque,
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
                          // padding: EdgeInsets.all(24),
                          height: MediaQuery.of(context).size.height-55,
                          decoration: ShapeDecoration(
                            color: Color(0xFF1D1D1E),
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
                      Text("View all sources", style: baseOpacedDown(14)),
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
                    Text("News Region", style: base(18),),
                    SizedBox(
                      height: 38,
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.grey.withOpacity(0.2),
                        padding: EdgeInsets.zero,
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
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
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
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("Global", style: baseLight(21),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("India", style: baseLight(21),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("USA", style: baseLight(21),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("UK", style: baseLight(21),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("Oman", style: baseLight(21),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("Qatar", style: baseLight(21),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("Thailand", style: baseLight(21),),
                                        ),
                                      ],
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          systemIndex = index;
                                          print(valuations[index]);
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
                              Text(options[systemIndex], style: base(18),),
                              Icon(FeatherIcons.chevronDown, color: Colors.white,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
                    Text("News Category", style: base(18),),
                    SizedBox(
                      height: 38,
                      child: CupertinoButton(
                        borderRadius: BorderRadius.circular(10),
                        // color: Colors.grey.withOpacity(0.2),
                        padding: EdgeInsets.zero,
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
                                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
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
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("Politics", style: baseLight(21),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("Sports", style: baseLight(21),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("Healthcare", style: baseLight(21),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("Trending", style: baseLight(21),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Text("Business", style: baseLight(21),),
                                        ),
                                      ],
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          systemType = index;
                                          print(typeValuations[index]);
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
                              Text(types[systemType], style: base(18),),
                              Icon(FeatherIcons.chevronDown, color: Colors.white,)
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
                // func(x) for initiating main void function
                print("initiate");
              }),
              const SizedBox(height: 36,),
            ],
          ),
        ),
      ),
    );
  }

  themeButton(IconData shuffle, String text, dynamic tap) {
    return CupertinoButton(
      onPressed: tap,
      child: Container(
        width: MediaQuery.of(context).size.width-50,
        height: 54,
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
              SizedBox(width: 4,),
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
              Text("News Sources", style: base(18)),
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
        )
      ],
    );
  }
}