import 'package:flutter/material.dart';
import 'package:password_manger/routes.dart';
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

    Navigator.of(context).popUntil(ModalRoute.withName(Routes.home));
  }

  String? validatorFn(String msg, String? value) {
    if (value == null || value.isEmpty) {
      return msg;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    appState = context.watch<MyAppState>();

    _name = widget.passwordRecord?.name ?? '';
    _userName = widget.passwordRecord?.userName ?? '';
    _password = widget.passwordRecord?.password ?? '';
    _id = widget.passwordRecord?.id;

    return Scaffold(
      appBar: AppBar(
          title: Text(widget.passwordRecord?.name != null
              ? 'Edit ${widget.passwordRecord?.name}'
              : 'Add Password Record')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Website Name'),
                validator: (value) =>
                    validatorFn('Please enter a Website Name', value),
                onChanged: (value) => _name = value,
                initialValue: widget.passwordRecord?.name ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) =>
                    validatorFn('Please enter a username', value),
                onChanged: (value) => _userName = value,
                initialValue: widget.passwordRecord?.userName ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (value) =>
                    validatorFn('Please enter a password', value),
                onChanged: (value) => _password = value,
                initialValue: widget.passwordRecord?.password ?? '',
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _id != null
                      ? Expanded(
                          child: DeleteBtn(
                              'Are you sure you want to delete password record "$_name"?',
                              _deleteRecord),
                        )
                      : const SizedBox.shrink(),
                  _id != null
                      ? const SizedBox(
                          width: 16,
                        )
                      : const SizedBox.shrink(),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      _submitForm();
                    },
                    child: const Text('Save Record'),
                  ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeleteBtn extends StatelessWidget {
  final String deleteMsg;
  final Function onPressedFn;

  const DeleteBtn(this.deleteMsg, this.onPressedFn, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Delete Password?"),
              content: Text(deleteMsg),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Close"),
                ),
                TextButton(
                  onPressed: () {
                    onPressedFn();
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.red),
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
    );
  }
}
