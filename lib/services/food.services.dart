import 'dart:convert';


import 'package:http/http.dart' show Client;
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/food.dart';

class FoodsServices{
  Client client = Client();

  static const API = 'https://khardel.herokuapp.com/api/foods';


  Future<APIResponse<List<Food>>> getAllFood() {
    return client
        .get(
      Uri.parse(API + '/'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Food>[];
        for (var item in jsonData) {
          events.add(Food.fromJson(item));
        }
        return APIResponse<List<Food>>(data: events);
      }
      return APIResponse<List<Food>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Food>>(
        error: true, errorMessage: 'An error occured'));
  }


  Future<APIResponse<List<Food>>> findFoodByCategory(String id) {
    return client
        .get(
      Uri.parse(API + '/category/'+id),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Food>[];
        for (var item in jsonData) {
          events.add(Food.fromJson(item));
        }
        return APIResponse<List<Food>>(data: events);
      }
      return APIResponse<List<Food>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Food>>(
        error: true, errorMessage: 'An error occured'));
  }
  Future<APIResponse<Food>> getFood(String Id) {
    return client
        .get(
      Uri.parse(API + '/' + Id),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        return APIResponse<Food>(data: Food.fromJson(jsonData));
      }
      return APIResponse<Food>(error: true, errorMessage: 'An error occured');
    }).catchError((_) =>
        APIResponse<Food>(error: true, errorMessage: 'An error occured'));
  }
  Future<APIResponse<bool>> addFood(Food item) {
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

  Future<APIResponse<bool>> updateFood(String ID, Food item) {
    return client.put(Uri.parse(API + '/' + ID),  headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: jsonEncode(item.toJson())).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> deleteFood(String ID) {
    return client.delete(Uri.parse(API + '/' + ID), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'}).then((data) {
      if (data.statusCode == 204) {
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }
}