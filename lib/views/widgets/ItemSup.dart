import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/views/shared/constant.dart';

class ItemSup extends StatefulWidget {

  final String image;

  const ItemSup({Key key, this.image}) : super(key: key);
  @override
  _ItemSupState createState() => _ItemSupState();
}

class _ItemSupState extends State<ItemSup> {
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
                color  == Colorbg ? color = ColorGl : color = Colorbg  ;
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
                  scale: 1.4,
                ),


              ),
            ),
          ),

        ],
      ),
    );
  }
}
