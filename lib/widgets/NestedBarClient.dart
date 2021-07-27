import 'package:flutter/material.dart';
import 'package:khardel/Constant.dart';
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
              width: MediaQuery.of(context).size.width*0.3,
              child: Tab(
                child: Text(
                  'معلومات شخصية',
                  style: TextStyle(
                      fontSize: 20
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width*0.3,
              child: Tab(
                child: Text(
                  'تاريخ',
                  style: TextStyle(
                    fontSize: 20
                  ),
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
               /* decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.blueAccent,
                ),*/
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
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.orangeAccent,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}


/*
import 'package:flutter/material.dart';
import 'package:khardel/Constant.dart';

class NestedTabBar extends StatefulWidget {
  const NestedTabBar({Key key}) : super(key: key);

  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar> {

  int _currentIndex = 0;

  List<Widget> _tabList = [
    Container(
      color: Colors.teal,
    ),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.purple,
    )

  ];

  TabController _nestedTabController;

  @override
  void initState() {
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _nestedTabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          unselectedLabelStyle: TextStyle(fontSize: 20),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: KBlue, width: 1),
          ),
          controller: _nestedTabController,
          indicatorColor: KBlue,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          isScrollable: true,
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
          tabs: <Widget>[
            Tab(
              text: "Détails",
            ),
            Tab(
              text: "Historique réservation",
            ),
          ],
        ),
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: TabBarView(
              controller: _nestedTabController,
              children: [
                Container(
                  color: Colors.purple,
                ),
                Container(
                  color: Colors.teal,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
*/
