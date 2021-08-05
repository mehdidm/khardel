import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khardel/services/categories.services.dart';
import 'package:khardel/services/food.services.dart';
import 'package:khardel/views/Screens/Acceuil.dart';
import 'package:khardel/views/authentification/splashscreen.dart';
import 'package:khardel/views/get%20order/GetOrder.dart';


void setupLocator() {

  GetIt.I.registerLazySingleton(() => CategoriesServices());
  GetIt.I.registerLazySingleton(() => FoodsServices());

}
void main() {
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Acceuil(),
    );
  }
}
