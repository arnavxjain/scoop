import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MultiView extends StatefulWidget {
  const MultiView({Key? key}) : super(key: key);

  @override
  State<MultiView> createState() => _MultiViewState();
}

class _MultiViewState extends State<MultiView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 90),
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Image.network(
                    'https://images.unsplash.com/photo-1526470702024-9213b24690c3?ixlib=rb-1.2.1&auto=format&fit=crop&w=1381&q=80'),
                Image.network(
                    'https://images.unsplash.com/photo-1589837687411-50a9efe9bfae?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                Image.network(
                    'https://images.unsplash.com/photo-1541680670548-88e8cd23c0f4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                Image.network(
                    'https://images.unsplash.com/photo-1533158326339-7f3cf2404354?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                Image.network(
                    'https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
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
