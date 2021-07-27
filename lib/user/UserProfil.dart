import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/Constant.dart';
import 'package:khardel/widgets/NestedBarClient.dart';

class UserProfil extends StatefulWidget {
  const UserProfil({Key key}) : super(key: key);

  @override
  _UserProfilState createState() => _UserProfilState();
}

class _UserProfilState extends State<UserProfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
              NestedTabBar(),
            ],
          ),
        ),
      ),
    );
  }
}
