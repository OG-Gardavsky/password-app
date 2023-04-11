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
  late MyAppState appState;

  String _name = '';
  String _userName = '';
  String _password = '';
  String? _id = '';

  void _submitForm() async {

    if (_formKey.currentState!.validate()) {
      await appState.saveOrUpdatePassRecord(PasswordRecord(
        id: _id ?? const Uuid().v4().toString(),
        name: _name,
        userName: _userName,
        password: _password,
      ));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Record saved')),
      );
      Navigator.of(context).pop();
    }
  }

  void _deleteRecord() async {
    await appState.deleteRecordById(_id!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Record deleted!')),
    );

    Navigator.of(context).popUntil(ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
     appState = context.watch<MyAppState>();

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
              Visibility(
                  visible: _id != null,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Delete Password?"),
                            content: Text('Are you sure you want to delete password record "$_name"?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Close"),
                              ),
                              TextButton(
                                onPressed: () {
                                  _deleteRecord();
                                },
                                style: ButtonStyle(
                                  foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                ),
                                child: const Text("Delete"),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: const Text('Delete'),
                  )
              ),
              ElevatedButton(
                onPressed: () {
                  _submitForm();

                },
                child: const Text('Save Record'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
