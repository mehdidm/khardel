import 'dart:convert';


import 'package:http/http.dart' show Client;
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/category.dart';


class CategoriesServices{
  Client client = Client();

  static const API = 'https://khardel.herokuapp.com/api/categories';


  Future<APIResponse<List<Category>>> getAllCategories() {
    return client
        .get(
      Uri.parse(API + '/'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Category>[];
        for (var item in jsonData) {
          events.add(Category.fromJson(item));
        }
        return APIResponse<List<Category>>(data: events);
      }
      return APIResponse<List<Category>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Category>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> addCategory(Category item) {
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

  Future<APIResponse<bool>> updateCategory(String ID, Category item) {
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

  Future<APIResponse<bool>> deleteCategory(String ID) {
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