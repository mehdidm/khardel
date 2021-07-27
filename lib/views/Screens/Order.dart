import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/views/shared/constant.dart';
import 'package:khardel/views/widgets/ItemSup.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Center(
          child: Image.asset(
            "assets/images/sandwich.png",
            scale: 0.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              color: Colorbg,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.remove_circle_outline_sharp,
                        size: 30,
                        color: ColorMv,
                      ),
                      SizedBox(
                        width: x * 0.02,
                      ),
                      Text("5", style: TextStyle(fontSize: 25)),
                      SizedBox(
                        width: x * 0.02,
                      ),
                      Icon(
                        Icons.add_circle_outline,
                        size: 30,
                        color: ColorMv,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("8 شيكل",
                            style: TextStyle(fontSize: 25, color: ColorGold)),
                        Text("تربو",
                            style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: ColorMv))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam porta enim vitaecondimentum ullamcorper. Suspendisse",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: Text(
                        "الإضافات",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorMv,
                            fontSize: 30),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ItemSup(
                          image: "assets/images/cheese.png",
                        ),
                        ItemSup(
                          image: "assets/images/salade.png",
                        ),
                        ItemSup(
                          image: "assets/images/soda.png",
                        ),
                        ItemSup(
                          image: "assets/images/salade.png",
                        ),
                        ItemSup(
                          image: "assets/images/soda.png",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      child: Text(
                        "الإضافات",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: ColorMv,
                            fontSize: 30),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child:TextField(

                      autofocus: false,
                      style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                      decoration: InputDecoration(

                        filled: true,
                        fillColor: Colors.white,
                     //   hintText: 'Username',
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
                  Padding(
                    padding: const EdgeInsets.only(top :20.0),
                    child: ElevatedButton(

                      onPressed: () {},
                      child: Text('أطلب' , textAlign: TextAlign.center,),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: ColorMv,

                      ),
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }
}
