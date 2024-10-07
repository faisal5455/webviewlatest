import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:webviewapp/controllers/webview_controller.dart';
import 'package:webviewapp/no_internet.dart';

String notificationUrl = '';

class WebviewScreen extends StatefulWidget {
  final WebviewController webController;
  const WebviewScreen({super.key, required this.webController});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  @override
  void initState() {
    super.initState();
    print('init state is called --------');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<WebviewController>(
          init: widget.webController,
          builder: (webController) {
            print('get builder called url: ${webController.url}');
            return SafeArea(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(webController.url)),
                pullToRefreshController: webController.pullToRefreshController,
                initialSettings: webController.settings,
                onWebViewCreated: (controller) {
                  webController.webViewController = controller;
                },
                onLoadStart: (controller, url) {
                  EasyLoading.show();
                  webController.url = url.toString();
                },
                onProgressChanged: (controller, progress) {
                  if (progress == 100) {
                    EasyLoading.dismiss();
                    webController.pullToRefreshController?.endRefreshing();
                  }
                  webController.progress = progress / 100;
                },
                onLoadStop: (controller, url) async {
                  await controller.evaluateJavascript(source: """
                    document.documentElement.style.height = (document.documentElement.clientHeight + 100) + 'px';
                                      """);
                  if (webController.pullToRefreshController != null) {
                    webController.pullToRefreshController!.endRefreshing();
                  }
                  EasyLoading.dismiss();
                  //webController.url = url.toString();
                },
                onReceivedError: (controller, url, error) {},
              ),
            );
          }),
    );
  }
}
