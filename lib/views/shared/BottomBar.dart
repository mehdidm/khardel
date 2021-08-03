import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/views/Screens/AddMenu.dart';

import 'constant.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
         Icon(
           Icons.home ,
           color: ColorMv,
           size: 30,
         ) ,
         GestureDetector(
           onTap: (){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>AddMenu()));
           },
           child: CircleAvatar(
       maxRadius: 25,
               backgroundColor: ColorMv,
               child:
               Icon(
                 Icons.add ,
                 color: Colors.white,
                 size: 25,
               )
           ),
         ),
         Icon(
           Icons.shopping_cart ,
           color: ColorMv,
           size: 30,
         )
       ],

      ),
    );
  }
}
