import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final String _url = 'https://khardel.herokuapp.com/api/';

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  Future register(item) async {
    final response = await http.post(
        Uri.parse('https://khardel.herokuapp.com/api/auth/signup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(item));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('exception occured!!!!!!');
    }
  }

  updateData(data, apiUrl,userId) async {
    var fullUrl = _url + apiUrl + userId;
    return await http.put(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  // Future register(item) async {
  //   final response =
  //   await client.post(Uri.parse('http://10.0.2.2:3000/users/register'),headers: <String, String>{
  //     'Content-Type': 'application/json; charset=UTF-8'},body: jsonEncode(item.toJson()));
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('exception occured!!!!!!');
  //   }
  // }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl + await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  Future getProfile(apiUrl, token) async {
    return await http.get(
      Uri.parse(_url + apiUrl),
      // Send authorization headers to the backend.
      headers: {
        HttpHeaders.authorizationHeader: token,
      },
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }
}
