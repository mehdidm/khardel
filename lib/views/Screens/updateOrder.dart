import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:group_button/group_button.dart';
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/CartItem.dart';
import 'package:khardel/models/food.dart';
import 'package:khardel/models/orderItem.dart';
import 'package:khardel/models/supplement.dart';
import 'package:khardel/services/cartModelView.dart';
import 'package:khardel/services/food.services.dart';
import 'package:khardel/services/orderItem.services.dart';
import 'package:khardel/services/supplement.services.dart';
import 'package:khardel/views/shared/Appbar.dart';
import 'package:khardel/views/shared/constant.dart';
import 'package:khardel/views/widgets/ItemSup.dart';
import 'package:khardel/views/widgets/supplementsWidget.dart';

import '../../Constant.dart';

class UpdateOrder extends StatefulWidget {
  final String id;

  UpdateOrder({this.id});

  @override
  _UpdateOrderState createState() => _UpdateOrderState();
}

class _UpdateOrderState extends State<UpdateOrder> {
  FoodsServices get foodService => GetIt.I<FoodsServices>();
  SupplementServices get categoryService => GetIt.I<SupplementServices>();
  OrderItemServices get orderItemService => GetIt.I<OrderItemServices>();
  final List<String> listSupplement = [];
  final List<String> listSupplementID = [];
  final List<String> selectedSupplementID = [];
  APIResponse<List<Supplement>> _supplementResponse;
  final List<OrderItem> listOrderItems = [];
  bool _isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  Food food = Food();
  String errorMessage;
  Color color = Colorbg;

  bool get isEditing => widget.id != null;
  int points = 0;
  var category;

