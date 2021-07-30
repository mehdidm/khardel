import 'package:flutter/material.dart';
import 'package:khardel/widgets/GetOrderCard.dart';

import '../../Constant.dart';


class GetOrder extends StatefulWidget {
  const GetOrder({Key key}) : super(key: key);

  @override
  _GetOrderState createState() => _GetOrderState();
}

class _GetOrderState extends State<GetOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/logo2.png',
                  width: 200,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'قائمة الطلبات',
                style: TextStyle(
                  color: KMauve,
                  fontSize: 35
                ),
              ),
              GetOrderCard(),

            ],
          ),
        ),
      ),
    );
  }
}
