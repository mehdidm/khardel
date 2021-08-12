import 'dart:convert';


import 'package:http/http.dart' show Client;
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/category.dart';
import 'package:khardel/models/food.dart';
import 'package:khardel/models/supplement.dart';

class SupplementServices{
  Client client = Client();

  static const API = 'https://khardel.herokuapp.com/api/supplements';


  Future<APIResponse<List<Supplement>>> getAllSupplements() {
    return client
        .get(
      Uri.parse(API + '/'),
    )
        .then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        final events = <Supplement>[];
        for (var item in jsonData) {
          events.add(Supplement.fromJson(item));
        }
        return APIResponse<List<Supplement>>(data: events);
      }
      return APIResponse<List<Supplement>>(
          error: true, errorMessage: 'An error occured');
    }).catchError((_) => APIResponse<List<Supplement>>(
        error: true, errorMessage: 'An error occured'));
  }

  Future<APIResponse<bool>> addSupplement(Supplement item) {
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

  Future<APIResponse<bool>> updateSupplement(String ID, Supplement item) {
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

  Future<APIResponse<bool>> deleteSupplement(String ID) {
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