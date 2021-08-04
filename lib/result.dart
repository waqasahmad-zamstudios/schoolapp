import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ResultView extends StatefulWidget {
  ResultView(this.url);
  final String url;

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  String path = 'http://result.bpsplayschool.com/frame.php?path=';
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    path += widget.url;
    print(path);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Container(
        child: Column(
          children: [
            (_progress != 1.0)
                ? LinearProgressIndicator(value: _progress)
                : null,
            Expanded(
              child: Container(
                margin: EdgeInsets.all(0.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: WebviewScaffold(
                  appBar: AppBar(
                    title: Text('BPS PLAY SCHOOL'),
                  ),
                  url: path,
                  scrollBar: true,
                  withZoom: true,
                  withLocalStorage: true,
                  hidden: true,
                  allowFileURLs: true,
                  withJavascript: true,
                  initialChild: Container(
                    color: Colors.white,
                    child: Center(
                      child: Text(
                        'Wait .... \n Checking Internet Connection',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
