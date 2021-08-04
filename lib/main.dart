import 'package:flutter/material.dart';
import 'package:schoolapp/gallery.dart';
import 'package:schoolapp/home.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'student.dart';

void main() => runApp(MaterialApp(
      title: 'School',
      /*theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
      ),*/
      home: Homepage(),
    ));

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentstae = 0;
  final _widgetOptions = [
    Home(),
    GalleryPage(),
    Student(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _widgetOptions.elementAt(currentstae),
        decoration: BoxDecoration(color: Colors.white),
      ),
      bottomNavigationBar: BottomNavyBar(
        onItemSelected: (index) => setState(() {
          currentstae = index;
        }),
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.apps),
            title: Text("Home"),
            activeColor: Colors.red,
            //textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.image),
            title: Text("Gallery"),
            activeColor: Colors.purpleAccent,
            //textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.people),
            title: Text("Student"),
            activeColor: Colors.blue,
            // textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
