import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/password_record.dart';
import 'package:uuid/uuid.dart';

class EditScreen extends StatefulWidget {
  final PasswordRecord? passwordRecord;

  const EditScreen({super.key, this.passwordRecord});


  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _userName = '';
  String _password = '';
  String? _id = '';

  void _submitForm(MyAppState appState) async {

    if (_formKey.currentState!.validate()) {
      await appState.saveOrUpdatePassRecord(PasswordRecord(
        id: _id ?? const Uuid().v4().toString(),
        name: _name,
        userName: _userName,
        password: _password,
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Record saved')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    _name = widget.passwordRecord?.name ?? '';
    _userName = widget.passwordRecord?.userName ?? '';
    _password = widget.passwordRecord?.password ?? '';
    _id = widget.passwordRecord?.id;

    return Scaffold(
      appBar: AppBar(title: Text(widget.passwordRecord?.name != null ? 'Edit ${widget.passwordRecord?.name}' : 'Add Password Record')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name/URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name or URL of website';
                  }
                  return null;
                },
                onChanged: (value) => _name = value,
                initialValue: widget.passwordRecord?.name ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onChanged: (value) => _userName = value,
                initialValue: widget.passwordRecord?.userName ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onChanged: (value) => _password = value,
                initialValue: widget.passwordRecord?.password ?? '',
              ),
              ElevatedButton(
                onPressed: () {
                  _submitForm(appState);

                },
                child: const Text('Save Record'),
              ),
              ElevatedButton(
                onPressed: () {
                  _submitForm(appState);
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
