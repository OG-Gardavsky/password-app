import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_manger/screens/edit_screen.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../models/password_record.dart';

class ViewScreen extends StatefulWidget {
  final String? passwordRecordId;

  const ViewScreen({super.key, this.passwordRecordId});

  @override
  _ViewScreenState createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  bool _showPassword = false;
  PasswordRecord? passwordRecord;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    passwordRecord = widget.passwordRecordId != null ? appState.findRecordById(widget.passwordRecordId!) : null;

    if (passwordRecord == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("View Password Record"),
        ),
        body: Center(
          child: Text("No password record found."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(passwordRecord!.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              subtitle: Text("Website Name"),
              title: Text(passwordRecord!.name),
            ),
            ListTile(
              subtitle: Text("Username"),
              title: Text(passwordRecord!.userName),
              trailing: IconButton(
                icon: Icon(Icons.copy ),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: passwordRecord!.userName));
                },
              ),
            ),
            ListTile(
              subtitle: Text("Password"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      _showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.copy ),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: passwordRecord!.password));
                    },
                  ),
                ],
              ),
              title: _showPassword
                  ? Text(passwordRecord!.password)
                  : Text("********"),
            ),
            ElevatedButton(
              // style: ButtonStyle,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditScreen(passwordRecord: passwordRecord),
                  ),
                );
              },
              child: Row(
                children: const [
                  Icon(Icons.edit),
                  Text('edit')
                ],
              )
             
            ),
          ],
        ),
      ),
    );
  }
}
