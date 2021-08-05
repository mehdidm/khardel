import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:group_button/group_button.dart';
import 'package:khardel/Constant.dart';
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/category.dart';
import 'package:khardel/models/food.dart';
import 'package:khardel/services/categories.services.dart';
import 'package:khardel/services/food.services.dart';
import 'package:khardel/views/shared/Appbar.dart';

import 'package:khardel/views/shared/constant.dart';

class ModifierMenu extends StatefulWidget {
  final String id;

  ModifierMenu({this.id});

  @override
  _ModifierMenuState createState() => _ModifierMenuState();
}

class _ModifierMenuState extends State<ModifierMenu> {
  FoodsServices get foodService => GetIt.I<FoodsServices>();

  CategoriesServices get categoryService => GetIt.I<CategoriesServices>();

  bool _isLoading = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Food food = Food();
  String errorMessage;

  bool get isEditing => widget.id != null;
  final List<String> listCategory = [];
  final List listCategoryId = [];
  int points = 0;
  var category;
  APIResponse<List<Category>> _categoryResponse;

  @override
  void initState() {
    _fetchCategories();
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("تعديل",
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 3),
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
                      Icon(
                        Icons.remove_circle_outline_sharp,
                        size: 30,
                        color: ColorBlue,
                      ),
                      SizedBox(
                        width: x * 0.02,
                      ),
                      Text(points.toString(),
                          style: TextStyle(fontSize: 25, color: ColorBlue)),
                      SizedBox(
                        width: x * 0.02,
                      ),
                      Icon(
                        Icons.add_circle_outline,
                        size: 30,
                        color: ColorBlue,
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _updateFoodItem();
                    },
                    child: Icon(Icons.check),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: ColorGreen,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      final deleteResult =
                          await foodService.deleteFood(widget.id.toString());
                    },
                    child: Icon(Icons.delete_outline),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ));
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

  _findSelectedCategory() {
    for (int i = 0; i < listCategory.length; i++) {
      if (listCategory[i] == category) {
        print(i);
        return i;
      }
    }
  }

  _buildListCategoryWidgets() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.07,
        //width: MediaQuery.of(context).size.width*0.2,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            GroupButton(
              spacing: 5,
              buttonHeight: 50,
              isRadio: false,
              direction: Axis.horizontal,
              onSelected: (index, isSelected) {
                print(
                    '$index button is ${isSelected ? 'selected' : 'unselected'}');
                //category = listCategoryId[index];
              },
              buttons: listCategory,
              selectedButtons: _findSelectedCategory(),

              /// [List<int>] after 2.2.1 version
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
  }

  _fetchCategories() async {
    setState(() {
      _isLoading = true;
    });

    _categoryResponse = await categoryService.getAllCategories();
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

  _updateFoodItem() async {
    setState(() {
      _isLoading = true;
    });
    final food = Food(
      title: titleController.text,
      //category: _categoryController.text,
      description: descriptionController.text,
      points: points.toString(),
      price: priceController.text,
      //createdAt: _startController.text,
    );
    final result = await foodService.updateFood(widget.id.toString(), food);

    setState(() {
      _isLoading = false;
    });

    final title = 'Done';
    final text = result.error
        ? (result.errorMessage ?? 'An error occurred')
        : 'Your event was updated';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Text(text),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }
}
