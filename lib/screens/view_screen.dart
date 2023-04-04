import 'package:flutter/material.dart';

class ViewScreen extends StatelessWidget {
  // const HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('view screen'),
      ),
      body: const Center(
        child: Text(
          'Hello World',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
