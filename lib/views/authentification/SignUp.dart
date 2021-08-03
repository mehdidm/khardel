import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/Constant.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:khardel/api/api.dart';
import 'package:khardel/models/user.dart';
import 'package:khardel/views/Screens/Home.dart';
import 'package:khardel/views/authentification/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool value = true;
  TextEditingController NameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  String token;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Center(
              child: Image.asset(
                'assets/logo.png',
                height: 200,
                width: 200,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)),
                color: KGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                        color: KMauve,
                        fontSize: 25
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  InputWidget(
                    hint: 'اسم االمستخدم',
                    controller: NameController,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                  InputWidget(
                    hint: 'البريد الإلكتروني',
                    controller: mailController,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                  InputWidget(
                    hint: 'كلمه السر',
                    controller: passwordController,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _handleLogin();

                        });

                        //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.075,
                        width: MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: KMauve,
                        ),
                        child: Center(
                          child: Text(
                            'اشترك',
                            style: TextStyle(
                                fontFamily: 'arial',
                                fontSize: 25,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Center(
                      child: Text.rich(
                        TextSpan(
                          text: 'لديك حساب؟',
                          style: TextStyle(fontSize: 20),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' اشترك',
                                style: TextStyle(
                                  color: KBlue,
                                  decoration: TextDecoration.underline,
                                )),
                            // can add more TextSpans here...
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'username' : NameController.text,
      'email' : mailController.text,
      'password' : passwordController.text,
    };
    print(NameController.text);
    print(mailController.text);
    print(passwordController.text);

    var res = await CallApi().postData(data, 'auth/signup');
    var body = json.decode(res.body);
    print(body);
    // if(body['Status']==200){
    //
    //   SharedPreferences localStorage = await SharedPreferences.getInstance();
    //   localStorage.setString('token', body['token']);
    //   token=body['token'];
    //   //localStorage.setString('user', json.encode(body['user']));
    //
    //   Navigator.push(
    //       context,
    //       new MaterialPageRoute(
    //           builder: (context) => Home()));
    // }else {
    //   showError(body['error']);
    // }

    //}




    setState(() {
      _isLoading = false;
    });



  }

  showError(msg){
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Done'),
          content: Text(msg.toString()),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }
}

class InputWidget extends StatelessWidget {

  final String hint;
  final TextEditingController controller;
  const InputWidget({
    Key key, this.hint,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          hint,
          style: TextStyle(
            color: KBlue,
            fontSize: 22.5,
          ),
        ),
        //SizedBox(height: 10,),
        TextField(
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )
          ),
        )
      ],
    );
  }

}
