import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khardel/services/categories.services.dart';
import 'package:khardel/services/food.services.dart';
import 'package:khardel/views/Screens/Home.dart';
import 'package:khardel/views/authentification/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void setupLocator() {

  GetIt.I.registerLazySingleton(() => CategoriesServices());
  GetIt.I.registerLazySingleton(() => FoodsServices());

}
void main() {
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

  void _checkIfLoggedIn() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if(token!= null){
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:_isLoggedIn?Home([0]):SplashScreen(),
    );
  }
}
