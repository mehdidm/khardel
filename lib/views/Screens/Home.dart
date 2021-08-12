import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/category.dart';
import 'package:khardel/models/food.dart';
import 'package:khardel/services/categories.services.dart';
import 'package:khardel/services/food.services.dart';
import 'package:khardel/views/shared/Appbar.dart';

import 'package:khardel/views/shared/constant.dart';

import 'package:khardel/views/widgets/ItemCategorie.dart';
import 'package:khardel/views/widgets/ItemMenu.dart';
import 'package:khardel/views/widgets/SearchField.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'Cart.dart';

class Home extends StatefulWidget {


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoriesServices get categoryService => GetIt.I<CategoriesServices>();

  FoodsServices get foodService => GetIt.I<FoodsServices>();
  bool _isLoading = false;
  final List<String> listCategory = [];
  final List<Food> listFood = [];
  final List listCategoryId = [];
  APIResponse<List<Category>> _categoryResponse;
  APIResponse<List<Food>> _foodResponse;

  @override
  void initState() {
    _fetchCategories();
    _fetchFoods();
    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                child: SearchBarWidget(
                  onchangeValue: (value) {
                    print(value);
                  },
                  onEditingComplete: () {
                    print('بحث');
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "الاعلانات",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 30),
                      ),

                      Image.asset('assets/images/burger.png'),
                      //DecorationImage
                    ],
                  ),
                  width: 400,
                  height: 120,
                  //BoxDecoration Widget
                  decoration: BoxDecoration(
                    color: Color(0xffF6F6F6), //Border.all
                    borderRadius: BorderRadius.circular(15),
                  ), //BoxDecoration
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: Text(
                  "القائمة",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              _buildListCategoriesWidgets(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  "الإختيارات",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              myWidget(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  _buildListCategoriesWidgets() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // Let the ListView know how many items it needs to build.
        itemCount: listCategory.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          return ItemCat(
            title: listCategory[index],
            image: 'assets/images/burger.png',
          );
        },
      ),
    );
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

  _buildListFoodsWidgets() {
    return Container(
      height: 1000,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        // Let the ListView know how many items it needs to build.
        itemCount: listFood.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          return ItemMenu(
            title: listFood[index].title,
            price: "${listFood[index].price} شيكل",
            image: "assets/images/sandwich.png",
          );
        },
      ),
    );
  }

  Widget myWidget(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Container(
        height: 1000,
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 20,
            ),
            itemCount: listFood.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemMenu(
                id: listFood[index].id,
                title: listFood[index].title,
                price: "${listFood[index].price} شيكل",
                image: "assets/images/sandwich.png",
              );
            }),
      ),
    );
  }

  _fetchFoods() async {
    setState(() {
      _isLoading = true;
    });

    _foodResponse = await foodService.getAllFood();
    _buildListFoods();
    setState(() {
      _isLoading = false;
    });
  }

  _buildListFoods() {
    setState(() {
      _isLoading = true;
    });

    for (int i = 0; i < _foodResponse.data.length; i++) {
      listFood.add(_foodResponse.data[i]);
      //listCategoryId.add(_categoryResponse.data[i].id);
    }
    print(listFood);
    setState(() {
      _isLoading = false;
    });
  }
}
