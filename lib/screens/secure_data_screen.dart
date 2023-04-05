import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/password_record.dart';

final storage = FlutterSecureStorage();

class SecureDataScreen extends StatefulWidget {
  @override
  _SecureDataScreenState createState() => _SecureDataScreenState();
}

class _SecureDataScreenState extends State<SecureDataScreen> {
  List<PasswordRecord> _passwordRecords = [];

  @override
  void initState() {
    super.initState();
    _readData();
  }

  Future<void> _readData() async {
    List<PasswordRecord> records = [];
    Map<String, dynamic> allValues = await storage.readAll();

    for (String key in allValues.keys) {
      Map<String, dynamic> json = jsonDecode(allValues[key]!);
      PasswordRecord record = PasswordRecord.fromJson(json);
      records.add(record);
    };
    setState(() {
      _passwordRecords = records;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secure Data'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _passwordRecords.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_passwordRecords[index].name),
              subtitle: Text('Username: ${_passwordRecords[index].userName}'),
              trailing: Icon(Icons.lock),
              onTap: () {
                // Handle onTap event
              },
            );
          },
        ),
      ),
    );
  }
}
