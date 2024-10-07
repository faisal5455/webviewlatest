import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:webviewapp/app_settings.dart';
import 'package:webviewapp/controllers/webview_controller.dart';
import 'package:webviewapp/no_internet.dart';
import 'package:webviewapp/tabbar_screen.dart';
import 'package:webviewapp/webview_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('d7aa48c6-b9cb-42f6-a768-1aabd9093eaa');
  OneSignal.Notifications.requestPermission(true);

  OneSignal.Notifications.addClickListener((event) {
    notificationUrl = event.notification.additionalData?['url'] ?? '';
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Connectivity
  bool isConnected = true;
  late StreamSubscription<List<ConnectivityResult>> subscription;
  @override
  void initState() {
    super.initState();
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      setState(() {
        if (result.contains(ConnectivityResult.none)) {
          isConnected = false;
        } else {
          isConnected = true;
        }
      });
    });
    EasyLoading.instance
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Akita Catalogo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isConnected ? showHomeScreen() : const NoInternetScreen(),
      builder: EasyLoading.init(),
    );
  }

  showHomeScreen() {
    return appSettings['showTabbar']
        ? const TabbarScreen()
        : WebviewScreen(
            webController: WebviewController(url: appSettings['websiteUrl']));
  }
}
