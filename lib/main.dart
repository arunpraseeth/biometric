import 'package:fingerprint/fingerprint.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text(
            'Welcome',
            style: TextStyle(fontSize: 40),
          ),
          onPressed: () {
            setState(
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePageAuthCheck(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
