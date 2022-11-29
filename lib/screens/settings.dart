import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scoop/model/model.dart';
import 'package:scoop/network/network.dart';
import 'package:scoop/screens/scoop.dart';
import 'package:sheet/sheet.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 80),
        alignment: Alignment.topLeft,
        color: Color(0xFF131313),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 50,
                  child: CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(FeatherIcons.chevronLeft, color: Colors.blueAccent, size: 30,),
                  ),
                ),
                Text("Settings",
                  style: TextStyle(
                    letterSpacing: -1,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
