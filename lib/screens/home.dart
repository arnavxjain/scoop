import 'dart:ui';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
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
                      blurRadius: 10.0,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
