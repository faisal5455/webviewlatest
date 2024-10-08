import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

Map<String, dynamic> appSettings = {
  "appName": "Cool App",
  "package": "com.app.coolapp",
  "version": "1 1.0.0",
  "websiteUrl": "https://www.google.com",
  "themeColor": "",
  "showTabbar": true,
  "tabbarStyle": 0,
  "tabbars": [
    {
      "icon": "assets/home/home5.png",
      "title": "Home",
      "url": "https://www.google.com",
      "active": true
    },
    {
      "icon": "assets/catalog/grid6.png",
      "title": "Catalog",
      "url": "https://www.yahoo.com",
      "active": true
    },
    {
      "icon": "assets/search/search1.png",
      "title": "Search",
      "url": "https://www.bing.com",
      "active": true
    },
    {
      "icon": "assets/shop/shop4.png",
      "title": "Cart",
      "url": "https://www.store2app.org",
      "active": false
    },
    {
      "icon": "assets/settings/settings2.png",
      "title": "Settings",
      "url": "https://www.microsoft.com",
      "active": false
    }
  ]
};

var coloredIcons = [
  'home1',
  'home5',
  'home9',
  'home10',
  'grid1',
  'grid6',
  'contact2',
  'contact3',
  'contact6',
  'contact9',
  'profile4',
  'profile7',
  'profile9',
  'profile10',
  'search1',
  'search3',
  'search5',
  'search6',
  'search8',
  'settings2',
  'settings3',
  'settings5',
  'settings6',
  'settings8',
  'settings9',
  'shop2',
  'shop4',
  'shop6',
  'shop8',
  'shop9',
  'shop10',
];

var tabbarStyles = [
  NavBarStyle.style1,
  NavBarStyle.style9,
  NavBarStyle.style12,
  NavBarStyle.style13,
  NavBarStyle.style15,
  NavBarStyle.style19,
];

List<Widget> spinkitLoaders = [
  Center(child: Image.asset('assets/slider.png', scale: 3.5)),
  SpinKitRing(color: Colors.purple),
  SpinKitCircle(color: Colors.purple),
  SpinKitCubeGrid(color: Colors.purple),
  SpinKitChasingDots(color: Colors.purple),
  SpinKitWaveSpinner(color: Colors.purple, waveColor: Colors.purple, size: 70),
  SpinKitFoldingCube(color: Colors.purple),
  SpinKitSpinningLines(color: Colors.purple),
  SpinKitRotatingPlain(color: Colors.purple),
  SpinKitPulse(color: Colors.orange),
  SpinKitRotatingCircle(color: Colors.teal),
  SpinKitDoubleBounce(color: Colors.brown),
  SpinKitWanderingCubes(color: Colors.pink),
];
