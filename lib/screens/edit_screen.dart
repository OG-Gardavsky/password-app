import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/password_record.dart';
import 'package:uuid/uuid.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _storage = const FlutterSecureStorage();

  String _name = '';
  String _userName = '';
  String _password = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final record = PasswordRecord(
        id: const Uuid().v4().toString(),
        name: _name,
        userName: _userName,
        password: _password,
      );
      await _storage.write(
        key: record.id,
        value: jsonEncode(record),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Record saved')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Password Record')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name/URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name or URL of website';
                  }
                  return null;
                },
                onChanged: (value) => _name = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onChanged: (value) => _userName = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onChanged: (value) => _password = value,
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save Record'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
