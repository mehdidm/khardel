import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/food.dart';
import 'package:khardel/models/order.dart';
import 'package:khardel/models/orderItem.dart';
import 'package:khardel/models/supplement.dart';
import 'package:khardel/services/food.services.dart';
import 'package:khardel/services/order.services.dart';
import 'package:khardel/services/orderItem.services.dart';
import 'package:khardel/services/supplement.services.dart';
import 'package:khardel/views/Screens/ListOrder.dart';
import 'package:khardel/widgets/GetOrderCard.dart';
import 'package:http/http.dart' as http;
import '../../Constant.dart';

class GetOrder extends StatefulWidget {
  const GetOrder({Key key}) : super(key: key);

  @override
  _GetOrderState createState() => _GetOrderState();
}

class _GetOrderState extends State<GetOrder> {
  OrderServices get orderService => GetIt.I<OrderServices>();
  OrderItemServices get orderItemService => GetIt.I<OrderItemServices>();
  FoodsServices get foodService => GetIt.I<FoodsServices>();
  SupplementServices get supplementService => GetIt.I<SupplementServices>();
  bool _isLoading = false;
  final List<Order> listOrders = [];
  final List<OrderItem> listOrderItems = [];
  final List<Supplement> listSupplements = [];
  final Food food = Food();
  APIResponse<List<Order>> _orderResponse;

  @override
  void initState() {
    _fetchCategories();
    super.initState();
  }

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
                style: TextStyle(color: KMauve, fontSize: 35),
              ),
              _buildOrderListWidgets(listOrders),
            ],
          ),
        ),
      ),
    );
  }

  _fetchCategories() async {
    setState(() {
      _isLoading = true;
    });

    _orderResponse = await orderService.getAllOrders();
    print(_orderResponse.data);
    _buildListCategories();
    setState(() {
      _isLoading = false;
    });

  }

  _buildListCategories() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _orderResponse.data.length; i++) {
      print(_orderResponse.data[i].orderItems);
      listOrders.add(_orderResponse.data[i]);
    }
    print(listOrders.length);
    _buildListOrderItems();
    setState(() {
      _isLoading = false;
    });
  }

  _buildListOrderItems() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < listOrders.length; i++) {
      final List orderItems = listOrders[i].orderItems;
      print(orderItems);
      for (int j = 0; j < orderItems.length; j++) {
        print(orderItems[j]['_id']);
        orderItemService.getOrderItem(orderItems[j]['_id']).then((value) {
          OrderItem orderItem = value.data;
          print(orderItem.food);
          listOrderItems.add(orderItem);

        });
       return _buildOrderListWidgets(listOrders);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  _buildOrderListWidgets(
      List<Order> listOrders) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: ListView.builder(
        //scrollDirection: Axis.vertical,
        // Let the ListView know how many items it needs to build.
        itemCount: listOrders.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
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

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  children: [
                                    Details(
                                      title2: listOrders[index].code,
                                      title1: 'رمز الطلبية',
                                    ),
                                    // Details(
                                    //   title2: 'بطاطا و دجيز',
                                    //   title1: 'الاضافات',
                                    // ),
                                    Details(
                                      title2: listOrders[index].deliveryDate.toString(),
                                      title1: 'تاريخ التوصيل',
                                    ),
                                    Details(
                                      title2: listOrders[index].createdAt.toString(),
                                      title1: 'تاريخ الطلب',
                                    ),
                                    Details(
                                      title2: listOrders[index].userId['username'],
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
                                            color: listOrders[index].done?KGreen:Colors.black54,
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Text(
                                            'جاهز',
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                        Text(
                                          listOrders[index].delivery?'مع خدمات توصيل':'',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width * 0.85,
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
                                    listOrders[index].delivery
                                        ? 'مع خدمات توصيل'
                                        : '',
                                    style: TextStyle(color: KGreen, fontSize: 20),
                                  ),
                                  GestureDetector(
                                    onTap: ()async{
                                      print(listOrders[index].id);
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      final order=Order(
                                        userId: listOrders[index].userId,
                                          delivery: listOrders[index].delivery,
                                          orderItems: listOrders[index].orderItems,
                                          createdAt: listOrders[index].createdAt,
                                          deliveryDate: listOrders[index].deliveryDate,
                                          id: listOrders[index].id,
                                          code: listOrders[index].code,
                                          done: true
                                      );

                                      final result = await orderService.updateOrder(listOrders[index].id.toString(), order);
                                        print(result);
                                      setState(() {
                                        listOrders[index].done=true;

                                        _isLoading = false;
                                      });
                                      //
                                      // final title = 'Done';
                                      // final text = result.error
                                      //     ? (result.errorMessage ?? 'An error occurred')
                                      //     : 'Your order was updated';
                                      //
                                      // showDialog(
                                      //     context: context,
                                      //     builder: (_) => AlertDialog(
                                      //       title: Text(title),
                                      //       content: Text(text),
                                      //       actions: <Widget>[
                                      //         FlatButton(
                                      //           child: Text('Ok'),
                                      //           onPressed: () {
                                      //             Navigator.of(context).pop();
                                      //           },
                                      //         )
                                      //       ],
                                      //     ));

                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 15),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.5, vertical: 2.5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: listOrders[index].done?KGreen:Colors.black54,
                                      ),
                                      child: Text(
                                        'جاهز',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: listOrders[index].code,
                                      style: TextStyle(
                                          color: KBlue.withOpacity(0.5),
                                          fontSize: 20)),
                                  TextSpan(
                                      text: ' :رمز الطلبية ',
                                      style:
                                          TextStyle(color: KBlue, fontSize: 20)),
                                ]),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.65,
                            child: ListView.builder(
                              //scrollDirection: Axis.vertical,
                              // Let the ListView know how many items it needs to build.
                              itemCount: listOrders[index].orderItems.length,
                              // Provide a builder function. This is where the magic happens.
                              // Convert each item into a widget based on the type of item it is.
                              itemBuilder: (context, j) {
                                List<String> supplements=[];
                                for(int i =0;i<listOrders[index].orderItems[j]['supplements'].length;i++){
                                   supplements.add(listOrders[index].orderItems[j]['supplements'][i]['title']);                              }
                                return Column(
                                  children: [
                                    OrderItemWidget(
                                      Title1: supplements.toString(),
                                      Title2: listOrders[index].orderItems[j]['other'],
                                      Title3: listOrders[index].orderItems[j]['food']['title'],
                                    ),
                                    Divider(
                                      height: 25,
                                      thickness: 2,
                                      /*indent: 20,
                        endIndent: 20,*/
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _buildItem() {
    return Column(
      children: [
        OrderItemWidget(
          Title1: 'بطاطا و دجيز ',
          Title2: 'بدون بصل ',
          Title3: 'الاضافات ',
        ),
        Divider(
          height: 25,
          thickness: 2,
          /*indent: 20,
                      endIndent: 20,*/
        ),
      ],
    );
  }
}
