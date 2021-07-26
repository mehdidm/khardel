import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:khardel/views/shared/constant.dart';

class ItemCat extends StatefulWidget {
  final String title;
  final String image;

  const ItemCat({Key key, this.title, this.image}) : super(key: key);


  @override
  _ItemCatState createState() => _ItemCatState();
}

class _ItemCatState extends State<ItemCat> {
  Color color = Colorbg ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0 , horizontal: 5),
      child: Column(

        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                color  == Colorbg ? color = ColorMv : color = Colorbg  ;
              });
            },

            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.2,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color :  color,
                child: Image.asset(
                  widget.image,
                  scale: 2,
                ),


              ),
            ),
          ),
          SizedBox(height: 10,),
          Text(
            widget.title,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 15
            ),
          )
        ],
      ),
    );
  }
}
