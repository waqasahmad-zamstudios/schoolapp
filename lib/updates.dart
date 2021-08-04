import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/animation.dart';

class Updates extends StatefulWidget {
  const Updates({Key key}) : super(key: key);

  @override
  _UpdatesState createState() => _UpdatesState();
}

class _UpdatesState extends State<Updates> with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();
  AnimationController animationController;
  List notices;
  @override
  void initState() {
    double offset = 0.0;
    super.initState();
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
  }

  Future getNotice() async {
    var response = await http.get(
        Uri.parse(
          'http://result.bpsplayschool.com/updates.php',
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Image.asset('assets/bps.png'),
        title: Text("BPS Pay School"),
        elevation: 2.0,
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                  "Update Board",
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
                            notices[index]['updates'],
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          subtitle:
                              Text('Posted On : ' + notices[index]['date']),
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
