import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/views/shared/constant.dart';

class ItemMenu extends StatefulWidget {
  final String title;
  final String price;
  final String image;

  const ItemMenu({Key key, this.title, this.price, this.image}) : super(key: key);
  @override
  _ItemMenuState createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 160,
          //BoxDecoration Widget
          decoration: BoxDecoration(
            //DecorationImage
            //  color: Color(0xffF6F6F6), //Border.all
            color: Colorbg, //Border.all
            borderRadius: BorderRadius.circular(15),
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0 , horizontal: 5),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.image,
                      height: 70,
                    ),
                    Text(

                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 25),
                    ),
                    Text(
                      widget.price,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xffC8A112),
                          fontSize: 18),
                    ),
                  ],
                ),

                Align(
                  alignment:Alignment(0, 1.4),
                  child: CircleAvatar(

                    backgroundColor: ColorMv,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ), //BoxDecoration
        ),
        SizedBox(height: 30,)
      ],
    );
  }
}
