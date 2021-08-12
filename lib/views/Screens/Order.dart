import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/food.dart';
import 'package:khardel/models/orderItem.dart';
import 'package:khardel/models/supplement.dart';
import 'package:khardel/services/food.services.dart';
import 'package:khardel/services/orderItem.services.dart';
import 'package:khardel/services/supplement.services.dart';
import 'package:khardel/views/shared/Appbar.dart';
import 'package:khardel/views/shared/constant.dart';
import 'package:khardel/views/widgets/ItemSup.dart';

class Order extends StatefulWidget {
  final String id;

  Order({this.id});

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  FoodsServices get foodService => GetIt.I<FoodsServices>();
 SupplementServices get categoryService => GetIt.I<SupplementServices>();
 OrderItemServices get orderItemService => GetIt.I<OrderItemServices>();
  final List<String> listSupplement = [];
  final List<String> listSupplementID = [];
  final List<String> selectedSupplementID = [];
  APIResponse<List<Supplement>> _supplementResponse;

  bool _isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  Food food = Food();
  String errorMessage;
  Color color = Colorbg ;

  bool get isEditing => widget.id != null;
  int points = 0;
  var category;

  @override
  void initState() {
    _getFoodItem();
    _fetchSupplements();
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
                    padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 20),
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
                            Text(points.toString() + 'points',
                                style: TextStyle(fontSize: 25)),
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
                              Text("${food.price} شيكل",
                                  style: TextStyle(
                                      fontSize: 25, color: ColorGold)),
                              Text(food.title,
                                  style: TextStyle(
                                      fontSize: 20,
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
                        // SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       ItemSup(
                        //         image: "assets/images/cheese.png",
                        //       ),
                        //       ItemSup(
                        //         image: "assets/images/salade.png",
                        //       ),
                        //       ItemSup(
                        //         image: "assets/images/soda.png",
                        //       ),
                        //       ItemSup(
                        //         image: "assets/images/salade.png",
                        //       ),
                        //       ItemSup(
                        //         image: "assets/images/soda.png",
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        _buildListCategoriesWidgets(),
                        SizedBox(
                          height: 5,
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 15),
                          child: TextField(
                            controller: otherController,
                            autofocus: false,
                            style: TextStyle(
                                fontSize: 22.0, color: Color(0xFFbdc6cf)),
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
                          child: ElevatedButton(
                            onPressed: () {
                              _addItem();
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
    );
  }


  _fetchSupplements() async {
    setState(() {
      _isLoading = true;
    });

    _supplementResponse = await categoryService
        .getAllSupplements();
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

  _addItem() async{
    setState(() {
      _isLoading = true;
    });
    final item=OrderItem(
     userId: '60f89ad57ceda214d885fdb7',
        supplements: listSupplement,
      food: food.id,
      other:otherController.text ,
      quantity: 3,
    );
    print(listSupplement);
    final result = await orderItemService.addOrderItem(item);
    print(result);
    setState(() {
      _isLoading = false;
    });
  }
}
