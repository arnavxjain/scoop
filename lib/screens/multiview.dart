import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:scoop/network/network.dart';

const TextStyle titleStyle = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.w700,
  letterSpacing: -1
);

class MultiView extends StatefulWidget {
  const MultiView({Key? key}) : super(key: key);

  @override
  State<MultiView> createState() => _MultiViewState();
}

class _MultiViewState extends State<MultiView> {

  final PageController _pageController = PageController();
  double? currentPage = 0;

  void _affectState(int index) {
    setState(() {
      currentPage = index.toDouble();
    });
  }

  String sportsCountry = "in";
  String businessCountry = "in";

  @override
  Widget build(BuildContext context) {
    dynamic src = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 100),
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(top: 90),
                  width: MediaQuery.of(context).size.width,
                  height: 295,
                  child: FutureBuilder(
                      future: NetworkSystem().contentBuilder("us", "general"),
                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CupertinoActivityIndicator(color: Colors.white.withOpacity(0.7)));
                        } else {
                          return Container(
                            margin: EdgeInsets.only(top: 20),
                            height: 200,
                            child: PageView.builder(
                              onPageChanged: (index) {
                                // _affectState(index);
                              },
                              controller: _pageController,
                                itemCount: 5,
                                scrollDirection: Axis.horizontal,
                                padEnds: false,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ArticleExpanded(data: snapshot.data![index])));
                                    },
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Hero(
                                            tag: "pv-img",
                                            child: Container(
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
                                          ),
                                          SizedBox(height: 10),
                                          SizedBox(
                                              width: src.width - 60,
                                              child: Hero(
                                                tag: "pv-text",
                                                child: Material(
                                                  color: Colors.transparent,
                                                  child: Text(snapshot.data![index].title,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w700,
                                                      letterSpacing: -1,
                                                      fontSize: 16,
                                                      overflow: TextOverflow.ellipsis,
                                                      height: 1.3,
                                                    ),
                                                  ),
                                                ),
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                            ),
                          );
                        }
                      }

                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: StatefulBuilder(
                     builder: (BuildContext context, StateSetter setDotState) {
                       return DotsIndicator(
                        dotsCount: 5,
                        position: currentPage!.toDouble(),
                        decorator: DotsDecorator(
                        color: Colors.black87, // Inactive color
                        activeColor: Colors.grey.withOpacity(0.4),
                        size: Size(6, 6),
                        activeSize: Size(6, 6),
                        spacing: EdgeInsets.symmetric(horizontal: 4)
                      ),
                     );
                   },
                  ),
                ),
                SizedBox(height: 20),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setSportState) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 270,
                      // padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(CupertinoIcons.chart_bar_circle_fill, color: Colors.white),
                                    SizedBox(width: 4),
                                    Text("Business", style: titleStyle)
                                  ],
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setSportState(() {
                                      businessCountry = "us";
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                                    decoration: ShapeDecoration(
                                      color: Colors.grey.withOpacity(0.09),
                                      shape: SmoothRectangleBorder(
                                        borderRadius: SmoothBorderRadius(
                                          cornerRadius: 10,
                                          cornerSmoothing: 0.9,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text("India",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              letterSpacing: -1,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Icon(CupertinoIcons.chevron_down, color: Colors.white, size: 15,)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 2),
                          FutureBuilder(
                              future: NetworkSystem().contentBuilder(businessCountry, "business"),
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CupertinoActivityIndicator(color: Colors.white.withOpacity(0.7)));
                                } else {
                                  return Container(
                                    height: 200,
                                    child: GridView.builder(
                                        padding: EdgeInsets.only(left: 30),
                                        itemCount: 15,
                                        scrollDirection: Axis.horizontal,
                                        gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, childAspectRatio: (40/100)),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoHeroArticleExpanded(data: snapshot.data![index])));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(right: 10),
                                              width: 200,
                                              height: 130,
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              clipBehavior: Clip.hardEdge,
                                              decoration: ShapeDecoration(
                                                color: Colors.black.withOpacity(0.2),
                                                shape: SmoothRectangleBorder(
                                                  borderRadius: SmoothBorderRadius(
                                                    cornerRadius: 10,
                                                    cornerSmoothing: 0.9,
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 70,
                                                    height: 100,
                                                    decoration: ShapeDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(snapshot.data![index].imgURL),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      color: Colors.grey.withOpacity(0.75),
                                                      shape: SmoothRectangleBorder(
                                                        borderRadius: SmoothBorderRadius(
                                                          cornerRadius: 0,
                                                          cornerSmoothing: 0.9,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(snapshot.data![index].title,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w600,
                                                          overflow: TextOverflow.ellipsis,
                                                          letterSpacing: -0.6,
                                                          fontSize: 13
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  );
                                }
                              }
                          )
                        ],
                      ),
                    );
                  },
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setSportState) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 270,
                      // padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.run_circle_rounded, color: Colors.white),
                                    SizedBox(width: 4),
                                    Text("Sports", style: titleStyle)
                                  ],
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    setSportState(() {
                                      sportsCountry = "us";
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 14),
                                    decoration: ShapeDecoration(
                                      color: Colors.grey.withOpacity(0.09),
                                      shape: SmoothRectangleBorder(
                                        borderRadius: SmoothBorderRadius(
                                          cornerRadius: 10,
                                          cornerSmoothing: 0.9,
                                        ),
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Text("India",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              letterSpacing: -1,
                                              fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        SizedBox(width: 2),
                                        Icon(CupertinoIcons.chevron_down, color: Colors.white, size: 15,)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 2),
                          FutureBuilder(
                              future: NetworkSystem().contentBuilder(sportsCountry, "sport"),
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CupertinoActivityIndicator(color: Colors.white.withOpacity(0.7)));
                                } else {
                                  return Container(
                                    height: 200,
                                    child: GridView.builder(
                                        padding: EdgeInsets.only(left: 30),
                                        itemCount: 15,
                                        scrollDirection: Axis.horizontal,
                                        gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20, childAspectRatio: (40/100)),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => NoHeroArticleExpanded(data: snapshot.data![index])));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(right: 10),
                                              width: 200,
                                              height: 130,
                                              margin: EdgeInsets.symmetric(vertical: 10),
                                              clipBehavior: Clip.hardEdge,
                                              decoration: ShapeDecoration(
                                                color: Colors.black.withOpacity(0.2),
                                                shape: SmoothRectangleBorder(
                                                  borderRadius: SmoothBorderRadius(
                                                    cornerRadius: 10,
                                                    cornerSmoothing: 0.9,
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 70,
                                                    height: 100,
                                                    decoration: ShapeDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(snapshot.data![index].imgURL),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      color: Colors.grey.withOpacity(0.75),
                                                      shape: SmoothRectangleBorder(
                                                        borderRadius: SmoothBorderRadius(
                                                          cornerRadius: 0,
                                                          cornerSmoothing: 0.9,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(snapshot.data![index].title,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w600,
                                                          overflow: TextOverflow.ellipsis,
                                                          letterSpacing: -0.6,
                                                          fontSize: 13
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  );
                                }
                              }
                          )
                        ],
                      ),
                    );
                  },
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
              height: 100,
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

