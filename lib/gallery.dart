import 'dart:ui';

import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
        elevation: 2.0,
        backgroundColor: Color.fromARGB(255, 255, 105, 180),
      ),
      body: Container(
          color: Colors.white30,
          child: GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              padding: EdgeInsets.all(4.0),
              children: <String>[
                'assets/1.jpg',
                'assets/2.jpg',
                'assets/3.JPG',
                'assets/4.JPG',
                'assets/5.jpg',
                'assets/6.jpg',
                'assets/7.jpg',
                'assets/8.jpg',
                'assets/9.jpg',
                'assets/10.jpg',
              ].map((String url) {
                return ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  child: GridTile(
                    child: Image.asset(url, fit: BoxFit.cover),
                  ),
                );
              }).toList())),
    );
  }
}
