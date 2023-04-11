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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Passwords'),
      ),
      body: Center(
        child:
        ListView(
          children: appState.passwordRecords.length > 0 ?
            appState.passwordRecords.map((record) =>
                ListTile(
                  title: Text(record.name),
                  subtitle: Text(record.userName),
                  trailing: const Icon(Icons.lock),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewScreen( passwordRecord: record),
                      ),
                    );
                  },
                )
            ).toList()
          : [
            ListTile(
              title: Text('No records saved, add some'),
              subtitle: Text(''),
            ),
          ]
        )
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
