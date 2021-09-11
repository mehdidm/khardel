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
import 'package:khardel/views/widgets/ItemCategorie.dart';
import 'package:khardel/views/widgets/ItemMenu.dart';
import 'package:khardel/views/widgets/SearchField.dart';

class Home extends StatefulWidget {
  final bool isUser;

  Home({this.isUser});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CategoriesServices get categoryService => GetIt.I<CategoriesServices>();

  FoodsServices get foodService => GetIt.I<FoodsServices>();
  bool _isLoading = false;
  final List<String> listCategory = [];
  List<Food> listFood = [];
  final List listCategoryId = [];
  APIResponse<List<Category>> _categoryResponse;
  APIResponse<List<Food>> _foodResponse;

  @override
  void initState() {
    _fetchCategories();
    _fetchFoods();
    listFood = [];
    super.initState();
  }

  int currentIndex = 0;
  void _runFilter(String enteredKeyword) {
    List<Food> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _foodResponse.data;
    } else {
      results = _foodResponse.data
          .where((food) => food.title.toLowerCase()
          .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      listFood = results;
    });
  }
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
                    _runFilter(value);
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
             // _buildListCategoriesWidgets(),
              GroupButton(
                spacing: 15,
                isRadio: true,
                groupingType: GroupingType.wrap,
                direction: Axis.horizontal,
                onSelected: (index, isSelected) {
                  List<String> selected=[];
                  selected.add(listCategoryId[index]);
                  _findFoodUsingCategory(listFood, selected);
                },
                buttons: listCategory,
              //  selectedButtons: [0, 1], /// [List<int>] after 2.2.1 version
                selectedTextStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white,
                ),
                unselectedTextStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.black
                ),
                selectedColor: KMauve,
                unselectedColor: Color(0xffededed),
                borderRadius: BorderRadius.circular(5.0),
                selectedShadow: <BoxShadow>[BoxShadow(color: Colors.transparent)],
                unselectedShadow: <BoxShadow>[BoxShadow(color: Colors.transparent)],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  "الإختيارات",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              myWidget(context, listFood),
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

  // _buildListCategoriesWidgets() {
  //   return Container(
  //     height: MediaQuery.of(context).size.height * 0.15,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       // Let the ListView know how many items it needs to build.
  //       itemCount: listCategory.length,
  //       // Provide a builder function. This is where the magic happens.
  //       // Convert each item into a widget based on the type of item it is.
  //       itemBuilder: (context, index) {
  //         Color color = Colorbg ;
  //         bool isSelected=false;
  //         return GestureDetector(
  //
  //           onTap: (){
  //             setState(() {
  //               isSelected=! isSelected;
  //               isSelected ? color = ColorMv : color = Colorbg  ;
  //
  //              isSelected?_findFoodUsingCategory(listFood, listCategoryId[index]):print(listCategory[index]);
  //             });
  //
  //           },
  //           child: ItemCat(
  //             title: listCategory[index],
  //             image: 'assets/images/burger.png',
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  _fetchCategories() async {
    setState(() {
      _isLoading = true;
    });

    _categoryResponse = await categoryService.getAllCategories();
    _buildListCategories(_categoryResponse);
    setState(() {
      _isLoading = false;
    });
  }

  _buildListCategories(var _categoryResponse) {
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
            role: widget.isUser,
            available: listFood[index].available,
          );
        },
      ),
    );
  }

  Widget myWidget(BuildContext context, List<Food> listFood) {
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
                role: widget.isUser,
                available: listFood[index].available,
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
    _buildListFoods(_foodResponse);
    setState(() {
      _isLoading = false;
    });
  }

  _buildListFoods(var _foodResponse) {
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

  _findFoodUsingCategory(
      List<Food> restaurants,List<String> category) {
    List<Food> results = [];
    if (category.length == null) {
      setState(() {
        results = _foodResponse.data;
      });
    } else {
      for (var i = 0; i < restaurants.length; i++) {
        restaurants=_foodResponse.data;
        for (var j = 0; j < category.length; j++) {
          if (restaurants[i].category['_id'] == category[j]) {
            results.add(restaurants[i]);
            print('Using loop: ${restaurants[i].title}');

          }
        }
      }
      setState(() {
        listFood = results;
      });
      print(results.length);
    }
  }
}
