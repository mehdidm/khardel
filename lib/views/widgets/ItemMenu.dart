import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/views/Screens/ModifierMenu.dart';
import 'package:khardel/views/Screens/Order.dart';
import 'package:khardel/views/shared/constant.dart';

class ItemMenu extends StatefulWidget {
  final String title;
  final String price;
  final String image;
  final String id;
  final bool role;
  final bool available;

  const ItemMenu({Key key, this.title, this.price, this.image, this.id, this.role, this.available}) : super(key: key);



  @override
  _ItemMenuState createState() => _ItemMenuState();
}

class _ItemMenuState extends State<ItemMenu> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>ModifierMenu(id:widget.id)));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Order(id: widget.id)));
      },
      child: Column(
        children: [
          Container(
            // width: 120,
            height: MediaQuery.of(context).size.height * 0.2,
            //BoxDecoration Widget
            decoration: BoxDecoration(
              //DecorationImage
              //  color: Color(0xffF6F6F6), //Border.all
              color: Color(0xffededed), //Border.all
              borderRadius: BorderRadius.circular(15),
            ),

            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Image.asset(
                            widget.image,
                            height: 50,
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            width: 100,
                            child: Text(
                              widget.title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            widget.price,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xffC8A112),
                                fontSize: 18),
                          ),
                        ),
                        widget.role
                            ? CircleAvatar(
                                radius: 12,
                                backgroundColor: ColorMv,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: ColorMv,
                                    child: Icon(
                                      Icons.edit,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: ColorMv,
                                    child: Icon(
                                      Icons.delete_outlined,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),
                ),
               widget.available ?
               Opacity(
                 opacity: 1,

               ) :
               Opacity(
                  opacity: 0.8,
                  child: Container(
                    // width: 120,
                    height: MediaQuery.of(context).size.height * 0.2,
                    //BoxDecoration Widget
                    decoration: BoxDecoration(
                      //DecorationImage
                      //  color: Color(0xffF6F6F6), //Border.all
                      color: Color(0xffededed), //Border.all
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.not_interested,
                      size: 80,
                      color: Colors.grey,),
                    ),
                  ),
                ),
              ],
            ), //BoxDecoration
          ),
          //SizedBox(height: 30,)
        ],
      ),
    );
  }
}
