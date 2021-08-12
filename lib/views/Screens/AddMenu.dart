import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:group_button/group_button.dart';
import 'package:http/http.dart';
import 'package:khardel/Constant.dart';
import 'package:khardel/api/api.dart';
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/category.dart';
import 'package:khardel/models/food.dart';
import 'package:khardel/services/categories.services.dart';
import 'package:khardel/services/food.services.dart';
import 'package:khardel/views/shared/Appbar.dart';
import 'package:khardel/views/shared/constant.dart';
import 'package:khardel/views/widgets/categoryItem.dart';

class AddMenu extends StatefulWidget {
  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {

  CategoriesServices get categoryService => GetIt.I<CategoriesServices>();
  FoodsServices get foodService => GetIt.I<FoodsServices>();
 bool _isLoading = false;
  APIResponse<List<Category>> _categoryResponse;
  TextEditingController titleController=TextEditingController();
  TextEditingController priceController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  final List<String> listCategory = [];
  final List listCategoryId = [];
  int points =0;
  var category;
@override
  void initState() {
_fetchCategories();
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("أضف إلى القائمة",
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: ColorMv)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("إسم الوجبة",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorBlue)),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child: TextField(
                      controller: titleController,
                      autofocus: false,
                      style:
                          TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 20.0),
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("سعر الوجبة",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorBlue)),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child: TextField(
                      controller: priceController,
                      autofocus: false,
                      style:
                          TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 20.0),
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20 , horizontal: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("عدد نقاط الوجبة",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorBlue)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Icon(
                          Icons.remove_circle_outline_sharp,
                          size: 30,
                          color: ColorBlue,
                        ),
                        onTap: (){
                          setState(() {
                            points--;
                          });
                        },
                      ),
                      SizedBox(
                        width: x * 0.02,
                      ),
                      Text(points.toString(), style: TextStyle(fontSize: 25 ,color: ColorBlue)),
                      SizedBox(
                        width: x * 0.02,
                      ),
                      GestureDetector(
                        child: Icon(
                          Icons.add_circle_outline,
                          size: 30,
                          color: ColorBlue,
                        ),
                        onTap: (){
                          setState(() {
                            points++;
                          });

                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("صنف",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorBlue)),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  //   child: TextField(
                  //     autofocus: false,
                  //     style:
                  //         TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                  //     decoration: InputDecoration(
                  //       filled: true,
                  //       fillColor: Colors.white,
                  //       contentPadding:
                  //           const EdgeInsets.symmetric(vertical: 20.0),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.white),
                  //         borderRadius: BorderRadius.circular(25.7),
                  //       ),
                  //       enabledBorder: UnderlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.white),
                  //         borderRadius: BorderRadius.circular(25.7),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                   _buildListCategoryWidgets(),

                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("تفاصيل",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: ColorBlue)),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child: TextField(
                      controller: descriptionController,
                      autofocus: false,
                      style:
                          TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
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
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                 // makePostRequest();
                  _addItem();
                },
                child: Icon(Icons.check),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  primary: ColorGreen,
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  _buildListCategoryWidgets(){
    return Container(
      height: MediaQuery.of(context).size.height*0.07,
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
              category = listCategoryId[index];
            } ,
            buttons:listCategory,
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
            selectedColor:Color(0xffeadffd),
            unselectedColor:Color(0xffededed),
            //selectedBorderColor: KMauve,
            //unselectedBorderColor: Colors.grey[500],
            borderRadius: BorderRadius.circular(30.0),
          ),
        ],
      )
    );
  }

  _fetchCategories() async {
    setState(() {
      _isLoading = true;
    });

    _categoryResponse = await categoryService
        .getAllCategories();
    _buildListCategories();
    setState(() {
      _isLoading = false;
    });
  }

  _buildListCategories() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _categoryResponse.data.length; i++) {

        listCategory.add(_categoryResponse.data[i].name);
        listCategoryId.add(_categoryResponse.data[i].id);
    }
    print(listCategory);
    setState(() {
      _isLoading = false;
    });
  }
  _addItem() async{
    setState(() {
      _isLoading = true;
    });
    final item=Food(
        title:titleController.text,
        description:descriptionController.text ,
        price: priceController.text,
        category:category,
        points:points.toString(),
    available:true
    );
    final result = await foodService.addFood(item);
    setState(() {
      _isLoading = false;
    });
  }


}