  @override
  void initState() {
    _getFoodItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/sandwich.png",
                  scale: 0.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  // height: MediaQuery.of(context).size.height*0.65,
                  decoration: BoxDecoration(
                    color: Color(0xffF1f1f1),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(
                            //   Icons.remove_circle_outline_sharp,
                            //   size: 30,
                            //   color: ColorMv,
                            // ),
                            // SizedBox(
                            //   width: x * 0.02,
                            // ),
                            Text('نقاط'+points.toString() ,
                                style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold)),
                            // SizedBox(
                            //   width: x * 0.02,
                            // ),
                            // Icon(
                            //   Icons.add_circle_outline,
                            //   size: 30,
                            //   color: ColorMv,
                            // )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(food.price+"شيكل",
                                  style: TextStyle(
                                      fontSize: 25, color: ColorGold,fontWeight: FontWeight.bold)),
                              Text(food.title,
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: ColorMv))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(food.description,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            child: Text(
                              "الإضافات",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorMv,
                                  fontSize: 30),
                            ),
                          ),
                        ),

                        // _buildListCategoriesWidgets(),
                        Align(
                          child: Column(
                            children: [
                              SuppWidget(
                                listSelected: listSupplement,
                                label: 'اضافة مكونات رئيسية',
                                list: [
                                  "دجاج مسحب",
                                  " نقانق",
                                  "شرائح روست بيف ",
                                  "شرائح روست حبش ",
                                  "سمك سالمون مدخن",
                                  "سمك تونا",
                                  "شرائح جبنة صفراء",
                                  "شرائح جبنة بيضاء",
                                  "ماكدوس ",
                                  "لبنة"
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SuppWidget(
                                listSelected: listSupplement,

                                label: 'اضافات خضار',
                                list: [
                                  "بندورة ",
                                  "مخلل خيار مالح",
                                  "مخلل خيار حلو",
                                  "خس",
                                  "زيتون اخضر",
                                  "زيتون اسود",
                                  "بصل",
                                  "ملفوف احمر",
                                  "ملفوف ابيض ",
                                  "فلفل حار",
                                  " فطر",
                                  "ذرة حلوة"
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SuppWidget(
                                listSelected: listSupplement,

                                label: 'اضافات اجبان',
                                list: [
                                  "شرائح جبنة بيضاء",
                                  "شرائح جبنة صفراء",
                                  'جبنة سائل'
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SuppWidget(
                                listSelected: listSupplement,
                                label: 'اضافات صلصة (صوص)',
                                list: [
                                  "صوص خردل الخاص",
                                  "كاتشاب",
                                  " مايونز",
                                  "خردل عادي",
                                  "شطة"
                                ],
                              ),
                            ],
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 20),
                            child: Text(
                              "الملاحظات",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ColorMv,
                                  fontSize: 30),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15),
                          child: TextField(
                            controller: otherController,
                            autofocus: false,
                            style: TextStyle(
                              fontSize: 16.0,),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                              const EdgeInsets.symmetric(vertical: 40.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(25.7),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: GetBuilder<AddToCartVM>(
                            init: AddToCartVM(),
                            builder: (value) => ElevatedButton(
                              onPressed: () {
                                value.add(CartItem(
                                  orderItem: OrderItem(
                                    userId: '60f89ad57ceda214d885fdb7',
                                    supplements: listSupplement,
                                    food: food.id,
                                    other: otherController.text,
                                    quantity: 3,
                                  ),
                                  foodPoints: food.points,
                                  foodPrice: food.price,
                                  foodTitle: food.title,

                                ));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.thumb_up_alt_outlined,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 20,),
                                        Expanded(
                                            child:Text('تم الطلب بنجاح')
                                        )
                                      ],
                                    ),

                                  ),
                                );
                              },
                              child: Text(
                                'أطلب',
                                textAlign: TextAlign.center,
                              ),
                              style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: ColorMv,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getFoodItem() {
    if (isEditing) {
      setState(() {
        _isLoading = true;
      });
      foodService.getFood(widget.id.toString()).then((response) {
        setState(() {
          _isLoading = false;
        });

        if (response.error) {
          errorMessage = response.errorMessage ?? 'An error occurred';
        }
        food = response.data;
        print(food);
        titleController.text = food.title;
        descriptionController.text = food.description;
        priceController.text = food.price;
        points = int.parse(food.points);
        category = food.category;
      });
    }
  }

  _buildListCategoriesWidgets() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.07,
        //width: MediaQuery.of(context).size.width*0.2,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            GroupButton(
              spacing: 5,
              buttonHeight: 50,
              isRadio: true,
              direction: Axis.horizontal,
              onSelected: (index, isSelected) {
                print(
                    '$index button is ${isSelected ? 'selected' : 'unselected'}');
                category = listSupplement[index];
              },
              buttons: listSupplement,
              // selectedButtons: [0, 1], /// [List<int>] after 2.2.1 version
              selectedTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: KMauve,
              ),
              unselectedTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: KBlue,
              ),
              selectedColor: Color(0xffeadffd),
              unselectedColor: Color(0xffededed),
              //selectedBorderColor: KMauve,
              //unselectedBorderColor: Colors.grey[500],
              borderRadius: BorderRadius.circular(30.0),
            ),
          ],
        ));
    /*  return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // Let the ListView know how many items it needs to build.
        itemCount: listSupplement.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {

          return  ItemSup(
            title: listSupplement[index],
            image: "assets/images/cheese.png",
          );
        },
      ),
    );*/
  }

  _fetchSupplements() async {
    setState(() {
      _isLoading = true;
    });

    _supplementResponse = await categoryService.getAllSupplements();
    _buildListSupplements();
    setState(() {
      _isLoading = false;
    });
  }

  _buildListSupplements() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _supplementResponse.data.length; i++) {
      listSupplement.add(_supplementResponse.data[i].title);
      //listSupplementID.add(_supplementResponse.data[i].id.toString());
    }
    print(listSupplement);
    print(listSupplementID);
    setState(() {
      _isLoading = false;
    });
  }

  _addItem() async {
    // setState(() {
    //   _isLoading = true;
    // });
    // final item=OrderItem(
    //  userId: '60f89ad57ceda214d885fdb7',
    //     supplements: listSupplement,
    //   food: food.id,
    //   other:otherController.text ,
    //   quantity: 3,
    // );
    // print(listSupplement);
    // final result = await orderItemService.addOrderItem(item);
    // print(result);
    // setState(() {
    //   _isLoading = false;
    // });
  }
}