class ArticleExpanded extends StatefulWidget {
  const ArticleExpanded({Key? key, this.data}) : super(key: key);

  final dynamic data;

  @override
  State<ArticleExpanded> createState() => _ArticleExpandedState(this.data);
}

class _ArticleExpandedState extends State<ArticleExpanded> {
  final dynamic data;

  _ArticleExpandedState(this.data);

  @override
  Widget build(BuildContext context) {
    dynamic src = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Hero(
              tag: "pv-img",
              child: Container(
                padding: EdgeInsets.only(top: 50, left: 20),
                alignment: Alignment.topLeft,
                child: Container(
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
                            child: Icon(Ionicons.chevron_back, color: Colors.white, size: 20,),
                            onPressed: () {
                              Navigator.pop(context);
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
                width: src.width,
                height: 270,
                decoration: ShapeDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data.imgURL),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.grey.withOpacity(0.75),
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 0,
                      cornerSmoothing: 0.9,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 6, right: 10),
            child: Column(
              children: [
                Hero(
                  tag: "pv-text",
                  child: Material(
                    color: Colors.transparent,
                    child: Text(data.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 20,
                  // width: 100,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {

                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(data.source, style: TextStyle(color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 16),),
                        Icon(FeatherIcons.chevronRight, size: 19, color: Colors.white.withOpacity(0.3),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          data.content != "No Content Available." ? Padding(
            padding: EdgeInsets.only(left: 15, top: 6, right: 13),
            child: Text(
              data.content,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  letterSpacing: -1
              ),
            ),
          ) : SizedBox()
        ],
      ),
    );
  }
}

class NoHeroArticleExpanded extends StatefulWidget {
  const NoHeroArticleExpanded({Key? key, this.data}) : super(key: key);

  final dynamic data;

  @override
  State<NoHeroArticleExpanded> createState() => _NoHeroArticleExpandedState(this.data);
}

class _NoHeroArticleExpandedState extends State<NoHeroArticleExpanded> {
  final dynamic data;

  _NoHeroArticleExpandedState(this.data);

  @override
  Widget build(BuildContext context) {
    dynamic src = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Container(
              padding: EdgeInsets.only(top: 50, left: 20),
              alignment: Alignment.topLeft,
              child: Container(
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
                          child: Icon(Ionicons.chevron_back, color: Colors.white, size: 20,),
                          onPressed: () {
                            Navigator.pop(context);
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
              width: src.width,
              height: 270,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage(data.imgURL),
                  fit: BoxFit.cover,
                ),
                color: Colors.grey.withOpacity(0.75),
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius(
                    cornerRadius: 0,
                    cornerSmoothing: 0.9,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 6, right: 10),
            child: Column(
              children: [
                Text(data.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -1,
                    fontSize: 19,
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 20,
                  // width: 100,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {

                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(data.source, style: TextStyle(color: Colors.white.withOpacity(0.5), fontWeight: FontWeight.w600, fontSize: 16),),
                        Icon(FeatherIcons.chevronRight, size: 19, color: Colors.white.withOpacity(0.3),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          data.content != "No Content Available." ? Padding(
            padding: EdgeInsets.only(left: 15, top: 6, right: 13),
            child: Text(
              data.content,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17,
                letterSpacing: -1
              ),
            ),
          ) : SizedBox()
        ],
      ),
    );
  }
}
