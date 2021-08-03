import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/views/shared/Appbar.dart';
import 'package:khardel/views/shared/BottomBar.dart';
import 'package:khardel/views/shared/constant.dart';
class ModifierMenu extends StatefulWidget {
  @override
  _ModifierMenuState createState() => _ModifierMenuState();
}

class _ModifierMenuState extends State<ModifierMenu> {
  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(),
          bottomNavigationBar: BottomBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("تعديل",
                    style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold, color: ColorMv)),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("إسم الوجبة",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorBlue)),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        child: TextField(
                          autofocus: false,
                          style:
                          TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 20.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("سعر الوجبة",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorBlue)),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        child: TextField(
                          autofocus: false,
                          style:
                          TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 20.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20 , horizontal: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("عدد نقاط الوجبة",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorBlue)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.remove_circle_outline_sharp,
                            size: 30,
                            color: ColorBlue,
                          ),
                          SizedBox(
                            width: x * 0.02,
                          ),
                          Text("5", style: TextStyle(fontSize: 25 ,color: ColorBlue)),
                          SizedBox(
                            width: x * 0.02,
                          ),
                          Icon(
                            Icons.add_circle_outline,
                            size: 30,
                            color: ColorBlue,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("صنف",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorBlue)),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        child: TextField(
                          autofocus: false,
                          style:
                          TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 20.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("تفاصيل",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: ColorBlue)),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                        child: TextField(
                          autofocus: false,
                          style:
                          TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                            const EdgeInsets.symmetric(vertical: 40.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Icon(Icons.check),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: ColorGreen,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
