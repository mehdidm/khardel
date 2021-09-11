//                     _buildListOrderItemsWidgets(),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           _addItem();
//                         },
//                         child: Text(
//                           'تأكيد الطلب',
//                           textAlign: TextAlign.center,
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           shape: StadiumBorder(),
//                           primary: ColorMv,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
//
//   // _fetchOrderItems() async {
//   //   _orderItemResponse = await orderItemService.getAllOrderItems();
//   //   print(_orderItemResponse.data);
//   //    _getFoodItem();
//   //    _buildListOrderItems();
//   //   setState(() {
//   //     _isLoading = false;
//   //   });
//   // }
//
//   _buildListOrderItems() {
//     setState(() {
//       _isLoading = true;
//     });
//
//     for (int i = 0; i < _orderItemResponse.data.length; i++) {
//       listOrderItems.add(_orderItemResponse.data[i]);
//       listOrderItemIds.add(_orderItemResponse.data[i].id);
//     }
//     print(listOrderItems);
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   _getFoodItem() async {
//     Food food = Food();
//     for (var item in _orderItemResponse.data) {
//       setState(() {
//         _isLoading = true;
//       });
//       foodService.getFood(item.food.toString()).then((response) {
//         setState(() {
//           _isLoading = false;
//         });
//
//         if (response.error) {
//           errorMessage = response.errorMessage ?? 'An error occurred';
//         }
//         food = response.data;
//         listFoodItems.add(food);
//         print(listFoodItems);
//       });
//     }
//   }
//
//   _buildListOrderItemsWidgets() {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.55,
//       child: ListView.builder(
//         //scrollDirection: Axis.vertical,
//         // Let the ListView know how many items it needs to build.
//         itemCount: listOrderItems.length,
//         // Provide a builder function. This is where the magic happens.
//         // Convert each item into a widget based on the type of item it is.
//         itemBuilder: (context, index) {
//           return Dismissible(
//             //direction: DismissDirection.startToEnd,
//             // confirmDismiss:(direction) {
//             //   _removeOrderItem("611260ddfe44ad0015bacb94", listOrderItems[index].id);
//             // },
//             child: Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Container(
//                         child: Padding(
//                           padding: const EdgeInsets.only(top: 0),
//                           child: Column(
//                             children: [
//                               Icon(
//                                 Icons.remove_circle_outline_sharp,
//                                 size: 40,
//                                 color: ColorMv,
//                               ),
//                               SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width *
//                                         0.02,
//                               ),
//                               Text(
//                                   listOrderItems[index]
//                                       .quantity
//                                       .toString(),
//                                   style: TextStyle(fontSize: 25)),
//                               SizedBox(
//                                 width:
//                                     MediaQuery.of(context).size.width *
//                                         0.02,
//                               ),
//                               Icon(
//                                 Icons.add_circle_outline,
//                                 size: 40,
//                                 color: ColorMv,
//                               )
//                             ],
//                           ),
//                         ),
//                         // width: MediaQuery.of(context).size.height * 0.1,
//                         // height:
//                         //     MediaQuery.of(context).size.width * 0.15,
//                         //BoxDecoration Widget
//                         decoration: BoxDecoration(
//                           color: Color(0xffE9DFDF),
//                           //Border.all
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                             vertical: 5, horizontal: 30),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Text(
//                               listFoodItems[index].title,
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 25,
//                               ),
//                             ),
//                             Text(
//                               "عدد نقاط الوجبة",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20,
//                               ),
//                             ),
//                             Text(
//                               listFoodItems[index].price,
//                               style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 20,
//                                   color: ColorGl),
//                             ),
//                           ],
//                         ),
//                       ),
//
//                       Image.asset('assets/images/sandwich.png'),
//                       //DecorationImage
//                     ],
//                   ),
//                   Text(
//                     "عدد نقاط الوجبة : ${listFoodItems[index].points} ",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: ColorBlue,
//                       fontSize: 20,
//                     ),
//                   ),
//                 ],
//               ),
//              // width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * 0.25,
//               //BoxDecoration Widget
//               decoration: BoxDecoration(
//                 color: Color(0xffF6F6F6), //Border.all
//                 borderRadius: BorderRadius.circular(15),
//               ), //BoxDecoration
//             ),
//             background: Container(
//               height: MediaQuery.of(context).size.height * 0.25,
//
//               color: ColorMv,
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 10),
//                 child: Align(
//                     alignment: Alignment.centerRight,
//                     child: Icon(
//                       Icons.delete_outlined,
//                       size: 60,
//                       color: Colors.white,
//                     )),
//               ),
//             ),
//             key: ValueKey("my"),
//             direction: DismissDirection.endToStart,
//             onDismissed: (direction) {},
//             confirmDismiss: (direction){},
//           );
//         },
//       ),
//     );
//   }

