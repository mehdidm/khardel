import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/Constant.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:khardel/api/api.dart';
import 'package:khardel/models/user.dart';
import 'package:khardel/views/Screens/Acceuil.dart';
import 'package:khardel/views/Screens/Home.dart';
import 'package:khardel/views/authentification/SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 150,
                  width: 150,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  color: KGrey,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(color: KMauve, fontSize: 25),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      InputWidget(
                        controller: NameController,
                        obscure: false,
                        hint: 'اسم االمستخدم',
                        valid: (value) {
                          if (value.isNotEmpty && value.length > 4) {
                            return null;
                          } else if (value.isNotEmpty && value.length < 3) {
                            return 'أدخل اسمك الصحيح';
                          } else if (value.isEmpty){
                            return 'أدخل أسمك!!';
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      InputWidget(
                        controller: passwordController,
                        hint: 'كلمه السر',
                        obscure: true,
                        valid: (value) {
                          if (value.isEmpty) {
                            return 'يجب ألا تكون كلمة المرور فارغة';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'نسيت كلمة السر',
                            style: TextStyle(
                              color: KBlue,
                              fontSize: 18.5,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  'تذكر',
                                  style: TextStyle(color: KBlue, fontSize: 18.5),
                                ),
                                FlutterSwitch(
                                  width: 35.0,
                                  height: 20.0,
                                  valueFontSize: 12.0,
                                  toggleSize: 18.0,
                                  activeColor: KBlue,
                                  value: value,
                                  onToggle: (val) {
                                    setState(() {
                                      value = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.035,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            if(!_formkey.currentState.validate()) {
                              return;
                            }
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => Home(roles:b)));
                            _login();
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.075,
                            width: MediaQuery.of(context).size.width * 0.5,
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
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignUp()));
                        },
                        child: Center(
                          child: Text.rich(
                            TextSpan(
                              text: 'ليس لديك حساب؟ ',
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'username': NameController.text,
      'password': passwordController.text
    };

    var res = await CallApi().postData(data, 'auth/signin');
    var body = json.decode(res.body);
    //if(res.hashCode==200){
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('token', body['accessToken']);
    token = body['accessToken'];
    print(body);
    print(token);
    // final User user= User(
    //   id: body['_id'],
    //   username: body['username'],
    //   email: body['email'],
    //   password: body['password'],
    //   role: body['roles']
    // );
    localStorage.setString('username', body['username']);
    localStorage.setString('email', body['email']);
    localStorage.setStringList('roles', body['roles'].cast<String>());
    localStorage.setString('id', body['id']);
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => Acceuil()));
    // }else{
    //   print('error');
    // }

    setState(() {
      _isLoading = false;
    });
  }
}

class InputWidget extends StatelessWidget {
  final String hint;
  final bool obscure;
  final Function valid;
  final TextEditingController controller;
  const InputWidget({Key key, this.hint, this.controller, this.valid, this.obscure})
      : super(key: key);

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
        TextFormField(
          obscureText: obscure,
          validator: valid,
          controller: controller,
          decoration: InputDecoration(
              border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        )
      ],
    );
  }
}
