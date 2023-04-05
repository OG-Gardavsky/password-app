import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manger/routes.dart';
import 'package:provider/provider.dart';

import 'models/password_record.dart';

final storage = FlutterSecureStorage();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
          title: 'My App',
          initialRoute: Routes.home,
          routes: Routes.routesMap,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          )),
    );
  }
}

class MyAppState extends ChangeNotifier {
  List<PasswordRecord> passwordRecords = [];

  MyAppState() {
    loadPassRecordsFromDb();
  }

  Future<void> loadPassRecordsFromDb() async {
    List<PasswordRecord> records = [];
    Map<String, dynamic> allValues = await storage.readAll();

    for (String key in allValues.keys) {
      Map<String, dynamic> json = jsonDecode(allValues[key]!);
      PasswordRecord record = PasswordRecord.fromJson(json);
      records.add(record);
    }
    passwordRecords = records;
    notifyListeners();
  }

  void addPassRecord(PasswordRecord record) {
    passwordRecords.add(record);
    notifyListeners();
  }
}
