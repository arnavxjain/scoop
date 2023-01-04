import 'dart:async';
import 'dart:ffi';
import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  _DynamicLinkState(this.url, this.source);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
        // For Android.
        // Use [light] for white status bar and [dark] for black status bar.
        statusBarIconBrightness: Brightness.dark,
        // For iOS.
        // Use [dark] for white status bar and [light] for black status bar.
        statusBarBrightness: Brightness.light,
    ),
    child: Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 70),
            child: WebView(
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.only(top: 10, left: 22, right: 22, bottom: 40),
              height: 90,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow:[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2), //color of shadow
                    spreadRadius: 14, //spread radius
                    blurRadius: 14, // blur radius
                    offset: Offset(0, 2), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  ),
                  //you can set more BoxShadow() here
                ],
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(CupertinoIcons.lock_fill, color: Colors.black.withOpacity(0.7), size: 20,),
                      SizedBox(width: 5),
                      Text(source.toString(),
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          letterSpacing: -1
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            child: CupertinoButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Icon(CupertinoIcons.chevron_left, color: Colors.black.withOpacity(0.8), size: 24,),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                          SizedBox(width: 25),
                          SizedBox(
                            width: 20,
                            child: CupertinoButton(
                              onPressed: () {
                                // Navigator.pop(context);
                              },
                              child: Icon(CupertinoIcons.chevron_right, color: Colors.black.withOpacity(0.8), size: 24,),
                              padding: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 25),
                      SizedBox(
                        width: 20,
                        child: FutureBuilder<WebViewController>(

                          future: _controller.future,
                          builder: (BuildContext context, AsyncSnapshot<WebViewController> controller) {
                              if (controller.hasData) {
                                return CupertinoButton(
                                  onPressed: () async {
                                    controller.data!.reload();
                                  },
                                  child: Icon(CupertinoIcons.refresh, color: Colors.black.withOpacity(0.8), size: 24,),
                                  padding: EdgeInsets.zero,
                                );
                              }

                              return Container();
                        },
                        ),
                      ),
                      SizedBox(width: 25),
                      SizedBox(
                        width: 20,
                        child: CupertinoButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Icon(CupertinoIcons.clear, color: Colors.black.withOpacity(0.8), size: 22,),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                  )
                ],
              )
              // color: Colors.black.withOpacity(0.7),
            ),
          ),
        ]
      ),
      )
    );
  }
}
