import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khardel/api/api_Response.dart';
import 'package:khardel/models/category.dart';
import 'package:khardel/services/categories.services.dart';
import 'package:khardel/views/shared/Appbar.dart';
import 'package:khardel/views/shared/BottomBar.dart';
import 'package:khardel/views/shared/constant.dart';
import 'package:khardel/views/widgets/categoryItem.dart';

class AddMenu extends StatefulWidget {
  @override
  _AddMenuState createState() => _AddMenuState();
}

class _AddMenuState extends State<AddMenu> {

  CategoriesServices get categoryService => GetIt.I<CategoriesServices>();
 bool _isLoading = false;
  APIResponse<List<Category>> _categoryResponse;
  final List<String> listCategory = [];
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
      bottomNavigationBar: BottomBar(),
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
                      Icon(
                        Icons.remove_circle_outline_sharp,
                        size: 30,
                        color: ColorBlue,
                      ),
                      SizedBox(
                        width: x * 0.02,
                      ),
                      Text("5", style: TextStyle(fontSize: 25 ,color: ColorBlue)),
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
                  _fetchCategories();
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
      height: MediaQuery.of(context).size.height*0.1,
      //width: MediaQuery.of(context).size.width*0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // Let the ListView know how many items it needs to build.
        itemCount: _categoryResponse.data.length,
        // Provide a builder function. This is where the magic happens.
        // Convert each item into a widget based on the type of item it is.
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: FilterChipWidget(
              chipName: _categoryResponse.data[index].name,
            ),
          );
        },
      ),
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
      if (listCategory.contains(_categoryResponse.data[i].name)) {
        i++;
      } else {
        listCategory.add(_categoryResponse.data[i].name);
      }
    }
    print(listCategory);
    setState(() {
      _isLoading = false;
    });
  }
}
