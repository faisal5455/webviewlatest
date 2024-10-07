import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:webviewapp/app_settings.dart';
import 'package:webviewapp/controllers/webview_controller.dart';
import 'package:webviewapp/webview_screen.dart';

class TabbarScreen extends StatefulWidget {
  const TabbarScreen({super.key});

  @override
  State<TabbarScreen> createState() => _TabbarScreenState();
}

class _TabbarScreenState extends State<TabbarScreen> {
  late PersistentTabController controller;

  late ScrollController scrollController1;
  late ScrollController scrollController2;
  late WebviewScreen webviewScreen;
  late WebviewController webcontroller;

  int selected = 0;

  @override
  void initState() {
    super.initState();
    print('init is called =====');
    webcontroller = WebviewController(url: appSettings['websiteUrl']);
    webviewScreen = WebviewScreen(webController: webcontroller);

    controller = PersistentTabController(initialIndex: 0);
    scrollController1 = ScrollController();
    scrollController2 = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: List.generate(
          appSettings['tabbars'].length, (index) => webviewScreen),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: false,
      hideNavigationBarWhenKeyboardAppears: true,
      onItemSelected: (value) {
        selected = value;
        webcontroller.url = appSettings['tabbars'][value]['url'];
        setState(() {});
      },
      //padding: const EdgeInsets.only(top: 5, bottom: 5),
      backgroundColor: Colors.grey[200]!,
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: tabbarStyles[appSettings['tabbarStyle']],
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return List.generate(appSettings['tabbars'].length, (index) {
      var tabData = appSettings['tabbars'][index];
      return PersistentBottomNavBarItem(
        icon: Image.asset(
          tabData['icon'],
          width: 25,
          height: 25,
          color: !isColoredIcon(tabData['icon']) ? setColor(index) : null,
        ),
        title: tabData['title'],
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey.shade500,
        scrollController: scrollController1,
      );
    });
  }

  setColor(int index) {
    return index == selected ? Colors.black : Colors.grey;
  }

  isColoredIcon(String path) {
    return coloredIcons.any((icon) => path.contains(icon));
  }
}
