import 'dart:ui';

import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scoop/model/model.dart';
import 'package:scoop/network/network.dart';
import 'package:sheet/sheet.dart';

class ScoopStream extends StatefulWidget {
  const ScoopStream({Key? key}) : super(key: key);

  @override
  State<ScoopStream> createState() => _ScoopStreamState();
}

class _ScoopStreamState extends State<ScoopStream> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-1,
        child: FutureBuilder(
          future: NetworkSystem().contentBuilder(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  Expanded(child: Center(child: CupertinoActivityIndicator(color: Colors.white.withOpacity(0.7),))),
                ],
              );
            } else {
              print(snapshot.data);
              List<Article> articles = snapshot.data!;
              return Expanded(
                child: Container(
                  // padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Scrollbar(
                    isAlwaysShown: true,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // print(snapshot.data![index].imgURL);

                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(snapshot.data![index].imgURL)
                            )
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  _systemize() {}

  _article(param0) {
    // print(param0.imgURL);
  //   return Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(30.0),
  //       image: DecorationImage(
  //           image: NetworkImage(
  //             param0.imgURL,
  //           ), fit: BoxFit.cover),
  //     ),
  //     child: BackdropFilter(
  //       filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
  //       child: Column(
  //         children: [
  //           Center(
  //             child: Text(param0.title),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

}
