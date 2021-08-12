import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant.dart';

class GetOrderCard extends StatefulWidget {
  final String title;
  final String supplement;
  final String other;
  final String orderItems;
  final bool delivery;
  final bool done;
  const GetOrderCard({this.title,this.supplement,this.orderItems,this.other,this.done,this.delivery});

  @override
  _GetOrderCardState createState() => _GetOrderCardState();
}

class _GetOrderCardState extends State<GetOrderCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Column(
                      children: [
                        Center(
                          child: Text(
                            'سندويتش تربو',
                            style: TextStyle(color: KMauve, fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            children: [
                              Details(
                                title2: '8401',
                                title1: 'رمز الطلبية',
                              ),
                              Details(
                                title2: 'بطاطا و دجيز',
                                title1: 'الاضافات',
                              ),
                              Details(
                                title2: 'بدون بصل',
                                title1: 'الملاحظات',
                              ),
                              Details(
                                title2: '22-07-2021',
                                title1: 'تاريخ الطلب',
                              ),
                              Details(
                                title2: 'ملاك سويسي',
                                title1: 'اسم العميل',
                              ),
                              Details(
                                title2: '52474786',
                                title1: 'رقم هاتف العميل',
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.025,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: KGreen,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      'جاهز',
                                      style: TextStyle(color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  Text(
                                    'مع خدمات توصيل',
                                    style: TextStyle(color: KGreen, fontSize: 22),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.275,
        decoration: BoxDecoration(
          color: KGrey,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'سندويتش تربو',
              style: TextStyle(color: KMauve, fontSize: 25),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'مع خدمات توصيل',
                      style: TextStyle(color: KGreen, fontSize: 17.5),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: KGreen,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'جاهز',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '8401',
                      style: TextStyle(
                          color: KBlue.withOpacity(0.5), fontSize: 17.5),
                    ),
                    Text(
                      'بطاطا و دجيز',
                      style: TextStyle(
                          color: KBlue.withOpacity(0.5), fontSize: 17.5),
                    ),
                    Text(
                      'بدون بصل',
                      style: TextStyle(
                          color: KBlue.withOpacity(0.5), fontSize: 17.5),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.035,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'رمز الطلبية',
                      style: TextStyle(color: KBlue, fontSize: 17.5),
                    ),
                    Text(
                      'الاضافات',
                      style: TextStyle(color: KBlue, fontSize: 17.5),
                    ),
                    Text(
                      'الملاحظات',
                      style: TextStyle(color: KBlue, fontSize: 17.5),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Details extends StatelessWidget {
  final String title1;
  final String title2;

  const Details({
    Key key,
    this.title1,
    this.title2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: MediaQuery.of(context).size.width*0.3,
          child: Text(
            title2,
            textAlign: TextAlign.end,
            style: TextStyle(color: KBlue.withOpacity(0.5), fontSize: 22.5),
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width*0.1,),
        Container(
          width: MediaQuery.of(context).size.width*0.3,
          child: Text(
            title1,
            textAlign: TextAlign.end,
            style: TextStyle(
                color: KBlue,
                fontSize: 22.5),
          ),
        ),
      ],
    );
  }
}
