import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pull_down_button/pull_down_button.dart';
import 'package:scoop/model/model.dart';
import 'package:scoop/network/network.dart';
import 'package:scoop/screens/dynamic.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheet/sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScoopStream extends StatefulWidget {

  const ScoopStream({Key? key, this.locale, this.category}) : super(key: key);

  final String? category;
  final String? locale;

  @override
  State<ScoopStream> createState() => _ScoopStreamState(this.locale, this.category);
}

class _ScoopStreamState extends State<ScoopStream> {
  final String? category;
  final String? locale;

  _ScoopStreamState(this.locale, this.category);

  // print();

  final PageController _controller = PageController();

  int scrollPos = 0;

  double boxHeight = 300;

  Future<void> _refresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  bool? scrollY = true;

  getScrollYMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getBool("scroll") == null || prefs.getBool("scroll") == "") {
      setScrollYMethod(true);
      scrollY = true;
      return true;
    }

    scrollY = prefs.getBool("scroll");
    return prefs.getBool("scroll");
  }

  setScrollYMethod(bool stance) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    scrollY = stance;
    prefs.setBool("scroll", stance);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            child: FutureBuilder(
              future: NetworkSystem().contentBuilder(locale, category),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      Expanded(child: Center(child: CupertinoActivityIndicator(color: Colors.white.withOpacity(0.7),))),
                    ],
                  );
                } else {
                  // print(snapshot.data);
                  List<Article> articles = snapshot.data!;
                  return LiquidPullToRefresh(
                    height: 260,
                    color: Color(0xFF333333),
                    backgroundColor: Colors.black.withOpacity(0.4),
                    onRefresh: _refresh,
                    showChildOpacityTransition: false,
                    child: PageView.builder(
                      controller: _controller,
                      padEnds: false,
                      scrollDirection: scrollY == true ? Axis.vertical : Axis.horizontal,
                      itemCount: snapshot.data!.length,
                      onPageChanged: (index) {
                      },
                      itemBuilder: (context, index) {
                        return Stack(
                          alignment: Alignment.center,
                          fit: StackFit.expand,
                          children: [
                            ImageFiltered(
                              imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                              child: Container(
                                // padding: EdgeInsets.only(top: 70, left: 10, right: 10),
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(snapshot.data![index].imgURL)
                                    )
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              color: Colors.black.withOpacity(0.2),
                            ),
                            Positioned(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              top: 70,
                              left: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.zero,
                                    margin: EdgeInsets.zero,
                                    width: (MediaQuery.of(context).size.width) - 43,
                                    height: (MediaQuery.of(context).size.width) - 43,
                                    // height: (MediaQuery.of(context).size.width) - 50,
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
                                                        Share.share(snapshot.data![index].url, subject: snapshot.data![index].title);
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
                                        Text(snapshot.data![index].title,
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
                                                  // Navigator.of(context).push(_createRoute(snapshot.data![index].url, snapshot.data![index].source));
                                                },
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text(snapshot.data![index].source, style: TextStyle(color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w600),),
                                                    Icon(FeatherIcons.chevronRight, size: 19, color: Colors.white.withOpacity(0.3),)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 1,)
                                          ],
                                        ),
                                        SizedBox(height: 14),
                                        Text(snapshot.data![index].content,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: Colors.white.withOpacity(0.7),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -0.4
                                          ),
                                        ),
                                        snapshot.data![index].content != "No Content Available." ? Row(
                                          children: [
                                            SizedBox(
                                              child: CupertinoButton(
                                                onPressed: () {},
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
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          Positioned(
            bottom: 42,
            left: 30,
            child: SizedBox(
              width: MediaQuery.of(context).size.width- 68,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                        child: Icon(FeatherIcons.chevronLeft, color: Colors.white, size: 30,),
                        onPressed: () {
                          Navigator.pop(context);
                        }
                    ),
                    CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Icon(CupertinoIcons.ellipsis_circle, color: Colors.white, size: 26,),
                        onPressed: () {
                          showMaterialModalBottomSheet(
                            // barrierColor: Colors.black.withOpacity(0.5),
                            backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => StatefulBuilder(
                                builder: (BuildContext context, StateSetter setModalState) {
                                  return Container(
                                  padding: EdgeInsets.all(20),
                                  height: MediaQuery.of(context).size.height*0.5,
                                  decoration: ShapeDecoration(
                                    color: Color(0xFF1C1C1E),
                                    shape: SmoothRectangleBorder(
                                      borderRadius: SmoothBorderRadius(
                                        cornerRadius: 13,
                                        cornerSmoothing: 0.9,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Preferences", style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: -1,
                                            fontSize: 20
                                          )),
                                          SizedBox(
                                            height: 25,
                                            width: 24,
                                            child: CupertinoButton(
                                                padding: EdgeInsets.zero,
                                                child: Icon(CupertinoIcons.clear_circled_solid, color: Colors.grey.withOpacity(0.4), size: 27,),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 15),
                                      Text(
                                        "Scroll Layout",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.8),
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: -1
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 20),
                                        // height: 160,
                                        // margin: EdgeInsets.symmetric(horizontal: 10),
                                        width: MediaQuery.of(context).size.width - 10,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF222222),
                                          shape: SmoothRectangleBorder(
                                            borderRadius: SmoothBorderRadius(
                                              cornerRadius: 16,
                                              cornerSmoothing: 0.9,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CupertinoButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                setModalState(() {
                                                  scrollY = true;
                                                  setScrollYMethod(true);
                                                });
                                                setState(() {
                                                  scrollY = true;
                                                  setScrollYMethod(true);
                                                });
                                                print("scrollY $scrollY");
                                              },
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 100,
                                                    decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    image: DecorationImage(
                                                    image: AssetImage("lib/assets/vertical.png"),
                                                    fit: BoxFit.fitWidth,
                                                ))),
                                                  SizedBox(height: 6),
                                                  Text("Vertical",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      letterSpacing: -.7,
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 17
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  scrollY == true ? Icon(CupertinoIcons.checkmark_circle_fill, color: Colors.blueAccent) : Icon(CupertinoIcons.circle, color: Colors.grey),
                                                  SizedBox(height: 4),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 0.1),
                                            CupertinoButton(
                                              padding: EdgeInsets.zero,
                                              onPressed: () {
                                                setModalState(() {
                                                  scrollY = false;
                                                  setScrollYMethod(false);
                                                });
                                                setState(() {
                                                  scrollY = false;
                                                  setScrollYMethod(false);
                                                });
                                                print("scrollY $scrollY");
                                              },
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      width: 50,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.transparent,
                                                          image: DecorationImage(
                                                            image: AssetImage("lib/assets/horizontal.png"),
                                                            fit: BoxFit.fitWidth,
                                                          ))),
                                                  SizedBox(height: 6),
                                                  Text("Horizontal",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        letterSpacing: -.7,
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 17
                                                    ),
                                                  ),
                                                  SizedBox(height: 8),
                                                  scrollY == false ? Icon(CupertinoIcons.checkmark_circle_fill, color: Colors.blueAccent) : Icon(CupertinoIcons.circle, color: Colors.grey),
                                                  SizedBox(height: 4),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("  Custom Setting",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 19,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: -1
                                            ),
                                          ),
                                          CupertinoSwitch(
                                              value: true,
                                              onChanged: (boolean) {
                                                print(boolean);
                                            }
                                          )
                                        ],
                                      )
                                      // Container(width: double.infinity, height: 1, color: Colors.grey.withOpacity(0.3),)
                                    ],
                                  ),
                                 );
                                },
                              )
                          );
                        }
                    ),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}

Route _createRoute(String? urlData, String? source) {
  print("DynamicLinkState Call: [501:04] : $urlData");
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DynamicLink(url: urlData, source: source,),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}