import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khardel/Constant.dart';
import 'package:khardel/services/order.services.dart';

class CardOrder extends StatefulWidget {
  final id;
  final orderId;
  final String qte;
  final String foodTitle;
  final List supplements;
  final String date;
  final String points;

  CardOrder({this.foodTitle,this.qte,this.supplements,this.date,this.points,this.id,this.orderId});

  @override
  _CardOrderState createState() => _CardOrderState();
}

class _CardOrderState extends State<CardOrder> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(
        color: KGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  '${widget.qte}',
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
                          text:  '${widget.foodTitle}',
                          style: TextStyle(
                            color: KBlue,
                            fontSize: 20,
                          ),
                        ),
                        TextSpan(
                          text: '\n  ${widget.supplements} ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: '\n عدد نقاط الوجبة: ${widget.points}',
                          style: TextStyle(
                            color: KBlue,
                            fontSize: 15,
                          ),
                        ),
                        TextSpan(
                          text: '\n تاريخ: 12/07/2021 ',
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
         Container(
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(5),
             border: Border.all(color: Colors.red),
           ),
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 2),
             child: Text('حذف',style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 18,
               color: Colors.red
             ),),
           ),
         )
        ],
      ),
    );
  }
}
