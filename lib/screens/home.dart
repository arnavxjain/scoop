import 'dart:ui';

import 'package:figma_squircle/figma_squircle.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            image: const DecorationImage(
                image: NetworkImage(
                  "https://upload.wikimedia.org/wikipedia/en/0/08/Justin_Bieber_-_Justice.png",
                ), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 400.0, sigmaY: 400.0),
          child: Column(
            children: [
              const SizedBox(height: 66),
              Text("scoop", style: TextStyle(
                fontFamily: "SF Pro Display",
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
              ),),
              const SizedBox(height: 16,),
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                width: (MediaQuery.of(context).size.width) - 50,
                height: (MediaQuery.of(context).size.width) - 50,
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: NetworkImage("https://upload.wikimedia.org/wikipedia/en/0/08/Justin_Bieber_-_Justice.png"),
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
              const SizedBox(height: 12),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
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
              const Expanded(child: SizedBox(width: 10)),
              themeButton(Icons.play_arrow_rounded, "Start", () {

              }),
              const SizedBox(height: 46,),
            ],
          ),
        ),
      ),
    );
  }

  themeButton(IconData shuffle, String text, dynamic tap) {
    return GestureDetector(
      onTap: tap,
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
              Icon(shuffle, color: Color(0xFF418CFF), size: 24,),
              SizedBox(width: 4,),
              Text(text, style: TextStyle(color: Color(0xFF418CFF), fontWeight: FontWeight.bold, letterSpacing: -0.7, fontSize: 17),),
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
              Text("Sources", style: base(18)),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Done",
                  style: blueInk(18),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}