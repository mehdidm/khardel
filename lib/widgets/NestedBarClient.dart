import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khardel/Constant.dart';
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/food.dart';
import 'package:khardel/models/order.dart';
import 'package:khardel/models/orderItem.dart';
import 'package:khardel/models/supplement.dart';
import 'package:khardel/models/user.dart';
import 'package:khardel/services/food.services.dart';
import 'package:khardel/services/order.services.dart';
import 'package:khardel/services/orderItem.services.dart';
import 'package:khardel/services/supplement.services.dart';
import 'package:khardel/services/user.services.dart';
import 'package:khardel/views/Screens/ListOrder.dart';
import 'package:khardel/views/authentification/SignIn.dart';
import 'package:khardel/widgets/CardWidget.dart';
import 'package:khardel/widgets/GetOrderCard.dart';
import 'package:khardel/widgets/disabledinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class NestedTabBar extends StatefulWidget {
  final String userId;
  NestedTabBar({this.userId});
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  TextEditingController _controller;
  UserServices get userService => GetIt.I<UserServices>();
  bool _isLoading = false;
  TextEditingController UserNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  OrderServices get orderService => GetIt.I<OrderServices>();
  OrderItemServices get orderItemService => GetIt.I<OrderItemServices>();
  FoodsServices get foodService => GetIt.I<FoodsServices>();
  SupplementServices get supplementService => GetIt.I<SupplementServices>();
  List<Order> listOrders = [];
  final List<OrderItem> listOrderItems = [];
  final List<Supplement> listSupplements = [];
  final Food food = Food();
  APIResponse<List<Order>> _orderResponse;

  //TextEditingController passwordController = TextEditingController();
  //TextEditingController phoneController = TextEditingController();
  // bool get isEditing => widget.userId != null;
  String errorMessage;
  var user;
 // User userData;
  int Id;
  bool _validate = false;

  @override
  void initState() {
    //_getUserInfo();
    setState(() {
      _isLoading = true;
    });
    _getUserInfo();
    // NameController.text=userData.username;
    _fetchCategories();
    //mailController.text=userData.email;
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
  }

  void _getUserInfo() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    var username = localStorage1.getString('username');
    var email = localStorage1.getString('email');
    print(username);
    UserNameController.text=username.toString();
    mailController.text=email.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _nestedTabController,
          indicatorColor: KBlue,
          labelColor: KBlue,
          unselectedLabelColor: Colors.black54,
          isScrollable: true,
          tabs: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Tab(
                child: TextButton(
                  onPressed: (){
                    _fetchCategories();
                  },
                  child: Text(
                    'تاريخ',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Tab(
                child: Text(
                  'معلومات شخصية',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: screenHeight * 0.70,
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 20),
                // child: Column(
                //   children: [
                //     CardOrder(),
                //   ],
                // ),
                child: _buildListOrderItems(),
              ),
              Container(
                child: Column(
                  children: [
                    DisabledInputBox(
                      enabled: false,
                      inputHint: UserNameController.text,
                      controller: UserNameController,
                      validate: false,
                      color: KBlue,
                    ),
                    DisabledInputBox(
                      enabled: false,
                      inputHint: mailController.text,
                      controller: mailController,
                      validate: false,
                      color: KBlue,
                    ),
                    DisabledInputBox(
                      enabled: false,
                      inputHint: '12 345 678',
                      controller: _controller,
                      validate: false,
                      color: KBlue,
                    ),
                    SizedBox(height: 15,),
                    GestureDetector(
                      onTap: ()async {
                        // logout from the server ...
                        // var res = await CallApi().getData('logout');
                        //var body = json.decode(res.body);
                        //if(body['success']){
                        SharedPreferences localStorage = await SharedPreferences
                            .getInstance();
                        localStorage.remove('token');
                        Navigator.push(
                            context, new MaterialPageRoute(builder: (context) =>
                            SignIn()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.5,
                        height: MediaQuery.of(context).size.height*0.075,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: KMauve
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.white,
                              size: 30,
                            ),
                            Text(
                              'خروج',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30
                              ),
                            )
                          ],
                        ),
                      ),

                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }


  _getUserProfile(user) async {
    setState(() {
      _isLoading = true;
    });
    await userService.getUserProfile(user.toString()).then((response) {
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      UserNameController.text = response.data.username;
      mailController.text = response.data.email;
      print(response.data.username);
      print(response.data.email);
      print(response.data.id);
      // _titleController.text = floor.nom;
      // _contentController.text = note.noteContent;
    });
    setState(() {
      _isLoading = false;
    });
  }
  _fetchCategories() async {
    setState(() {
      _isLoading = true;
    });

  //  _orderResponse = await orderService.getUserOrders(widget.userId);
    listOrders=await orderService.getUserOrders(widget.userId);
    print(listOrders);
    //_buildListCategories();
    setState(() {
      _isLoading = false;
    });


  }

  _buildListCategories() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _orderResponse.data.length; i++) {
      print(_orderResponse.data[i].orderItems);
      listOrders.add(_orderResponse.data[i]);
    }
    print(listOrders.length);
    _buildListOrderItems();
    setState(() {
      _isLoading = false;
    });
  }

  _buildListOrderItems() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < listOrders.length; i++) {
      final List orderItems = listOrders[i].orderItems;
      print(orderItems);
      for (int j = 0; j < orderItems.length; j++) {
        print(orderItems[j]['_id']);
        orderItemService.getOrderItem(orderItems[j]['_id']).then((value) {
          OrderItem orderItem = value.data;
          //print(orderItem['']);
          listOrderItems.add(orderItem);

        });
        return _buildOrderListWidgets(listOrders);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  _buildOrderListWidgets(
      List<Order> listOrders) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: ListView.builder(
        //scrollDirection: Axis.vertical,
        // Let the ListView know how many items it needs to build.
        itemCount: listOrders.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Column(
                            children: [

                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  children: [
                                    Details(
                                      title2: listOrders[index].code,
                                      title1: 'رمز الطلبية',
                                    ),
                                    // Details(
                                    //   title2: 'بطاطا و دجيز',
                                    //   title1: 'الاضافات',
                                    // ),
                                    Details(
                                      title2: listOrders[index].deliveryDate.toString(),
                                      title1: 'تاريخ التوصيل',
                                    ),
                                    Details(
                                      title2: listOrders[index].createdAt.toString(),
                                      title1: 'تاريخ الطلب',
                                    ),
                                    Details(
                                      title2: listOrders[index].userId['username'],
                                      title1: 'اسم العميل',
                                    ),
                                    Details(
                                      title2: '52474786',
                                      title1: 'رقم هاتف العميل',
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.025,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          padding:
                                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: listOrders[index].done?KGreen:Colors.black54,
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Text(
                                            'جاهز',
                                            style: TextStyle(color: Colors.white, fontSize: 20),
                                          ),
                                        ),
                                        Text(
                                          listOrders[index].delivery?'مع خدمات توصيل':'',
                                          style: TextStyle(color: KGreen, fontSize: 22),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      color: KGrey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    listOrders[index].delivery
                                        ? 'مع خدمات توصيل'
                                        : '',
                                    style: TextStyle(color: KGreen, fontSize: 20),
                                  ),
                                  GestureDetector(
                                    onTap: ()async{
                                      print(listOrders[index].id);
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      final order=Order(
                                          userId: listOrders[index].userId,
                                          delivery: listOrders[index].delivery,
                                          orderItems: listOrders[index].orderItems,
                                          createdAt: listOrders[index].createdAt,
                                          deliveryDate: listOrders[index].deliveryDate,
                                          id: listOrders[index].id,
                                          code: listOrders[index].code,
                                          done: true
                                      );

                                      final result = await orderService.updateOrder(listOrders[index].id.toString(), order);
                                      print(result);
                                      setState(() {
                                        listOrders[index].done=true;

                                        _isLoading = false;
                                      });
                                      //
                                      // final title = 'Done';
                                      // final text = result.error
                                      //     ? (result.errorMessage ?? 'An error occurred')
                                      //     : 'Your order was updated';
                                      //
                                      // showDialog(
                                      //     context: context,
                                      //     builder: (_) => AlertDialog(
                                      //       title: Text(title),
                                      //       content: Text(text),
                                      //       actions: <Widget>[
                                      //         FlatButton(
                                      //           child: Text('Ok'),
                                      //           onPressed: () {
                                      //             Navigator.of(context).pop();
                                      //           },
                                      //         )
                                      //       ],
                                      //     ));

                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(top: 15),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.5, vertical: 2.5),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: listOrders[index].done?KGreen:Colors.black54,
                                      ),
                                      child: Text(
                                        'جاهز',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: listOrders[index].code,
                                      style: TextStyle(
                                          color: KBlue.withOpacity(0.5),
                                          fontSize: 20)),
                                  TextSpan(
                                      text: ' :رمز الطلبية ',
                                      style:
                                      TextStyle(color: KBlue, fontSize: 20)),
                                ]),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.65,
                            child: ListView.builder(
                              //scrollDirection: Axis.vertical,
                              // Let the ListView know how many items it needs to build.
                              itemCount: listOrders[index].orderItems.length,
                              // Provide a builder function. This is where the magic happens.
                              // Convert each item into a widget based on the type of item it is.
                              itemBuilder: (context, j) {
                                List<String> supplements=[];
                                for(int i =0;i<listOrders[index].orderItems[j]['supplements'].length;i++){
                                  supplements.add(listOrders[index].orderItems[j]['supplements'][i]);                              }
                                return Column(
                                  children: [
                                    OrderItemWidget(
                                      Title1: supplements.toString(),
                                      Title2: listOrders[index].orderItems[j]['other'],
                                      Title3: listOrders[index].orderItems[j]['food']['title'],
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
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}