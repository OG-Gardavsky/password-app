import 'package:flutter/material.dart';
import 'package:password_manger/screens/edit_screen.dart';
import 'package:password_manger/screens/home_screen.dart';
import 'package:password_manger/screens/secure_data_screen.dart';
import 'package:password_manger/screens/view_screen.dart';

class Routes {
  static const String home = '/';
  static const String edit = '/edit';
  static const String view = '/view';
  static const String secure = '/sec';


  static final Map<String, WidgetBuilder> routesMap = {
    home: (BuildContext context) => HomeScreen(),
    edit: (BuildContext context) => EditScreen(),
    view: (BuildContext context) => ViewScreen(),
    secure: (BuildContext context) => SecureDataScreen(),
  };
}