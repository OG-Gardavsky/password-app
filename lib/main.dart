import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manger/routes.dart';
import 'package:provider/provider.dart';

import 'models/password_record.dart';

const storage = FlutterSecureStorage();

void main() => runApp(const MyApp());

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
  final _storage = const FlutterSecureStorage();

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

  Future<void> saveOrUpdatePassRecord(PasswordRecord record) async {
    await _storage.write(
      key: record.id,
      value: jsonEncode(record),
    );

    for (var i = 0; i < passwordRecords.length; i++) {
      if(passwordRecords[i].id == record.id) {
        passwordRecords[i] = record;
        notifyListeners();
        return;
      }
    }

    passwordRecords.add(record);
    notifyListeners();
  }

  bool isRecordValid(PasswordRecord record) {
      return passwordRecords.contains(record);
  }

  Future<void> deleteRecordById(String id) async {
    await storage.delete(key: id);

    passwordRecords.removeWhere((element) => element.id == id);

    notifyListeners();

    // await loadPassRecordsFromDb();
  }

}
