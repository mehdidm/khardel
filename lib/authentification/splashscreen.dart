import 'package:flutter/material.dart';
import 'package:khardel/Constant.dart';
import 'package:khardel/authentification/SignIn.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Color(0xFF1C3956), BlendMode.dstATop),
                  image: ExactAssetImage('assets/bg.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
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
                        'إبدأ',
                        style: TextStyle(
                            fontFamily: 'arial',
                            fontSize: 25,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.08,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
