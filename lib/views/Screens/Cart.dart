import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/views/shared/Appbar.dart';
import 'package:khardel/views/shared/BottomBar.dart';
import 'package:khardel/views/shared/constant.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
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
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Text("طلبك (2)",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: ColorMv)),
                        SizedBox(width: y*0.03),
                        Icon(
                          Icons.assignment_outlined,
                          color: ColorMv,
                          size: 25,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            text:"  المجموع",
                            style: TextStyle( fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: ColorMv),
                            children: const <TextSpan>[
                              TextSpan(text: ' : 8 شيكل', style: TextStyle(fontWeight: FontWeight.bold, color: ColorGl)),

                            ],
                          ),
                        ),
                       /* Text(": المجموع",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: ColorMv)),*/
                        SizedBox(width: y*0.01),
                        Icon(
                          Icons.monetization_on_outlined,
                          color: ColorMv,
                          size: 30,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RichText(
                          text: TextSpan(
                            text:"  مجموع النقاط",
                            style: TextStyle( fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: ColorMv),
                            children: const <TextSpan>[
                              TextSpan(text: ' : 25', style: TextStyle(fontWeight: FontWeight.bold, color: ColorGl)),

                            ],
                          ),
                        ),

                        SizedBox(width: y*0.01),
                        Icon(
                          Icons.card_giftcard,
                          color: ColorMv,
                          size: 30,
                        ),
                      ],
                    ),
                    Dismissible(
                      child: Container(
                        child: Column(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right:50, top: 40),
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 0),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.remove_circle_outline_sharp,
                                                  size: 40,
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
                                                  size: 40,
                                                  color: ColorMv,
                                                )

                                              ],
                                            ),
                                          ),
                                          width: y*0.1,
                                          height: x* 0.15,
                                          //BoxDecoration Widget
                                          decoration: BoxDecoration(
                                            color: Color(0xffE9DFDF), //Border.all
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "تربو",

                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,

                                              ),
                                            ),
                                            Text(
                                              "عدد نقاط الوجبة",

                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,

                                              ),
                                            ),
                                            Text(
                                              "10 شيكل",

                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: ColorGl

                                              ),
                                            ),


                                          ],
                                        ),

                                      ),


                                      Image.asset('assets/images/sandwich.png'),
                                      //DecorationImage

                                    ],
                                  ),
                                  Text(
                                    "عدد نقاط الوجبة : 10 ",

                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: ColorBlue,
                                      fontSize: 20,

                                    ),
                                  ),
                                ],
                              ),
                              width: y,
                              height: x* 0.25,
                              //BoxDecoration Widget
                              decoration: BoxDecoration(
                                color: Color(0xffF6F6F6), //Border.all
                                borderRadius: BorderRadius.circular(15),
                              ), //BoxDecoration
                            ),

                          ],


                        ),
                      ),
                      background: Container(
                        color: ColorMv,
                        child: Padding(
                          padding: const EdgeInsets.only(right:10),
                          child: Align(
                            alignment: Alignment.centerRight,
                              child: Icon(Icons.delete_outlined,  size: 60, color: Colors.white,)
                          ),
                        ),
                      ),
                      key: ValueKey("my"),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(top :20.0),
                      child: ElevatedButton(

                        onPressed: () {},
                        child: Text('تأكيد الطلب' , textAlign: TextAlign.center,),
                        style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: ColorMv,

                        ),
                      ),
                    )



                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
