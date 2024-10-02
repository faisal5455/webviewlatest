import 'dart:async';

//import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webviewapp/configs.dart';
import 'package:webviewapp/no_internet.dart';

String notificationUrl = '';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //String url = 'https://akitacatalogo.it';
  String url = webUrl;
  Color background = Colors.white;

  // Connectivity
  bool isConnected = true;
  //late StreamSubscription<List<ConnectivityResult>> subscription;

  bool isDismissed = false;
  bool isFinished = false;

  @override
  void initState() {
    super.initState();

    // subscription = Connectivity()
    //     .onConnectivityChanged
    //     .listen((List<ConnectivityResult> result) {
    //   setState(() {
    //     if (result.contains(ConnectivityResult.none)) {
    //       isConnected = false;
    //     } else {
    //       isConnected = true;
    //     }
    //   });
    // });

    if (notificationUrl != '') {
      //print('Already loaded...');
      url = notificationUrl;
    } else {
      //print('Not loaded called again');
      OneSignal.Notifications.addClickListener((event) {
        var data = event.notification.additionalData;
        var notiUrl = data?['url'] ?? '';
        if (notiUrl != '') {
          setState(() {
            url = notiUrl;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    //subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: isConnected
          ? SafeArea(
              child: WebViewWidget(
                controller: WebViewController()
                  ..loadRequest(
                    Uri.parse(url),
                  )
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..setNavigationDelegate(
                    NavigationDelegate(
                      onPageStarted: (String url) {
                        print('Url is: $url');
                        isDismissed = false;
                        isFinished = false;
                        EasyLoading.show(status: 'Loading...');
                        Future.delayed(const Duration(seconds: 5), () {
                          if (!isFinished) {
                            EasyLoading.dismiss();
                            isDismissed = true;
                            print('dismissed from start');
                          }
                        });
                      },
                      onPageFinished: (String url) {
                        if (!isDismissed) {
                          EasyLoading.dismiss();
                          isDismissed = true;
                          isFinished = true;
                          print('dismissed from finish');
                        }
                      },
                    ),
                  ),
              ),
            )
          : const NoInternetScreen(),
    );
  }
}
