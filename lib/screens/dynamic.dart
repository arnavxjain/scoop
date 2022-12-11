import 'dart:ffi';
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:localstorage/localstorage.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scoop/model/model.dart';
import 'package:scoop/network/network.dart';
import 'package:scoop/screens/scoop.dart';
import 'package:scoop/screens/settings.dart';
import 'package:sheet/sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';


class DynamicLink extends StatefulWidget {
  const DynamicLink({Key? key, this.url, this.source}) : super(key: key);

  final String? url;
  final String? source;

  @override
  State<DynamicLink> createState() => _DynamicLinkState(this.url, this.source);
}

class _DynamicLinkState extends State<DynamicLink> {
  final String? url;
  final String? source;

  _DynamicLinkState(this.url, this.source);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 98),
            child: WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 40, left: 22, right: 22),
            height: 98,
            width: double.infinity,
            color: Color(0xFF222222),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(source.toString(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                    letterSpacing: -1
                  ),
                ),
                SizedBox(
                  width: 20,
                  child: CupertinoButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(CupertinoIcons.clear_circled_solid, color: Colors.white.withOpacity(0.8), size: 20,),
                    padding: EdgeInsets.zero,
                  ),
                )
              ],
            )
            // color: Colors.black.withOpacity(0.7),
          )
        ]
      ),
    );
  }
}
