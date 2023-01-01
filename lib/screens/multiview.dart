import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoop/network/network.dart';

class MultiView extends StatefulWidget {
  const MultiView({Key? key}) : super(key: key);

  @override
  State<MultiView> createState() => _MultiViewState();
}

class _MultiViewState extends State<MultiView> {
  @override
  Widget build(BuildContext context) {
    dynamic src = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 100),
                  width: MediaQuery.of(context).size.width,
                  height: 450,
                  child: FutureBuilder(
                      future: NetworkSystem().contentBuilder("us", "general"),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CupertinoActivityIndicator(color: Colors.white.withOpacity(0.7)));
                        } else {
                          return Container(
                            height: 200,
                            child: PageView.builder(
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                padEnds: false,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: src.width - 60,
                                          height: 200,
                                          decoration: ShapeDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(snapshot.data![index].imgURL),
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
                                                cornerRadius: 16,
                                                cornerSmoothing: 0.9,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        SizedBox(
                                          width: src.width - 60,
                                            child: Text(snapshot.data![index].title,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: -1,
                                                fontSize: 16,
                                                overflow: TextOverflow.ellipsis,
                                                height: 1.3
                                              ),
                                            )
                                        )
                                      ],
                                    ),
                                  );
                                }
                            ),
                          );
                        }
                      }

                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(top: 40, left: 15),
              width: MediaQuery.of(context).size.width,
              height: 90,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    child: CupertinoButton(
                      child: Icon(CupertinoIcons.chevron_back, color: Colors.blueAccent, size: 28,),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(CupertinoIcons.square_favorites_alt_fill, size: 20, color: Colors.white,),
                  SizedBox(width: 4),
                  Text("News",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1,
                        color: Colors.white,
                        fontSize: 19
                    ),
                  )
                ],
              ),
            ).frosted(
              blur: 20,
              frostColor: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
