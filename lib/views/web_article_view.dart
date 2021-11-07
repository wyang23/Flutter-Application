import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';


class WebArticleView extends StatefulWidget {
  late final String blogUrl;
  WebArticleView({required this.blogUrl});
  @override
  _WebArticleViewState createState() => _WebArticleViewState();
}

class _WebArticleViewState extends State<WebArticleView> {

  late final Completer<WebViewController> _completer =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Architect"),
                Text("Digest", style: TextStyle(
                    color: Colors.blue
                ),)
              ]
          ),
          actions: <Widget>[
            Opacity(
              opacity: 0,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.save)),
            )
          ],
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WebView(
              initialUrl: widget.blogUrl,
              onWebViewCreated: ((WebViewController webViewController){
                _completer.complete(webViewController);
              }),
            )
        )
    );
  }
}