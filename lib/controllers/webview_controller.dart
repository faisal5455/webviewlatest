import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class WebviewController extends GetxController {
  String url;
  WebviewController({required this.url});

  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true);
  double progress = 0;

  Future<void> refreshWebView() async {
    if (webViewController != null) {
      webViewController!.reload();
    }
  }

  Color background = Colors.white;

  String notificationUrl = '';

  // Connectivity
  bool isConnected = true;
  late StreamSubscription<List<ConnectivityResult>> subscription;

  bool isDismissed = false;
  bool isFinished = false;

  PullToRefreshSettings pullToRefreshSettings = PullToRefreshSettings(
    color: Colors.blue,
  );

  @override
  void onInit() {
    super.onInit();
    pullToRefreshController = PullToRefreshController(
      settings: pullToRefreshSettings,
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        isConnected = false;
      } else {
        isConnected = true;
      }
      update();
    });

    if (notificationUrl != '') {
      url = notificationUrl;
    } else {
      //print('Not loaded called again');
      OneSignal.Notifications.addClickListener((event) {
        var data = event.notification.additionalData;
        var notiUrl = data?['url'] ?? '';
        if (notiUrl != '') {
          url = notiUrl;
          update();
        }
      });
    }
  }

  changeUrl(String websiteUrl) {
    url = url;
  }
}
