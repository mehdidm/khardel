import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/Constant.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:khardel/authentification/SignIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool value = true;

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
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                  InputWidget(
                    hint: 'البريد الإلكتروني',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                  InputWidget(
                    hint: 'كلمه السر',
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.015,),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
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
}

class InputWidget extends StatelessWidget {

  final String hint;

  const InputWidget({
    Key key, this.hint,
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
