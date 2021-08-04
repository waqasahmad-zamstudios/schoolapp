import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import 'notice.dart';
import 'noticev1.dart';
import 'school/about.dart';
import 'school/admission.dart';
import 'school/contact.dart';

var green = Color(0xFF4caf6a);
var greenLight = Color(0xFFd8ebde);

var red = Color(0xFFf36169);
var redLlight = Color(0xFFf2dcdf);

var blue = Color(0xFF398bcf);
var blueLIght = Color(0xFFc1dbee);

final List<String> imgList = [
  'assets/8.jpg',
  'assets/6.jpg',
  'assets/4.JPG',
  'assets/5.jpg',
  'assets/9.jpg',
];
final List child = map<Widget>(
  imgList,
  (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: [
            Image.asset(
              i,
              fit: BoxFit.cover,
              width: 1000.0,
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  "BPS PLAY SCHOOL",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }
  return result;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  AnimationController animationController;
  Choice _selectedChoice = choices[0];
  int _current = 0;
  List notices;
  final flutterwebviewplugin = FlutterWebviewPlugin();
  @override
  void initState() {
    double offset = 0.0;

    this.getNotice();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 6))
          ..addListener(() {
            if (scrollController.hasClients) {
              if (animationController.isCompleted) {
                animationController.repeat();
              }
              offset += 1.0;
              if (offset - 1 > scrollController.offset) {
                offset = 0.0;
              }
              setState(() {
                scrollController.jumpTo(offset);
              });
            }
          });
    animationController.forward();
    super.initState();

    flutterwebviewplugin.close();
    flutterwebviewplugin.onUrlChanged.listen((String url) {});
  }

  Future getNotice() async {
    var response = await http.get(
        Uri.parse(
          'http://result.bpsplayschool.com/db.php',
        ),
        headers: {'accepts': 'application/json'});
    var data = json.decode(response.body);
    print(data['result']);
    if (!mounted) return;
    setState(() {
      notices = data['result'];
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
    flutterwebviewplugin.dispose();
  }

  void _select(Choice choice) {
    _launchURL();
  }

  canlaunch(String url) {
    if (url.length > 0)
      return true;
    else
      return false;
  }

  _launchURL() async {
    const url = 'http://bpsplayschool.com/privacy_policy.php';
    if (await canlaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Image.asset('assets/bps.png'),
        title: Text("BPS Pay School"),
        actions: [
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Text(choice.title),
                );
              }).toList();
            },
          ),
        ],
        elevation: 2.0,
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              CarouselSlider(
                items: child,
                autoPlay: true,
                aspectRatio: 2.0,
                onPageChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              Positioned(
                top: 150.0,
                left: 0.0,
                right: 0.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(imgList, (index, url) {
                    return Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4)),
                    );
                  }),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              direction: Axis.horizontal,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  child: Container(
                    height: 92.0,
                    width: 104.0,
                    color: greenLight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Admission()),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: green,
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "Admission",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  child: Container(
                    height: 92.0,
                    width: 104.0,
                    color: greenLight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => About()),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.school,
                            color: red,
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "Admission",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  child: Container(
                    height: 92.0,
                    width: 104.0,
                    color: greenLight,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Contact()),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.contact_phone,
                            color: blue,
                          ),
                          SizedBox(
                            height: 4.0,
                          ),
                          Text(
                            "Admission",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(2.0),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
            ),
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width / 1.029,
              color: Colors.amber,
              child: Center(
                child: Text(
                  "Notice Board",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: notices == null
                ? Center(child: Text('0 Notice Available'))
                : ListView.builder(
                    controller: scrollController,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: notices == null ? 0 : notices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        child: ListTile(
                          leading: Icon(Icons.av_timer),
                          title: Text(
                            notices[index]['notices'],
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          subtitle:
                              Text('Posted On : ' + notices[index]['date']),
                          onTap: () {
                            if (notices[index]['isfile'] == '1') {
                              var type = notices[index]['path'].split('.');
                              if (type[type.length - 1] == 'pdf') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Notice(notices[index]['path'])));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NotIm(notices[index]['path'])));
                              }
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('No File is Uploaded'),
                              ));
                            }
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Privacy Policy', icon: Icons.security),
];
