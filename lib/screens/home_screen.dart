import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:password_manger/screens/edit_screen.dart';
import 'package:password_manger/screens/secure_data_screen.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({super.key});





  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('necfdfdo'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              'Hello Wofdfgfdrld',
              style: TextStyle(fontSize: 24.0),
            ),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SecureDataScreen(),
                ),
              );
            }, child: Text('secure'))
          ],
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
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
