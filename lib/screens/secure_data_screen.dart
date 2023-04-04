import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

class SecureDataScreen extends StatefulWidget {
  @override
  _SecureDataScreenState createState() => _SecureDataScreenState();
}

class _SecureDataScreenState extends State<SecureDataScreen> {
  var _secureData;

  @override
  void initState() {
    super.initState();
    _loadSecureData();
  }

  Future<void> _loadSecureData() async {
    var data = await storage.readAll();
    setState(() {
      _secureData = data!;
      print(_secureData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Secure Data'),
      ),
      body: Center(
        child: Text('data'),
      ),
    );
  }
}
