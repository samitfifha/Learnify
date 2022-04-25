import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class testScreen extends StatefulWidget {
  const testScreen({Key? key}) : super(key: key);

  @override
  State<testScreen> createState() => _testScreenState();
}

class _testScreenState extends State<testScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: WebView(
          initialUrl: 'http://192.168.1.19:3000/contact',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      );
}
