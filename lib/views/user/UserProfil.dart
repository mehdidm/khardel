import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khardel/Constant.dart';
import 'package:khardel/models/user.dart';
import 'package:khardel/services/user.services.dart';
import 'package:khardel/widgets/NestedBarClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProfil extends StatefulWidget {

  final String userID;
  const UserProfil({Key key, this.userID}) : super(key: key);

  @override
  _UserProfilState createState() => _UserProfilState();
}

class _UserProfilState extends State<UserProfil> {

  UserServices get userService=>GetIt.I<UserServices>();
  bool _isLoading = false;
  TextEditingController NameController = TextEditingController();
  bool _isEnabled =false;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  var user;
  var userId;
  int Id;
  String errorMessage;

  @override
  void initState() {
    setState(() {
      _isLoading=true;
    });
    _getUserInfo();
    super.initState();
  }
  void _getUserInfo() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    userId = localStorage1.getString('id');
    print(userId);
    setState(() {
      user = userId;
      _getUserProfile(user);
      print(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'assets/logo2.png',
                  width: 200,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Image.asset(
                  'assets/profil.png',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '100',
                    style: TextStyle(color: KYellow, fontSize: 25),
                  ),
                  Text(
                    ' :مجموع النقاط',
                    style: TextStyle(color: KMauve, fontSize: 25),
                  ),
                  Image.asset('assets/gift.png'),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              NestedTabBar(userId: widget.userID.toString(),),
            ],
          ),
        ),
      ),
    );
  }

  _getUserProfile(user)async{
    await userService.getUserProfile(user.toString()).then((response) {

      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      NameController.text=response.data.username;
      print(response.data.username);
      print(response.data.email);
      print(response.data.id);
      // _titleController.text = floor.nom;
      // _contentController.text = note.noteContent;
    });


  }

}
