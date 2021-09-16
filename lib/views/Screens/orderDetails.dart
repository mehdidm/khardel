import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khardel/models/orderItem.dart';
import 'package:khardel/services/order.services.dart';
import 'package:khardel/views/Screens/Home.dart';
import 'package:khardel/views/Screens/ListOrder.dart';
import 'package:khardel/views/Screens/updateOrder.dart';
import 'package:khardel/widgets/CardWidget.dart';


class OrderDetails extends StatefulWidget {
  final orderId;
  final List list;
  OrderDetails({this.list,this.orderId});
  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  OrderServices get orderService => GetIt.I<OrderServices>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView.builder(
                //scrollDirection: Axis.vertical,
                // Let the ListView know how many items it needs to build.
                itemCount: widget.list.length,
                // Provide a builder function. This is where the magic happens.
                // Convert each item into a widget based on the type of item it is.
                itemBuilder: (context, j) {
                  List<String> supplements=[];
                  for(int i =0;i<widget.list[j]['supplements'].length;i++){
                    supplements.add(widget.list[j]['supplements'][i]);                              }
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateOrder(id: widget.list[j]['food']['_id'],)));
                        },
                        // child: OrderItemWidget(
                        //   Title1: supplements.toString(),
                        //   Title2: widget.list[j]['other'],
                        //   Title3: widget.list[j]['food']['title'],
                        // ),
                        child: GestureDetector(
                          onTap: ()async{
                            setState(() {
                              _isLoading = true;
                            });

                            var result =await orderService.deleteOrderItemFromOrder(widget.orderId,widget.list[j]['_id']);
                            widget.list.removeAt(j);
                            print(result);
                            setState(() {
                              _isLoading = false;
                            });
                          },
                          child: CardOrder(
                            orderId: widget.orderId,
                            id:  widget.list[j]['_id'],
                            foodTitle: widget.list[j]['food']['title'],
                            points:  widget.list[j]['food']['points'],
                            supplements:  widget.list[j]['supplements'],
                            qte: widget.list[j]['qte'].toString(),
                          ),
                        ),
                      ),
                      Divider(
                        height: 25,
                        thickness: 2,
                        /*indent: 20,
          endIndent: 20,*/
                      ),
                    ],
                  );
                },
              ),
            ),
          TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(isUser: true,orderId: widget.orderId,)));

          }, child: Text('اعادة الطلب'))
        ],
      ),
    );
  }
}
