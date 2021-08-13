import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constant.dart';

class ListOrders extends StatefulWidget {
  const ListOrders({Key key}) : super(key: key);

  @override
  _ListOrdersState createState() => _ListOrdersState();
}

class _ListOrdersState extends State<ListOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
        color: Color(0xFFFDFDFD),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                'assets/logo2.png',
                width: MediaQuery.of(context).size.width*0.55,
              ),
              SizedBox(height: 20,),
              Center(
                child: Text(
                  'قائمة الطلبات',
                  style: TextStyle(
                    color: KMauve,
                    fontSize: 32.5
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  margin: EdgeInsets.only(top: 20),
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width*0.85,
                  decoration: BoxDecoration(
                    color: KGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'مع خدمات توصيل',
                                  style: TextStyle(
                                      color: KGreen,
                                      fontSize: 20
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  padding: EdgeInsets.symmetric(horizontal: 12.5, vertical: 2.5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: KGreen,
                                  ),
                                  child: Text(
                                    'جاهز',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            RichText(text: TextSpan(
                              children: [
                                TextSpan(
                                    text: '1234 ',
                                  style: TextStyle(
                                    color: KBlue.withOpacity(0.5),
                                    fontSize: 20
                                  )

                                ),
                                TextSpan(
                                  text: ' :رمز الطلبية ',
                                  style: TextStyle(
                                    color: KBlue,
                                    fontSize: 20
                                  )
                                ),
                              ]
                            ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Text(
                          'سندويتش تربو',
                          style: TextStyle(
                              color: KMauve,
                              fontSize: 20
                          ),
                        ),
                        SizedBox(height: 10,),
                        OrderItem(
                          Title1: 'بطاطا و دجيز ',
                          Title2: 'بدون بصل ',
                          Title3: 'الاضافات ',
                          Title4: 'الملاحظات ',
                        ),
                        Divider(
                          height: 25,
                          thickness: 2,
                          /*indent: 20,
                          endIndent: 20,*/
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String Title1;
  final String Title2;
  final String Title3;
  final String Title4;
  const OrderItem({
    Key key, this.Title1, this.Title2, this.Title3, this.Title4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          children: [
            Text(
              Title1,
              style: TextStyle(
                  color: KBlue.withOpacity(0.5),
                  fontSize: 17.5
              ),
            ),
            Text(
              Title2,
              style: TextStyle(
                  color: KBlue.withOpacity(0.5),
                  fontSize: 17.5
              ),
            ),
          ],
        ),
        SizedBox(width: 20,),
        Column(
          children: [
            Text(
              Title3,
              style: TextStyle(
                  color: KBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.5
              ),
            ),
            Text(
              Title4,
              style: TextStyle(
                  color: KBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.5
              ),
            ),
          ],
        ),
      ],
    );
  }
}
