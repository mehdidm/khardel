import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/views/Screens/Home.dart';
import 'package:khardel/views/Screens/Order.dart';
import 'package:khardel/views/shared/Appbar.dart';
import 'package:khardel/views/shared/BottomBar.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override

  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Khardel',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(),
          bottomNavigationBar: BottomBar(),
          body: SingleChildScrollView(
            child:Order()
          ),
        ),
      ),
    );
  }
}
