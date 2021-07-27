import 'package:flutter/material.dart';
import 'package:khardel/user/UserProfil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Khardel',
      theme: ThemeData(
      primarySwatch: Colors.teal,

      ),
      home:UserProfil(),
    );
  }
}
