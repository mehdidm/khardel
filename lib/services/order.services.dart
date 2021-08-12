import 'dart:convert';


import 'package:http/http.dart' show Client;
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/food.dart';
import 'package:khardel/models/order.dart';
import 'package:khardel/models/orderItem.dart';

class OrderServices{
  Client client = Client();

  static const API = 'https://khardel.herokuapp.com/api/orders';

  //
  Future<APIResponse<List<Order>>> getAllOrders() {
    return client
        .get(
      Uri.parse(API + '/getOrders'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Order>[];
        for (var item in jsonData['data']) {
          events.add(Order.fromJson(item));
        }
        return APIResponse<List<Order>>(data: events);
      }
      return APIResponse<List<Order>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Order>>(
        error: true, errorMessage: 'An error occured'));
  }
  Future<APIResponse<Order>> getOrder(String Id) {
    return client
        .get(
      Uri.parse(API + '/getOrder/' + Id),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Order>(data:Order.fromJson(jsonData));
      }
      return APIResponse<Order>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Order>(error: true, errorMessage: 'An error occured'));
  }
  Future<APIResponse<bool>> addOrder(Order item) {
    return client
        .post(Uri.parse(API + '/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(item.toJson()))
        .then((data) {
      if (data.statusCode == 201) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse> addOrderItemToOrder(String id,String itemId) {
    return client
        .post(
      Uri.parse(API + '/addOrderItem/$id/$itemId'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return jsonData;
      }
      return APIResponse(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse> deleteOrderItemFromOrder(String id,String itemId) {
    return client
        .post(
      Uri.parse(API + '/updateOrder/$id/$itemId'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return jsonData;
      }
      return APIResponse(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse(error: true, errorMessage: 'An error occured'));
  }

// Future<APIResponse<bool>> updateFood(String ID, Food item) {
//   return client.put(Uri.parse(API + '/' + ID),  headers: <String, String>{
//     'Content-Type': 'application/json; charset=UTF-8',
//   }, body: jsonEncode(item.toJson())).then((data) {
//     if (data.statusCode == 204) {
//       return APIResponse<bool>(data: true);
//     }
//     return APIResponse<bool>(error: true, errorMessage: 'An error occured');
//   })
//       .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
// }

// Future<APIResponse<bool>> deleteFood(String ID) {
//   return client.delete(Uri.parse(API + '/' + ID), headers: <String, String>{
//     'Content-Type': 'application/json; charset=UTF-8'}).then((data) {
//     if (data.statusCode == 204) {
//       return APIResponse<bool>(data: true);
//     }
//     return APIResponse<bool>(error: true, errorMessage: 'An error occured');
//   })
//       .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
// }
}