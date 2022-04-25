import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../view/file/view/file_view.dart';
import '../../../view/splash/view/splash_view.dart';
import '../../component/scaffold/no_network.dart';
import '../../component/scaffold/not_found_scaffold.dart';
import '../../constant/navigation/navigation_constants.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;

  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      //!       PAGES      //
      case NavConstant.splashView:
        return defaultNavigate(const SplashView());

      case NavConstant.fileView:
        return defaultNavigate(const FileView());

      //*       NO NETWORK      //
      case NavConstant.noNetwork:
        return defaultNavigate(const NoNetworkScaffold());

      //*       NOT FOUND      //
      default:
        return defaultNavigate(const NotFoundScaffold());
    }
  }

  PageRoute defaultNavigate(Widget widget) => Platform.isAndroid
      ? MaterialPageRoute(builder: (context) => widget)
      : CupertinoPageRoute(builder: (context) => widget);
}
