import 'package:flutter/material.dart';
import 'package:khardel/Constant.dart';
import 'package:khardel/widgets/CardWidget.dart';
import 'package:khardel/widgets/disabledinput.dart';

class NestedTabBar extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _nestedTabController = new TabController(length: 2, vsync: this);
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
                child: Text(
                  'تاريخ',
                  style: TextStyle(fontSize: 20),
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
                child: Column(
                  children: [
                    CardOrder(),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    DisabledInputBox(
                      enabled: false,
                      inputHint: 'فلان الفلاني',
                      controller: _controller,
                      validate: false,
                      color: KBlue,
                    ),
                    DisabledInputBox(
                      enabled: false,
                      inputHint: 'foulen.fouleni@gmail.com',
                      controller: _controller,
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
                      onTap: () {},
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
}