import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khardel/models/user.dart';
import 'package:khardel/views/Screens/AddMenu.dart';
import 'package:khardel/views/Screens/Cart.dart';
import 'package:khardel/views/Screens/Home.dart';
import 'package:khardel/views/get%20order/GetOrder.dart';
import 'package:khardel/views/shared/constant.dart';
import 'package:khardel/views/user/UserProfil.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Acceuil extends StatefulWidget {

  @override
  _AcceuilState createState() => _AcceuilState();
}

class _AcceuilState extends State<Acceuil> {


bool isUser= true;
   void _getUserRole() async{
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var roles = localStorage.getStringList('roles');
   print(roles);
   if(roles.contains('ROLE_ADMIN')){
     setState(() {
       isUser= false;

     });
   }
  }


  @override
  void initState() {
     _getUserRole();
    super.initState();
  }


List<Widget> _buildScreens() {
     if (isUser==true) {
     return [
     UserProfil(),
  Home(isUser: true,),
  Cart(),

  ];
     }else {
       return [
         Home(isUser: false,),
         AddMenu(),
         GetOrder(),

       ];
     }

}
List<PersistentBottomNavBarItem> _navBarsItems() {
     if(isUser==true){
       return [
         PersistentBottomNavBarItem(
           icon: Icon(CupertinoIcons.person),
           title: ("حسابي"),
           activeColorPrimary: ColorMv,
           inactiveColorPrimary: ColorMv,
         ),
         PersistentBottomNavBarItem(
           icon: Icon(CupertinoIcons.home),
           title: ("الإستقبال"),
           activeColorPrimary: ColorMv,
           inactiveColorPrimary: ColorMv,
         ),
         PersistentBottomNavBarItem(
           icon: Icon(CupertinoIcons.cart),
           title: ("طلاباتي"),
           activeColorPrimary: ColorMv,
           inactiveColorPrimary: ColorMv,
         ),
       ];
     }else{
       return [

         PersistentBottomNavBarItem(
           icon: Icon(CupertinoIcons.home),
           title: ("الإستقبال"),
           activeColorPrimary: ColorMv,
           inactiveColorPrimary: ColorMv,
         ),
         PersistentBottomNavBarItem(
           icon: Icon(CupertinoIcons.add_circled_solid),
           title: ("add menu"),
           activeColorPrimary: ColorMv,
           inactiveColorPrimary: ColorMv,
         ),
         PersistentBottomNavBarItem(
           icon: Icon(CupertinoIcons.circle_grid_3x3),
           title: ("طلبات"),
           activeColorPrimary: ColorMv,
           inactiveColorPrimary: ColorMv,
         ),
       ];
     }

}
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}
