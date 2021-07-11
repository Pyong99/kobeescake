import 'package:flutter/material.dart';
import 'package:kobeescake/screens/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kobees Cake',
      home: SplashScreen(),
    );
  }
}
