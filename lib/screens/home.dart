import 'dart:ui';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

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
                image: AssetImage(
                  "/Users/arnavjain/Documents/flutter/scoop/lib/assets/demo.png",
                ), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
          child: Column(
            children: [
              const SizedBox(height: 66),
              const Center(child: Text("scoop", style: TextStyle(
                fontFamily: "SF Pro Display",
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: -1
              ),)),
              const SizedBox(height: 16,),
              Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                width: (MediaQuery.of(context).size.width) - 50,
                height: (MediaQuery.of(context).size.width) - 50,
                decoration: ShapeDecoration(
                  image: const DecorationImage(
                    image: AssetImage("/Users/arnavjain/Documents/flutter/scoop/lib/assets/demo.png"),
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
                    Icon(FeatherIcons.box, color: Colors.white,size: 20,),
                    SizedBox(width: 5),
                    Text("Your new feed is ready", style: baseLight(18.0))
                  ],
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          color: Colors.amber,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text('Modal BottomSheet'),
                                ElevatedButton(
                                  child: const Text('Close BottomSheet'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
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
              const SizedBox(height: 46,)
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
        width: 170,
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 6.0),
        decoration: ShapeDecoration(
          color: Colors.black26,
            shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
            cornerRadius: 12,
            cornerSmoothing: 0.9,
            ),
          ),
            shadows: const [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 16.0,
                  spreadRadius: 8,
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
}