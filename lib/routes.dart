import 'package:flutter/material.dart';
import 'package:password_manger/screens/edit_screen.dart';
import 'package:password_manger/screens/home_screen.dart';
import 'package:password_manger/screens/view_screen.dart';

class Routes {
  static const String home = '/';
  static const String edit = '/edit';
  static const String view = '/view';
  static const String secure = '/sec';


  static final Map<String, WidgetBuilder> routesMap = {
    home: (BuildContext context) => const HomeScreen(),
    edit: (BuildContext context) => const EditScreen(),
    view: (BuildContext context) => const ViewScreen(),
  };
}