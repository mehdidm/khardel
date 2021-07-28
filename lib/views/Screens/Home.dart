import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/views/shared/Appbar.dart';
import 'package:khardel/views/shared/BottomBar.dart';
import 'package:khardel/views/widgets/ItemCategorie.dart';
import 'package:khardel/views/widgets/ItemMenu.dart';
import 'package:khardel/views/widgets/SearchField.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        bottomNavigationBar: BottomBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 0),
                  child: SearchBarWidget(
                    onchangeValue: (value) {
                      print(value);
                    },
                    onEditingComplete: () {
                      print('بحث');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "تربو",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 30
                          ),
                        ),

                        Image.asset('assets/images/burger.png'),
                        //DecorationImage
                      ],
                    ),
                    width: 400,
                    height: 120,
                    //BoxDecoration Widget
                    decoration: BoxDecoration(
                      color: Color(0xffF6F6F6), //Border.all
                      borderRadius: BorderRadius.circular(15),
                    ), //BoxDecoration
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  child: Text(
                    "القائمة",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      ItemCat(
                        title: "تربو",
                        image: 'assets/images/burger.png',
                      ),

                      ItemCat(
                        title: "تربو",
                        image: 'assets/images/burger.png',
                      ),


                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 20),
                  child: Text(
                    "الإختيارات",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ItemMenu(
                        title: "تربو",
                        price: "8 شيكل",
                        image: "assets/images/sandwich.png",
                      ),
                      ItemMenu(
                        title: "تربو",
                        price: "8 شيكل",
                        image: "assets/images/sandwich.png",
                      ),
                      ItemMenu(
                        title: "تربو",
                        price: "8 شيكل",
                        image: "assets/images/sandwich.png",
                      ),
                      ItemMenu(
                        title: "تربو",
                        price: "8 شيكل",
                        image: "assets/images/sandwich.png",
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
