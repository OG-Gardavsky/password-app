import 'package:flutter/material.dart';
import 'package:password_manger/screens/edit_screen.dart';
import 'package:password_manger/screens/view_screen.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/password_record.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Passwords'),
      ),
      body: Center(
        child: PasswordList(appState.passwordRecords),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EditScreen(),
            ),
          );
        },
        tooltip: 'Add record',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PasswordList extends StatelessWidget {
  List<PasswordRecord> passwordRecords;

  PasswordList(this.passwordRecords, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: passwordRecords.isNotEmpty
            ? passwordRecords
                .map((record) => ListTile(
                      title: Text(record.name),
                      subtitle: Text(record.userName),
                      trailing: const Icon(Icons.lock),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ViewScreen(passwordRecord: record),
                          ),
                        );
                      },
                    ))
                .toList()
            : [
                const ListTile(
                  title: Text('No records saved, add some'),
                  subtitle: Text(''),
                ),
              ]);
  }
}