//
//   _removeOrderItem(id,itemId) async{
//     final result = await showDialog(
//         context: context, builder: (_) => FloorDelete());
//
//     if (result) {
//       final deleteResult =
//       await orderService.deleteOrderItemFromOrder(id, itemId);
//      // _fetchOrderItems();
//
//       var message = 'The floor was deleted successfully';
//
//
//
//       return deleteResult?.data ?? false;
//     }
//     print(result);
//     return result;
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khardel/Constant.dart';
import 'package:khardel/views/shared/Appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get_it/get_it.dart';
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/food.dart';
import 'package:khardel/models/orderItem.dart';
import 'package:khardel/services/cartModelView.dart';
import 'package:khardel/services/food.services.dart';
import 'package:khardel/services/orderItem.services.dart';
import 'package:khardel/views/shared/constant.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  OrderItemServices get orderItemService => GetIt.I<OrderItemServices>();
  APIResponse<List<OrderItem>> _orderItemResponse;
  FoodsServices get foodService => GetIt.I<FoodsServices>();
  String errorMessage;
  Future<APIResponse<Food>> _foodResponse;
  List<Food> listFoodItems = [];
  var controller = Get.put(AddToCartVM());
  RxDouble totalCartPrice = 0.0.obs;

  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState

    //  _getFoodItem();
    super.initState();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    controller = Get.put(AddToCartVM());
    //_getFoodItem();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    var screenSize = MediaQuery.of(context).size;
    return GetBuilder<AddToCartVM>(
      // specify type as Controller
      //init: AddToCartVM(), // intialize with the Controller
      init: AddToCartVM(),
      builder: (value) => Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("طلبك (${value.lst.length})",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: ColorMv)),
                          SizedBox(width: y * 0.03),
                          Icon(
                            Icons.assignment_outlined,
                            color: ColorMv,
                            size: 25,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "  المجموع",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: ColorMv),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' : ${value.getTotalPrice()} شيكل',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorGl)),
                              ],
                            ),
                          ),
                          SizedBox(width: y * 0.01),
                          Icon(
                            Icons.monetization_on_outlined,
                            color: ColorMv,
                            size: 30,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "  مجموع النقاط",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: ColorMv),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' : ${value.getTotalPoints()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorGl)),
                              ],
                            ),
                          ),
                          SizedBox(width: y * 0.01),
                          Icon(
                            Icons.card_giftcard,
                            color: ColorMv,
                            size: 30,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextButton(
                  onPressed: ()async{
                    setState(() {
                      _isLoading = true;
                    });
                    final List<OrderItem> item = [];
                    print(value.lst.length);
                    for (int i = 0; i < value.lst.length; i++) {
                      item.add(OrderItem(
                        userId: '60f89ad57ceda214d885fdb7',
                        supplements: value.lst[i].orderItem.supplements,
                        food: value.lst[i].orderItem.food,
                        other: value.lst[i].orderItem.other,
                        quantity: 3,
                      ));
                    }
                    print(item);
                    final result = await orderItemService.addOrderItem(item);
                    print(result);
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  child: Text(
                    'تأكيد الطلب',
                    textAlign: TextAlign.center,
                  ),
                  // style: ElevatedButton.styleFrom(
                  //   shape: StadiumBorder(),
                  //   primary: ColorMv,
                  // ),
                ),
              ),
              Container(
                height: screenSize.height,
                width: double.infinity,
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  child: ListView.builder(
                    itemCount: value.lst.length ?? 0,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        direction: DismissDirection.horizontal,
                        background: Container(
                          color: Colors.red,
                        ),
                        onDismissed: (direction) {},
                        child: GestureDetector(
                          child: CartItem(
                            screenSize: screenSize,
                            qte: value.lst[index].orderItem.quantity.toString(),
                            title: value.lst[index].foodTitle,
                            price: value.lst[index].foodPrice,
                            points: value.lst[index].foodPoints,
                            supplements: value.lst[index].orderItem.supplements,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem(
      {Key key,
      @required this.screenSize,
      this.title,
      this.points,
      this.price,
      this.qte,
      this.supplements,
      this.del})
      : super(key: key);

  final Size screenSize;
  final String qte, title, price, points;
  final Function del;
  final List<String> supplements;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
      child: Container(
        child: Dismissible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.remove_circle_outline_sharp,
                                size: 40,
                                color: ColorMv,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Text(qte, style: TextStyle(fontSize: 25)),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Icon(
                                Icons.add_circle_outline,
                                size: 40,
                                color: ColorMv,
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xffE9DFDF),
                          //Border.all
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            "الثمن : ${price}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "عدد نقاط الوجبة : ${points} ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorBlue,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),

                      // Expanded(
                      //   flex: 2,
                      //   child: Image.asset(
                      //
                      //       'assets/images/sandwich.png',
                      //
                      //   ),
                      // ),
                      //DecorationImage
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      " :الاضافات",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: ColorBlue,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Wrap(
                    children: List.generate(supplements.length, (index) {
                      return Text(
                        supplements[index].toString() + ' , ',
                        style: TextStyle(
                          //fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: KBlue,
                        ),
                      );
                    }),
                  ),
                ],
              ),

              //height: MediaQuery.of(context).size.height * 0.25,

              decoration: BoxDecoration(
                color: Color(0xffF6F6F6), //Border.all
                borderRadius: BorderRadius.circular(15),
              ), //BoxDecoration
            ),
          ),
          background: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            color: ColorMv,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.delete_outlined,
                    size: 50,
                    color: Colors.white,
                  )),
            ),
          ),
          key: ValueKey("my"),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {},
          confirmDismiss: (direction) {},
        ),
      ),
    );
  }
}
