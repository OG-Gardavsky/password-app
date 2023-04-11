import 'package:flutter/material.dart';
import 'package:password_manger/screens/edit_screen.dart';
import 'package:password_manger/screens/view_screen.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var passwordRecords = appState.passwordRecords;

    return Scaffold(
      appBar: AppBar(
        title: Text('Passwords '),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: passwordRecords.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(passwordRecords[index].name),
              subtitle: Text(passwordRecords[index].userName),
              trailing: Icon(Icons.lock),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewScreen( passwordRecordId: passwordRecords[index].id),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditScreen(),
            ),
          );
        },
        tooltip: 'Add record',
        child: const Icon(Icons.add),
      ),
    );
  }
}
