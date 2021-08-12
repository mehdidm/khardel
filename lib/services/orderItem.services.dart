import 'dart:convert';


import 'package:http/http.dart' show Client;
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/food.dart';
import 'package:khardel/models/orderItem.dart';

class OrderItemServices{
  Client client = Client();

  static const API = 'https://khardel.herokuapp.com/api/orders';

  //
  Future<APIResponse<List<OrderItem>>> getAllOrderItems() {
    return client
        .get(
      Uri.parse(API + '/getOrderItems'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <OrderItem>[];
        for (var item in jsonData) {
          events.add(OrderItem.fromJson(item));
        }
        return APIResponse<List<OrderItem>>(data: events);
      }
      return APIResponse<List<OrderItem>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<OrderItem>>(
        error: true, errorMessage: 'An error occured'));
  }
  Future<APIResponse<OrderItem>> getOrderItem(String Id) {
    return client
        .get(
      Uri.parse(API + '/getOrderItem/' + Id),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<OrderItem>(data:OrderItem.fromJson(jsonData));
      }
      return APIResponse<OrderItem>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<OrderItem>(error: true, errorMessage: 'An error occured'));
  }
  Future<APIResponse<bool>> addOrderItem(OrderItem item) {
    return client
        .post(Uri.parse(API + '/addOrderItem'),
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

  Future<APIResponse> addSuppToOrderItem(String id,String suppId) {
    return client
        .post(
      Uri.parse(API + '/addSupplement/$id/$suppId'),
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

  Future<APIResponse> deleteSuppFromOrderItem(String id,String suppId) {
    return client
        .post(
      Uri.parse(API + '/deleteSuppelement/$id/$suppId'),
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