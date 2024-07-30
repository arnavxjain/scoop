import 'dart:ui';

import 'package:animate_gradient/animate_gradient.dart';
import 'package:blur/blur.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scoop/network/network.dart';
import 'package:scoop/screens/dynamic.dart';
import 'package:share_plus/share_plus.dart';

const TextStyle titleStyle = TextStyle(
  fontSize: 20,
  color: Colors.white,
  fontWeight: FontWeight.w700,
  letterSpacing: -1,
  // fontFamily: "MonumentExt",
);

const TextStyle chooserStyle = TextStyle(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.w600,
  letterSpacing: -1
);

TextStyle navStyle = TextStyle(
  color: Colors.white.withOpacity(0.3),
  fontWeight: FontWeight.w600,
  letterSpacing: -0.6,
  fontSize: 12,
);

TextStyle navStyleSelected = TextStyle(
  color: Colors.blueAccent,
  fontWeight: FontWeight.w600,
  letterSpacing: -0.6,
  fontSize: 12,
);

TextStyle navStyleSpecial = TextStyle(
  color: Colors.redAccent,
  fontWeight: FontWeight.w600,
  letterSpacing: -0.6,
  fontSize: 12,
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

  String navPos = "gen";

  String sportsCountry = "in";
  String businessCountry = "in";

  String generalCountry = "in";

  String countryTitle = "India";

  void _changeGlobalState(String code, String title) {
    setState(() {
      sportsCountry = code;
      businessCountry = code;
      generalCountry = code;

      countryTitle = title;
    });
  }

  Future refresh() async {
    setState(() {
      countryTitle = countryTitle;
      generalCountry = generalCountry;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic src = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xFF222222),
      body: Stack(
        fit: StackFit.expand,
        children: [
          navPos == "gen" ? RefreshIndicator(
            onRefresh: refresh,
            displacement: 70,
            edgeOffset: 70,
            color: Color(0xFF333333),
            backgroundColor: Colors.black54,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 100, bottom: 50),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30, top: 20),
                    child: Row(
                      children: [
                        Text(
                          "General",
                          style: TextStyle(
                              fontFamily: "MonumentExt",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              // letterSpacing: -1.34,
                              fontSize: 24
                          ),
                        ),
                        Expanded(child: SizedBox(height: 1))
                      ],
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.only(top: 90),
                    width: MediaQuery.of(context).size.width,
                    height: 295,
                    child: FutureBuilder(
                        future: NetworkSystem().contentBuilder(generalCountry, "general"),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CupertinoActivityIndicator(color: Colors.white.withOpacity(0.7)));
                          } else {
                            return Container(
                              margin: EdgeInsets.only(top: 14),
                              height: 200,
                              width: src.width,
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
                    builder: (BuildContext context, StateSetter setBizState) {
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
                                      showMaterialModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setModalState) {
                                            return Container(
                                                padding: EdgeInsets.only(top: 20),
                                                clipBehavior: Clip.hardEdge,
                                                // padding: EdgeInsets.all(24),
                                                height: 560,
                                                decoration: ShapeDecoration(
                                                  // color: Color(0xFF1C1C1E),
                                                  shape: SmoothRectangleBorder(
                                                    borderRadius: SmoothBorderRadius(
                                                      cornerRadius: 26,
                                                      cornerSmoothing: 0.9,
                                                    ),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text("🏳️ Choose A Region",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w700,
                                                          letterSpacing: -1,
                                                          fontSize: 18
                                                      ),
                                                    ),
                                                    SizedBox(height: 6),
                                                    Text("Changing Specific Section",
                                                      style: TextStyle(
                                                          color: Colors.white.withOpacity(0.5),
                                                          fontWeight: FontWeight.w600,
                                                          letterSpacing: -1,
                                                          fontSize: 13
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            // _changeGlobalState("in", "India");
                                                            setModalState(() {
                                                              // _changeGlobalState("in", "India");
                                                              countryTitle = "India";
                                                              businessCountry = "in";
                                                            });
                                                            setBizState(() {
                                                              businessCountry = "in";
                                                              countryTitle = "India";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width - 45,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 15, right: 20),
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
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                businessCountry == "in" ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blueAccent, size: 25) : Icon(CupertinoIcons.circle, size: 25, color: Colors.grey),
                                                                Text("India  🇮🇳",
                                                                  style: chooserStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // _changeGlobalState("in", "India");
                                                            setModalState(() {
                                                              // _changeGlobalState("in", "India");
                                                              countryTitle = "USA";
                                                              businessCountry = "us";
                                                            });
                                                            setBizState(() {
                                                              businessCountry = "us";
                                                              countryTitle = "USA";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width - 45,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 15, right: 20),
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
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                businessCountry == "us" ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blueAccent, size: 25) : Icon(CupertinoIcons.circle, size: 25, color: Colors.grey),
                                                                Text("USA  🇺🇸",
                                                                  style: chooserStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // _changeGlobalState("in", "India");
                                                            setModalState(() {
                                                              // _changeGlobalState("in", "India");
                                                              countryTitle = "UK";
                                                              businessCountry = "gb";
                                                            });
                                                            setBizState(() {
                                                              businessCountry = "gb";
                                                              countryTitle = "UK";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width - 45,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 15, right: 20),
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
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                businessCountry == "gb" ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blueAccent, size: 25) : Icon(CupertinoIcons.circle, size: 25, color: Colors.grey),
                                                                Text("United Kingdom  🇬🇧",
                                                                  style: chooserStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // _changeGlobalState("in", "India");
                                                            setModalState(() {
                                                              // _changeGlobalState("in", "India");
                                                              countryTitle = "United Arab Emirates";
                                                              businessCountry = "ae";
                                                            });
                                                            setBizState(() {
                                                              businessCountry = "ae";
                                                              countryTitle = "United Arab Emirates";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width - 45,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 15, right: 20),
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
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                businessCountry == "ae" ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blueAccent, size: 25) : Icon(CupertinoIcons.circle, size: 25, color: Colors.grey),
                                                                Text("United Arab Emirates  🇦🇪",
                                                                  style: chooserStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // _changeGlobalState("in", "India");
                                                            setModalState(() {
                                                              // _changeGlobalState("in", "India");
                                                              countryTitle = "Singapore";
                                                              businessCountry = "sg";
                                                            });
                                                            setBizState(() {
                                                              businessCountry = "sg";
                                                              countryTitle = "Singapore";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width - 45,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 15, right: 20),
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
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                businessCountry == "sg" ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blueAccent, size: 25) : Icon(CupertinoIcons.circle, size: 25, color: Colors.grey),
                                                                Text("Singapore  🇸🇬",
                                                                  style: chooserStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // _changeGlobalState("in", "India");
                                                            setModalState(() {
                                                              // _changeGlobalState("in", "India");
                                                              countryTitle = "Canada";
                                                              businessCountry = "ca";
                                                            });
                                                            setBizState(() {
                                                              businessCountry = "ca";
                                                              countryTitle = "Canada";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width - 45,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 15, right: 20),
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
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                businessCountry == "ca" ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blueAccent, size: 25) : Icon(CupertinoIcons.circle, size: 25, color: Colors.grey),
                                                                Text("Canada  🇨🇦",
                                                                  style: chooserStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                            ).frosted(
                                                blur: 30,
                                                borderRadius: BorderRadius.circular(30),
                                                frostColor: Colors.black38,
                                                frostOpacity: 0.3
                                            );
                                          },
                                        ),
                                      );
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
                                          Text(countryTitle,
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(snapshot.data![index].title,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                                letterSpacing: -0.6,
                                                                fontSize: 13
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(snapshot.data![index].source,
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          )
                                                        ],
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
                                      showMaterialModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (context) => StatefulBuilder(
                                          builder: (BuildContext context, StateSetter setModalState) {
                                            return Container(
                                                padding: EdgeInsets.only(top: 20),
                                                clipBehavior: Clip.hardEdge,
                                                // padding: EdgeInsets.all(24),
                                                height: 560,
                                                decoration: ShapeDecoration(
                                                  // color: Color(0xFF1C1C1E),
                                                  shape: SmoothRectangleBorder(
                                                    borderRadius: SmoothBorderRadius(
                                                      cornerRadius: 26,
                                                      cornerSmoothing: 0.9,
                                                    ),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    Text("🏳️ Choose A Region",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w700,
                                                          letterSpacing: -1,
                                                          fontSize: 18
                                                      ),
                                                    ),
                                                    SizedBox(height: 6),
                                                    Text("Changing Specific Section",
                                                      style: TextStyle(
                                                          color: Colors.white.withOpacity(0.5),
                                                          fontWeight: FontWeight.w600,
                                                          letterSpacing: -1,
                                                          fontSize: 13
                                                      ),
                                                    ),
                                                    SizedBox(height: 20),
                                                    Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            // _changeGlobalState("in", "India");
                                                            setModalState(() {
                                                              // _changeGlobalState("in", "India");
                                                              countryTitle = "India";
                                                              sportsCountry = "in";
                                                            });
                                                            setSportState(() {
                                                              sportsCountry = "in";
                                                              countryTitle = "India";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width - 45,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 15, right: 20),
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
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                sportsCountry == "in" ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blueAccent, size: 25) : Icon(CupertinoIcons.circle, size: 25, color: Colors.grey),
                                                                Text("India  🇮🇳",
                                                                  style: chooserStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // _changeGlobalState("in", "India");
                                                            setModalState(() {
                                                              // _changeGlobalState("in", "India");
                                                              countryTitle = "USA";
                                                              sportsCountry = "us";
                                                            });
                                                            setSportState(() {
                                                              sportsCountry = "us";
                                                              countryTitle = "USA";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width - 45,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 15, right: 20),
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
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                sportsCountry == "us" ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blueAccent, size: 25) : Icon(CupertinoIcons.circle, size: 25, color: Colors.grey),
                                                                Text("USA  🇺🇸",
                                                                  style: chooserStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // _changeGlobalState("in", "India");
                                                            setModalState(() {
                                                              // _changeGlobalState("in", "India");
                                                              countryTitle = "UK";
                                                              sportsCountry = "gb";
                                                            });
                                                            setSportState(() {
                                                              sportsCountry = "gb";
                                                              countryTitle = "UK";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width - 45,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 15, right: 20),
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
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                sportsCountry == "gb" ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blueAccent, size: 25) : Icon(CupertinoIcons.circle, size: 25, color: Colors.grey),
                                                                Text("United Kingdom  🇬🇧",
                                                                  style: chooserStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // _changeGlobalState("in", "India");
                                                            setModalState(() {
                                                              // _changeGlobalState("in", "India");
                                                              countryTitle = "United Arab Emirates";
                                                              sportsCountry = "ae";
                                                            });
                                                            setSportState(() {
                                                              sportsCountry = "ae";
                                                              countryTitle = "United Arab Emirates";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width - 45,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 15, right: 20),
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
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                sportsCountry == "ae" ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blueAccent, size: 25) : Icon(CupertinoIcons.circle, size: 25, color: Colors.grey),
                                                                Text("United Arab Emirates  🇦🇪",
                                                                  style: chooserStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // _changeGlobalState("in", "India");
                                                            setModalState(() {
                                                              // _changeGlobalState("in", "India");
                                                              countryTitle = "Singapore";
                                                              sportsCountry = "sg";
                                                            });
                                                            setSportState(() {
                                                              sportsCountry = "sg";
                                                              countryTitle = "Singapore";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width - 45,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 15, right: 20),
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
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                sportsCountry == "sg" ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blueAccent, size: 25) : Icon(CupertinoIcons.circle, size: 25, color: Colors.grey),
                                                                Text("Singapore  🇸🇬",
                                                                  style: chooserStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            // _changeGlobalState("in", "India");
                                                            setModalState(() {
                                                              // _changeGlobalState("in", "India");
                                                              countryTitle = "Canada";
                                                              sportsCountry = "ca";
                                                            });
                                                            setSportState(() {
                                                              sportsCountry = "ca";
                                                              countryTitle = "Canada";
                                                            });
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width - 45,
                                                            margin: EdgeInsets.only(bottom: 10),
                                                            height: 60,
                                                            padding: EdgeInsets.only(left: 15, right: 20),
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
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                sportsCountry == "ca" ? Icon(CupertinoIcons.check_mark_circled_solid, color: Colors.blueAccent, size: 25) : Icon(CupertinoIcons.circle, size: 25, color: Colors.grey),
                                                                Text("Canada  🇨🇦",
                                                                  style: chooserStyle,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                            ).frosted(
                                                blur: 30,
                                                borderRadius: BorderRadius.circular(30),
                                                frostColor: Colors.black38,
                                                frostOpacity: 0.3
                                            );
                                          },
                                        ),
                                      );
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
                                          Text(countryTitle,
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(snapshot.data![index].title,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                                letterSpacing: -0.6,
                                                                fontSize: 13
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(snapshot.data![index].source,
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          )
                                                        ],
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
          )
          : navPos == "biz" ? RefreshIndicator(
            onRefresh: refresh,
            displacement: 70,
            edgeOffset: 70,
            color: Color(0xFF333333),
            backgroundColor: Colors.black54,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 100, bottom: 90),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30, top: 20),
                    child: Row(
                      children: [
                        Text(
                          "Business",
                          style: TextStyle(
                              fontFamily: "MonumentExt",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              // letterSpacing: -1.34,
                              fontSize: 24
                          ),
                        ),
                        Expanded(child: SizedBox(height: 1))
                      ],
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.only(top: 90),
                    width: MediaQuery.of(context).size.width,
                    height: 295,
                    child: FutureBuilder(
                        future: NetworkSystem().contentBuilder("in", "business"),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CupertinoActivityIndicator(color: Colors.white.withOpacity(0.7)));
                          } else {
                            return Container(
                              margin: EdgeInsets.only(top: 14),
                              height: 200,
                              width: src.width,
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
                    builder: (BuildContext context, StateSetter setBizState) {
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
                                children: [
                                  Text("Trending In India", style: titleStyle),
                                  Expanded(child: SizedBox(height: 1))
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            FutureBuilder(
                                future: NetworkSystem().overCall("in", "business"),
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(snapshot.data![index].title,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                                letterSpacing: -0.6,
                                                                fontSize: 13
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(snapshot.data![index].source,
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          )
                                                        ],
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
                    builder: (BuildContext context, StateSetter setBizState) {
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
                                children: [
                                  Text("Trending In USA", style: titleStyle),
                                  Expanded(child: SizedBox(height: 1))
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            FutureBuilder(
                                future: NetworkSystem().overCall("us", "business"),
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(snapshot.data![index].title,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                                letterSpacing: -0.6,
                                                                fontSize: 13
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(snapshot.data![index].source,
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          )
                                                        ],
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
                    builder: (BuildContext context, StateSetter setBizState) {
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
                                children: [
                                  Text("Trending In UK", style: titleStyle),
                                  Expanded(child: SizedBox(height: 1))
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            FutureBuilder(
                                future: NetworkSystem().overCall("gb", "business"),
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(snapshot.data![index].title,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                                letterSpacing: -0.6,
                                                                fontSize: 13
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(snapshot.data![index].source,
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          )
                                                        ],
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
                    builder: (BuildContext context, StateSetter setBizState) {
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
                                children: [
                                  Text("Trending In Singapore", style: titleStyle),
                                  Expanded(child: SizedBox(height: 1))
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            FutureBuilder(
                                future: NetworkSystem().overCall("sg", "business"),
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(snapshot.data![index].title,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                                letterSpacing: -0.6,
                                                                fontSize: 13
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(snapshot.data![index].source,
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          )
                                                        ],
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
                    builder: (BuildContext context, StateSetter setBizState) {
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
                                children: [
                                  Text("Trending In Canada", style: titleStyle),
                                  Expanded(child: SizedBox(height: 1))
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            FutureBuilder(
                                future: NetworkSystem().overCall("ca", "business"),
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(snapshot.data![index].title,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                                letterSpacing: -0.6,
                                                                fontSize: 13
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(snapshot.data![index].source,
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          )
                                                        ],
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
          )
          : navPos == "spo" ? RefreshIndicator(
            onRefresh: refresh,
            displacement: 70,
            edgeOffset: 70,
            color: Color(0xFF333333),
            backgroundColor: Colors.black54,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 100, bottom: 90),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 30, top: 20),
                    child: Row(
                      children: [
                        Text(
                          "Sports",
                          style: TextStyle(
                              fontFamily: "MonumentExt",
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              // letterSpacing: -1.34,
                              fontSize: 24
                          ),
                        ),
                        Expanded(child: SizedBox(height: 1))
                      ],
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.only(top: 90),
                    width: MediaQuery.of(context).size.width,
                    height: 295,
                    child: FutureBuilder(
                        future: NetworkSystem().contentBuilder("in", "sport"),
                        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CupertinoActivityIndicator(color: Colors.white.withOpacity(0.7)));
                          } else {
                            return Container(
                              margin: EdgeInsets.only(top: 14),
                              height: 200,
                              width: src.width,
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
                    builder: (BuildContext context, StateSetter setBizState) {
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
                                children: [
                                  Text("Trending In India", style: titleStyle),
                                  Expanded(child: SizedBox(height: 1))
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            FutureBuilder(
                                future: NetworkSystem().overCall("in", "sport"),
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(snapshot.data![index].title,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                                letterSpacing: -0.6,
                                                                fontSize: 13
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(snapshot.data![index].source,
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          )
                                                        ],
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
                    builder: (BuildContext context, StateSetter setBizState) {
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
                                children: [
                                  Text("Trending In USA", style: titleStyle),
                                  Expanded(child: SizedBox(height: 1))
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            FutureBuilder(
                                future: NetworkSystem().overCall("us", "sport"),
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(snapshot.data![index].title,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                                letterSpacing: -0.6,
                                                                fontSize: 13
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(snapshot.data![index].source,
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          )
                                                        ],
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
                    builder: (BuildContext context, StateSetter setBizState) {
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
                                children: [
                                  Text("Trending In UK", style: titleStyle),
                                  Expanded(child: SizedBox(height: 1))
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            FutureBuilder(
                                future: NetworkSystem().overCall("gb", "sport"),
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(snapshot.data![index].title,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                                letterSpacing: -0.6,
                                                                fontSize: 13
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(snapshot.data![index].source,
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          )
                                                        ],
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
                    builder: (BuildContext context, StateSetter setBizState) {
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
                                children: [
                                  Text("Trending In Singapore", style: titleStyle),
                                  Expanded(child: SizedBox(height: 1))
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            FutureBuilder(
                                future: NetworkSystem().overCall("sg", "sport"),
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(snapshot.data![index].title,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                                letterSpacing: -0.6,
                                                                fontSize: 13
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(snapshot.data![index].source,
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          )
                                                        ],
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
                    builder: (BuildContext context, StateSetter setBizState) {
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
                                children: [
                                  Text("Trending In Canada", style: titleStyle),
                                  Expanded(child: SizedBox(height: 1))
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            FutureBuilder(
                                future: NetworkSystem().overCall("ca", "sport"),
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
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Text(snapshot.data![index].title,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                overflow: TextOverflow.ellipsis,
                                                                letterSpacing: -0.6,
                                                                fontSize: 13
                                                            ),
                                                          ),
                                                          SizedBox(height: 3),
                                                          Text(snapshot.data![index].source,
                                                            style: TextStyle(
                                                                overflow: TextOverflow.ellipsis,
                                                                color: Colors.grey,
                                                                fontSize: 12,
                                                                fontWeight: FontWeight.w500
                                                            ),
                                                          )
                                                        ],
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
          )
          : Text("dd")
          ,
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(top: 15),
              width: src.width,
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2)))
              ),
              height: 96,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        navPos = "biz";
                      });
                    },
                    child: _CupertinoClick(CupertinoIcons.graph_circle_fill, "Business", "biz")
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          navPos = "spo";
                        });
                      },
                    child: _CupertinoClick(Icons.run_circle_rounded, "Sports", "spo")
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          navPos = "gen";
                        });
                      },
                    child: _CupertinoClick(CupertinoIcons.cube_box_fill, "General", "gen")
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          navPos = "ent";
                        });
                      },
                    child: _CupertinoClick(CupertinoIcons.tv, "Culture", "ent")
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          navPos = "tch";
                        });
                      },
                    child: _CupertinoClick(CupertinoIcons.keyboard, "Tech", "tch")
                  ),
                ],
              ),
            ).frosted(
              blur: 20,
              frostColor: Colors.black,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.only(top: 40, left: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2)))
              ),
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
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 3),
                    child: Text("News",
                      style: TextStyle(
                        fontFamily: "MonumentExt",
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 19
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox(height: 10)),
                ],
              ),
            ).frosted(
              blur: 20,
              frostColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  _CupertinoClick(IconData icon, String navText, String categ) {
    return Container(
      width: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: categ == navPos ? Colors.blueAccent : Colors.grey.withOpacity(0.3)),
          SizedBox(height: 2),
          Text(navText,
            style: categ == navPos ? navStyleSelected : navStyle
          )
        ],
      ),
    );
  }

  _StateOverrideCallBack(String countryTitle, String countryCode, String categ) {
    return StatefulBuilder(
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
                child: Text(countryTitle, style: titleStyle),
              ),
              SizedBox(height: 2),
              FutureBuilder(
                  future: NetworkSystem().contentBuilder(countryCode, categ),
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
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(snapshot.data![index].title,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  overflow: TextOverflow.ellipsis,
                                                  letterSpacing: -0.6,
                                                  fontSize: 13
                                              ),
                                            ),
                                            SizedBox(height: 3),
                                            Text(snapshot.data![index].source,
                                              style: TextStyle(
                                                  overflow: TextOverflow.ellipsis,
                                                  color: Colors.grey,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500
                                              ),
                                            )
                                          ],
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

  // final controller = new PageController(initialPage: 999);

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
            foregroundDecoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.4],
              ),
            ),
            child: Hero(
              tag: "pv-img",
              child: Container(
                padding: EdgeInsets.only(top: 50, left: 20),
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
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
                    SizedBox(height: 10),
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
                                child: Icon(CupertinoIcons.cube, color: Colors.white, size: 20,),
                                onPressed: () {
                                  showMaterialModalBottomSheet(
                                      context: context,
                                      expand: true,
                                      enableDrag: false,
                                      builder: (context) => Container(
                                        height: src.height,
                                        width: src.width,
                                        child: Stack(
                                          children: [
                                            ImageFiltered(
                                              imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                                              child: Container(
                                                // padding: EdgeInsets.only(top: 70, left: 10, right: 10),
                                                height: MediaQuery.of(context).size.height,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(data.imgURL)
                                                    )
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: MediaQuery.of(context).size.height,
                                              color: Colors.black.withOpacity(0.2),
                                            ),
                                            PageView(
                                              physics: const ClampingScrollPhysics(),
                                              // controller: controller,
                                              children: [
                                                Container(
                                                  width: src.width,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: src.width - 70,
                                                        width: src.width - 70,
                                                        decoration: ShapeDecoration(
                                                          image: DecorationImage(
                                                            image: NetworkImage(data.imgURL),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          color: Colors.grey.withOpacity(0.75),
                                                          shape: SmoothRectangleBorder(
                                                            borderRadius: SmoothBorderRadius(
                                                              cornerRadius: 20,
                                                              cornerSmoothing: 0.9,
                                                            ),
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
                                                        ),
                                                      ),
                                                      SizedBox(height: 15),
                                                      SizedBox(
                                                        width: src.width - 90,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(data.title,
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.w700,
                                                                  fontSize: 18,
                                                                  letterSpacing: -0.5,
                                                                  color: Colors.white
                                                              ),
                                                            ),
                                                            SizedBox(height: 7),
                                                            Text(data.source,
                                                              style: TextStyle(
                                                                  color: Colors.white.withOpacity(0.6),
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 16,
                                                                  letterSpacing: -0.75
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: src.width,
                                                  child: Center(
                                                    child: SizedBox(
                                                      width: src.width - 60,
                                                      child: ListView(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        children: [
                                                          Container(
                                                            // height: 500,
                                                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withOpacity(0.1),
                                                              shape: SmoothRectangleBorder(
                                                                borderRadius: SmoothBorderRadius(
                                                                  cornerRadius: 20,
                                                                  cornerSmoothing: 0.9,
                                                                ),
                                                              ),
                                                              shadows: const [
                                                                BoxShadow(
                                                                    color: Colors.black12,
                                                                    blurRadius: 30.0,
                                                                    spreadRadius: 5,
                                                                    offset: Offset(
                                                                        0,
                                                                        10
                                                                    )
                                                                )
                                                              ],
                                                            ),
                                                            child: Column(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  height: src.width - 70,
                                                                  width: src.width - 70,
                                                                  decoration: ShapeDecoration(
                                                                    image: DecorationImage(
                                                                      image: NetworkImage(data.imgURL),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                    color: Colors.grey.withOpacity(0.75),
                                                                    shape: SmoothRectangleBorder(
                                                                      borderRadius: SmoothBorderRadius(
                                                                        cornerRadius: 20,
                                                                        cornerSmoothing: 0.9,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(height: 15),
                                                                SizedBox(
                                                                  width: src.width - 90,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Text(data.title,
                                                                        style: TextStyle(
                                                                            fontWeight: FontWeight.w700,
                                                                            fontSize: 18,
                                                                            letterSpacing: -0.5,
                                                                            color: Colors.white
                                                                        ),
                                                                      ),
                                                                      SizedBox(height: 7),
                                                                      Text(data.source,
                                                                        style: TextStyle(
                                                                            color: Colors.white.withOpacity(0.6),
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 16,
                                                                            letterSpacing: -0.75
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: src.width,
                                                  child: Center(
                                                    child: SizedBox(
                                                      width: src.width - 60,
                                                      child: ListView(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.only(bottom: 15),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withOpacity(0.1),
                                                              shape: SmoothRectangleBorder(
                                                                borderRadius: SmoothBorderRadius(
                                                                  cornerRadius: 20,
                                                                  cornerSmoothing: 0.9,
                                                                ),
                                                              ),
                                                              shadows: const [
                                                                BoxShadow(
                                                                    color: Colors.black12,
                                                                    blurRadius: 30.0,
                                                                    spreadRadius: 5,
                                                                    offset: Offset(
                                                                        0,
                                                                        10
                                                                    )
                                                                )
                                                              ],
                                                            ),
                                                            clipBehavior: Clip.hardEdge,
                                                            child: Column(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  height: src.width - 70,
                                                                  // width: src.width - 70,
                                                                  decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: NetworkImage(data.imgURL),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                    color: Colors.grey.withOpacity(0.75),
                                                                  ),
                                                                ),
                                                                SizedBox(height: 15),
                                                                SizedBox(
                                                                  width: src.width - 90,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Padding(
                                                                        child: Text(data.title,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 18,
                                                                              letterSpacing: -0.5,
                                                                              color: Colors.white
                                                                          ),
                                                                        ),
                                                                        padding: EdgeInsets.symmetric(horizontal: 2),
                                                                      ),
                                                                      SizedBox(height: 7),
                                                                      Padding(
                                                                        child: Text(data.source,
                                                                          style: TextStyle(
                                                                            color: Colors.white.withOpacity(0.6),
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 16,
                                                                            letterSpacing: -0.75
                                                                          ),
                                                                        ),
                                                                        padding: EdgeInsets.only(left: 4),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: src.width,
                                                  child: Center(
                                                    child: SizedBox(
                                                      width: src.width - 60,
                                                      child: ListView(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.only(top: 15),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withOpacity(0.1),
                                                              shape: SmoothRectangleBorder(
                                                                borderRadius: SmoothBorderRadius(
                                                                  cornerRadius: 20,
                                                                  cornerSmoothing: 0.9,
                                                                ),
                                                              ),
                                                              shadows: const [
                                                                BoxShadow(
                                                                    color: Colors.black12,
                                                                    blurRadius: 30.0,
                                                                    spreadRadius: 5,
                                                                    offset: Offset(
                                                                        0,
                                                                        10
                                                                    )
                                                                )
                                                              ],
                                                            ),
                                                            clipBehavior: Clip.hardEdge,
                                                            child: Column(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                SizedBox(
                                                                  width: src.width - 90,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Padding(
                                                                        child: Text(data.title,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 18,
                                                                              letterSpacing: -0.5,
                                                                              color: Colors.white
                                                                          ),
                                                                        ),
                                                                        padding: EdgeInsets.symmetric(horizontal: 2),
                                                                      ),
                                                                      SizedBox(height: 7),
                                                                      Padding(
                                                                        child: Text(data.source,
                                                                          style: TextStyle(
                                                                              color: Colors.white.withOpacity(0.6),
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 16,
                                                                              letterSpacing: -0.75
                                                                          ),
                                                                        ),
                                                                        padding: EdgeInsets.only(left: 4),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(height: 15),
                                                                Container(
                                                                  height: src.width - 70,
                                                                  // width: src.width - 70,
                                                                  decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: NetworkImage(data.imgURL),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                    color: Colors.grey.withOpacity(0.75),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: src.width,
                                                  child: Center(
                                                    child: SizedBox(
                                                      width: src.width - 60,
                                                      child: ListView(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.only(top: 15),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withOpacity(0.1),
                                                              shape: SmoothRectangleBorder(
                                                                borderRadius: SmoothBorderRadius(
                                                                  cornerRadius: 20,
                                                                  cornerSmoothing: 0.9,
                                                                ),
                                                              ),
                                                              shadows: const [
                                                                BoxShadow(
                                                                    color: Colors.black12,
                                                                    blurRadius: 30.0,
                                                                    spreadRadius: 5,
                                                                    offset: Offset(
                                                                        0,
                                                                        10
                                                                    )
                                                                )
                                                              ],
                                                            ),
                                                            clipBehavior: Clip.hardEdge,
                                                            child: Column(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                SizedBox(
                                                                  width: src.width - 90,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Padding(
                                                                        child: Text(data.title,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 18,
                                                                              letterSpacing: -0.5,
                                                                              color: Colors.white
                                                                          ),
                                                                        ),
                                                                        padding: EdgeInsets.symmetric(horizontal: 2),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(height: 15),
                                                                Container(
                                                                  height: src.width - 70,
                                                                  // width: src.width - 70,
                                                                  decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: NetworkImage(data.imgURL),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                    color: Colors.grey.withOpacity(0.75),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      child: Text(data.source,
                                                                        style: TextStyle(
                                                                            color: Colors.white.withOpacity(0.6),
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 16,
                                                                            letterSpacing: -0.75
                                                                        ),
                                                                      ),
                                                                      padding: EdgeInsets.only(left: 15, top: 12, bottom: 12),
                                                                    ),
                                                                    SizedBox(height: 1)
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: src.width,
                                                  child: Center(
                                                    child: SizedBox(
                                                      width: src.width - 60,
                                                      child: ListView(
                                                        physics: NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.only(top: 15),
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withOpacity(0.1),
                                                              shape: SmoothRectangleBorder(
                                                                borderRadius: SmoothBorderRadius(
                                                                  cornerRadius: 20,
                                                                  cornerSmoothing: 0.9,
                                                                ),
                                                              ),
                                                              shadows: const [
                                                                BoxShadow(
                                                                    color: Colors.black12,
                                                                    blurRadius: 30.0,
                                                                    spreadRadius: 5,
                                                                    offset: Offset(
                                                                        0,
                                                                        10
                                                                    )
                                                                )
                                                              ],
                                                            ),
                                                            clipBehavior: Clip.hardEdge,
                                                            child: Column(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Padding(
                                                                      child: Text(data.source,
                                                                        style: TextStyle(
                                                                            color: Colors.white.withOpacity(0.6),
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 16,
                                                                            letterSpacing: -0.75
                                                                        ),
                                                                      ),
                                                                      padding: EdgeInsets.only(left: 18),
                                                                    ),
                                                                    SizedBox(height: 1)
                                                                  ],
                                                                ),
                                                                SizedBox(height: 15),
                                                                Container(
                                                                  height: src.width - 70,
                                                                  // height: 180,
                                                                  // width: src.width - 70,
                                                                  decoration: BoxDecoration(
                                                                    image: DecorationImage(
                                                                      image: NetworkImage(data.imgURL),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                    color: Colors.grey.withOpacity(0.75),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: src.width - 90,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Padding(
                                                                        child: Text(data.title,
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w700,
                                                                              fontSize: 18,
                                                                              letterSpacing: -0.5,
                                                                              color: Colors.white
                                                                          ),
                                                                        ),
                                                                        padding: EdgeInsets.only(bottom: 16, top: 16, left: 6),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                  );
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
                    SizedBox(height: 10),
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
                                child: Icon(CupertinoIcons.share, color: Colors.white, size: 20,),
                                onPressed: () {
                                  Share.share(data.url, subject: data.title);
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
                width: src.width,
                height: 290,
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
            padding: EdgeInsets.only(left: 20, top: 10, right: 15),
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
                        fontSize: 19,
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
            padding: EdgeInsets.only(left: 20, top: 6, right: 15),
            child: Text(
              data.content,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  letterSpacing: -1
              ),
            ),
          ) : SizedBox(),
          data.content != "No Content Available." ? Row(
            children: [
              SizedBox(
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).push(_createRoute(data.url, data.source));
                  },
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Read Full Article",
                    style: TextStyle(
                        color: Colors.blueAccent,
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
            foregroundDecoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black54,
                  Colors.transparent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 0.4],
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 50, left: 20),
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                    ]
                ),
                child: Column(
              children: [
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
          SizedBox(height: 10),
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
                      child: Icon(CupertinoIcons.cube, color: Colors.white, size: 20,),
                      onPressed: () {
                        showMaterialModalBottomSheet(
                            context: context,
                            expand: true,
                            enableDrag: false,
                            builder: (context) => Container(
                              height: src.height,
                              width: src.width,
                              child: Stack(
                                children: [
                                  ImageFiltered(
                                    imageFilter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                                    child: Container(
                                      // padding: EdgeInsets.only(top: 70, left: 10, right: 10),
                                      height: MediaQuery.of(context).size.height,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(data.imgURL)
                                          )
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                  PageView(
                                    physics: const ClampingScrollPhysics(),
                                    // controller: ,
                                    children: [
                                      Container(
                                        width: src.width,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: src.width - 70,
                                              width: src.width - 70,
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(data.imgURL),
                                                  fit: BoxFit.cover,
                                                ),
                                                color: Colors.grey.withOpacity(0.75),
                                                shape: SmoothRectangleBorder(
                                                  borderRadius: SmoothBorderRadius(
                                                    cornerRadius: 20,
                                                    cornerSmoothing: 0.9,
                                                  ),
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
                                              ),
                                            ),
                                            SizedBox(height: 15),
                                            SizedBox(
                                              width: src.width - 90,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(data.title,
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18,
                                                        letterSpacing: -0.5,
                                                        color: Colors.white
                                                    ),
                                                  ),
                                                  SizedBox(height: 7),
                                                  Text(data.source,
                                                    style: TextStyle(
                                                        color: Colors.white.withOpacity(0.6),
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 16,
                                                        letterSpacing: -0.75
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: src.width,
                                        child: Center(
                                          child: SizedBox(
                                            width: src.width - 60,
                                            child: ListView(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              children: [
                                                Container(
                                                  // height: 500,
                                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white.withOpacity(0.1),
                                                    shape: SmoothRectangleBorder(
                                                      borderRadius: SmoothBorderRadius(
                                                        cornerRadius: 20,
                                                        cornerSmoothing: 0.9,
                                                      ),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 30.0,
                                                          spreadRadius: 5,
                                                          offset: Offset(
                                                              0,
                                                              10
                                                          )
                                                      )
                                                    ],
                                                  ),
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: src.width - 70,
                                                        width: src.width - 70,
                                                        decoration: ShapeDecoration(
                                                          image: DecorationImage(
                                                            image: NetworkImage(data.imgURL),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          color: Colors.grey.withOpacity(0.75),
                                                          shape: SmoothRectangleBorder(
                                                            borderRadius: SmoothBorderRadius(
                                                              cornerRadius: 20,
                                                              cornerSmoothing: 0.9,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 15),
                                                      SizedBox(
                                                        width: src.width - 90,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(data.title,
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.w700,
                                                                  fontSize: 18,
                                                                  letterSpacing: -0.5,
                                                                  color: Colors.white
                                                              ),
                                                            ),
                                                            SizedBox(height: 7),
                                                            Text(data.source,
                                                              style: TextStyle(
                                                                  color: Colors.white.withOpacity(0.6),
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 16,
                                                                  letterSpacing: -0.75
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: src.width,
                                        child: Center(
                                          child: SizedBox(
                                            width: src.width - 60,
                                            child: ListView(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(bottom: 15),
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white.withOpacity(0.1),
                                                    shape: SmoothRectangleBorder(
                                                      borderRadius: SmoothBorderRadius(
                                                        cornerRadius: 20,
                                                        cornerSmoothing: 0.9,
                                                      ),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 30.0,
                                                          spreadRadius: 5,
                                                          offset: Offset(
                                                              0,
                                                              10
                                                          )
                                                      )
                                                    ],
                                                  ),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: src.width - 70,
                                                        // width: src.width - 70,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: NetworkImage(data.imgURL),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          color: Colors.grey.withOpacity(0.75),
                                                        ),
                                                      ),
                                                      SizedBox(height: 15),
                                                      SizedBox(
                                                        width: src.width - 90,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              child: Text(data.title,
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 18,
                                                                    letterSpacing: -0.5,
                                                                    color: Colors.white
                                                                ),
                                                              ),
                                                              padding: EdgeInsets.symmetric(horizontal: 2),
                                                            ),
                                                            SizedBox(height: 7),
                                                            Padding(
                                                              child: Text(data.source,
                                                                style: TextStyle(
                                                                    color: Colors.white.withOpacity(0.6),
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 16,
                                                                    letterSpacing: -0.75
                                                                ),
                                                              ),
                                                              padding: EdgeInsets.only(left: 4),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: src.width,
                                        child: Center(
                                          child: SizedBox(
                                            width: src.width - 60,
                                            child: ListView(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(top: 15),
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white.withOpacity(0.1),
                                                    shape: SmoothRectangleBorder(
                                                      borderRadius: SmoothBorderRadius(
                                                        cornerRadius: 20,
                                                        cornerSmoothing: 0.9,
                                                      ),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 30.0,
                                                          spreadRadius: 5,
                                                          offset: Offset(
                                                              0,
                                                              10
                                                          )
                                                      )
                                                    ],
                                                  ),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: src.width - 90,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              child: Text(data.title,
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 18,
                                                                    letterSpacing: -0.5,
                                                                    color: Colors.white
                                                                ),
                                                              ),
                                                              padding: EdgeInsets.symmetric(horizontal: 2),
                                                            ),
                                                            SizedBox(height: 7),
                                                            Padding(
                                                              child: Text(data.source,
                                                                style: TextStyle(
                                                                    color: Colors.white.withOpacity(0.6),
                                                                    fontWeight: FontWeight.w600,
                                                                    fontSize: 16,
                                                                    letterSpacing: -0.75
                                                                ),
                                                              ),
                                                              padding: EdgeInsets.only(left: 4),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 15),
                                                      Container(
                                                        height: src.width - 70,
                                                        // width: src.width - 70,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: NetworkImage(data.imgURL),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          color: Colors.grey.withOpacity(0.75),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: src.width,
                                        child: Center(
                                          child: SizedBox(
                                            width: src.width - 60,
                                            child: ListView(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(top: 15),
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white.withOpacity(0.1),
                                                    shape: SmoothRectangleBorder(
                                                      borderRadius: SmoothBorderRadius(
                                                        cornerRadius: 20,
                                                        cornerSmoothing: 0.9,
                                                      ),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 30.0,
                                                          spreadRadius: 5,
                                                          offset: Offset(
                                                              0,
                                                              10
                                                          )
                                                      )
                                                    ],
                                                  ),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        width: src.width - 90,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              child: Text(data.title,
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 18,
                                                                    letterSpacing: -0.5,
                                                                    color: Colors.white
                                                                ),
                                                              ),
                                                              padding: EdgeInsets.symmetric(horizontal: 2),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(height: 15),
                                                      Container(
                                                        height: src.width - 70,
                                                        // width: src.width - 70,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: NetworkImage(data.imgURL),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          color: Colors.grey.withOpacity(0.75),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                                            child: Text(data.source,
                                                              style: TextStyle(
                                                                  color: Colors.white.withOpacity(0.6),
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 16,
                                                                  letterSpacing: -0.75
                                                              ),
                                                            ),
                                                            padding: EdgeInsets.only(left: 15, top: 12, bottom: 12),
                                                          ),
                                                          SizedBox(height: 1)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: src.width,
                                        child: Center(
                                          child: SizedBox(
                                            width: src.width - 60,
                                            child: ListView(
                                              physics: NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(top: 15),
                                                  decoration: ShapeDecoration(
                                                    color: Colors.white.withOpacity(0.1),
                                                    shape: SmoothRectangleBorder(
                                                      borderRadius: SmoothBorderRadius(
                                                        cornerRadius: 20,
                                                        cornerSmoothing: 0.9,
                                                      ),
                                                    ),
                                                    shadows: const [
                                                      BoxShadow(
                                                          color: Colors.black12,
                                                          blurRadius: 30.0,
                                                          spreadRadius: 5,
                                                          offset: Offset(
                                                              0,
                                                              10
                                                          )
                                                      )
                                                    ],
                                                  ),
                                                  clipBehavior: Clip.hardEdge,
                                                  child: Column(
                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                    // crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                                            child: Text(data.source,
                                                              style: TextStyle(
                                                                  color: Colors.white.withOpacity(0.6),
                                                                  fontWeight: FontWeight.w600,
                                                                  fontSize: 16,
                                                                  letterSpacing: -0.75
                                                              ),
                                                            ),
                                                            padding: EdgeInsets.only(left: 18),
                                                          ),
                                                          SizedBox(height: 1)
                                                        ],
                                                      ),
                                                      SizedBox(height: 15),
                                                      Container(
                                                        height: src.width - 70,
                                                        // height: 180,
                                                        // width: src.width - 70,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: NetworkImage(data.imgURL),
                                                            fit: BoxFit.cover,
                                                          ),
                                                          color: Colors.grey.withOpacity(0.75),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: src.width - 90,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              child: Text(data.title,
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 18,
                                                                    letterSpacing: -0.5,
                                                                    color: Colors.white
                                                                ),
                                                              ),
                                                              padding: EdgeInsets.only(bottom: 16, top: 16, left: 6),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                        );
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
          SizedBox(height: 10),
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
                      child: Icon(CupertinoIcons.share, color: Colors.white, size: 20,),
                      onPressed: () {
                        Share.share(data.url, subject: data.title);
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
            padding: EdgeInsets.only(left: 20, top: 10, right: 15),
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
            padding: EdgeInsets.only(left: 20, top: 6, right: 15),
            child: Text(
              data.content,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 17,
                letterSpacing: -1
              ),
            ),
          ) : SizedBox(),
          data.content != "No Content Available." ? Row(
            children: [
              SizedBox(
                child: CupertinoButton(
                  onPressed: () {
                    Navigator.of(context).push(_createRoute(data.url, data.source));
                  },
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Read Full Article",
                    style: TextStyle(
                        color: Colors.blueAccent,
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
    );
  }
}

Route _createRoute(String? urlData, String? source) {
  // print("DynamicLinkState Call: [501:04] : $urlData");
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 100),
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
