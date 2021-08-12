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
  final Food food=Food();
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
              TextButton(
                onPressed: (){
                  _fetchCategories();
                },
                child: Text(
                  'قائمة الطلبات',
                  style: TextStyle(
                    color: KMauve,
                    fontSize: 35
                  ),
                ),
              ),
              //_buildListCategoriesWidgets(),
            ],
          ),
        ),
      ),
    );
  }
  _buildListCategoriesWidgets() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: ListView.builder(
        //scrollDirection: Axis.horizontal,
        // Let the ListView know how many items it needs to build.
        itemCount: listOrders.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          return GetOrderCard();
        },
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

    // final response = await http
    //     .get(Uri.parse('https://khardel.herokuapp.com/api/orders/getOrders'));
    //
    // if (response.statusCode == 200) {
    //   // If the server did return a 200 OK response,
    //   // then parse the JSON.
    //   print(jsonDecode(response.body)['data']);
    //   return Order.fromJson(jsonDecode(response.body)['data']);
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   throw Exception('Failed to load album');
    // }
  }

  _buildListCategories() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _orderResponse.data.length; i++) {
      print(_orderResponse.data[i].orderItems);
      listOrders.add(_orderResponse.data[i]);
    }
    print(listOrders);
    setState(() {
      _isLoading = false;
    });
  }

  _buildListOrderItems(){
    for(int i=0;i<listOrders.length;i++){
      var orderItems = [];
      orderItems=listOrders[i].orderItems;
      for(int j =0; j <orderItems.length;j++){
         orderItemService.getOrderItem(orderItems[j].toString()).then((value) {
           OrderItem orderItem=value.data;
           listOrderItems.add(orderItem);
           print(listOrderItems.length);
         });
      }
    }
  }

  _getFood(){
    for(int i=0;i<listOrderItems.length;i++){
        foodService.getFood(listOrderItems[i].food.toString()).then((value) {
          Food food=value.data;
          print(food);
        });
      }
    }

  }

