import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:terrarium_idle/modules/event/event_controller.dart';
import 'package:terrarium_idle/modules/user/user_controller.dart';

class WebViewProcess extends StatefulWidget {
  final String html;
  const WebViewProcess({
    super.key,
    required this.html,
  });

  @override
  WebViewProcessState createState() => WebViewProcessState();
}

class WebViewProcessState extends State<WebViewProcess> {
  InAppWebViewController? webViewController;
  UserController userController = Get.find();
  EventController eventController = Get.find();
  String html = "";
  bool isLoaded = true;

  @override
  void initState() {
    // loadhtml();
    html = widget.html;
    super.initState();
  }

  // Future<String> loadhtml() async {
  //   html = await loadHtmlFromAssets(Assets.html1);
  //   return html;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terrarium'),
        actions: const <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.back_hand),
          //   onPressed: () {
          //     Get.back();
          //     if (webViewController != null) {
          //       // webViewController!.evaluateJavascript(
          //       //     source: 'alert("Hello! I am an alert box!!");');
          //     }
          //   },
          // ),
        ],
      ),
      body: FutureBuilder(
        future: Future.value(html),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              InAppWebView(
                initialUrlRequest: URLRequest(
                    url: WebUri.uri(Uri.parse(snapshot.data.toString()))),
                // initialData:
                //     InAppWebViewInitialData(data: snapshot.data.toString()),
                initialSettings: InAppWebViewSettings(
                  javaScriptEnabled: true,
                ),
                onLoadStart: (controller, url) {},
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    setState(() {
                      isLoaded = false;
                    });
                  } else {
                    setState(() {
                      isLoaded = true;
                    });
                  }
                },

                onWebViewCreated: (controller) {
                  // webViewController = controller;
                  webViewController =
                      eventController.processCallBack(controller);

                  // Đăng ký JavaScript handler
                },
              ),
              if (isLoaded)
                const Center(
                  child: CircularProgressIndicator(),
                )
            ],
          );
        },
      ),
    );
  }
}
