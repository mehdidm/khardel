import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/Constant.dart';

class CardOrder extends StatefulWidget {
  const CardOrder({Key key}) : super(key: key);

  @override
  _CardOrderState createState() => _CardOrderState();
}

class _CardOrderState extends State<CardOrder> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height * 0.2,
      decoration: BoxDecoration(
        color: KGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width * 0.055,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: KMauve,
            ),
            child: Center(
                child: Text(
              '2',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:  ' سلطة قيصر',
                      style: TextStyle(
                        color: KBlue,
                        fontSize: 20,
                      ),
                    ),
                    TextSpan(
                      text: '\n حجم صغير ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: '\n عدد نقاط الوجبة: 10',
                      style: TextStyle(
                        color: KBlue,
                        fontSize: 15,
                      ),
                    ),
                    TextSpan(
                      text: '\n تاريخ:17:12:12 12/07/2021 ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.5,
                      ),
                    ),
                  ]
                ),
              ),
            ],
          ),
          Image.asset('assets/salad.png'),
        ],
      ),
    );
  }
}
