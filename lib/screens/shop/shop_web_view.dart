import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShopWebView extends StatefulWidget {
  const ShopWebView({Key? key}) : super(key: key);

  @override
  State<ShopWebView> createState() => _ShopWebViewState();
}

class _ShopWebViewState extends State<ShopWebView> {
  late WebViewController controller;
  var loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Hike Maniak Shop'),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: 'https://hikemaniak.co.ke/merchandize',

            ),
          ),
          loadingPercentage < 100
              ? LinearProgressIndicator(
            color: Colors.red,
            value: loadingPercentage / 100.0,
          )
              : Container(),
        ],
      ),
    );
  }
}
