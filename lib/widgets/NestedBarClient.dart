import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:khardel/Constant.dart';
import 'package:khardel/models/user.dart';
import 'package:khardel/services/user.services.dart';
import 'package:khardel/views/authentification/SignIn.dart';
import 'package:khardel/widgets/CardWidget.dart';
import 'package:khardel/widgets/disabledinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NestedTabBar extends StatefulWidget {
  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  TabController _nestedTabController;
  TextEditingController _controller;
  UserServices get userService => GetIt.I<UserServices>();
  bool _isLoading = false;
  TextEditingController UserNameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  //TextEditingController passwordController = TextEditingController();
  //TextEditingController phoneController = TextEditingController();
  // bool get isEditing => widget.userId != null;
  String errorMessage;
  var user;
 // User userData;
  int Id;
  bool _validate = false;

  @override
  void initState() {
    //_getUserInfo();
    setState(() {
      _isLoading = true;
    });
    _getUserInfo();
    // NameController.text=userData.username;

    //mailController.text=userData.email;
    super.initState();
    _nestedTabController = new TabController(length: 2, vsync: this);
  }

  void _getUserInfo() async {
    SharedPreferences localStorage1 = await SharedPreferences.getInstance();
    var username = localStorage1.getString('username');
    var email = localStorage1.getString('email');
    print(username);
    UserNameController.text=username.toString();
    mailController.text=email.toString();
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
                      inputHint: UserNameController.text,
                      controller: UserNameController,
                      validate: false,
                      color: KBlue,
                    ),
                    DisabledInputBox(
                      enabled: false,
                      inputHint: mailController.text,
                      controller: mailController,
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
                      onTap: ()async {
                        // logout from the server ...
                        // var res = await CallApi().getData('logout');
                        //var body = json.decode(res.body);
                        //if(body['success']){
                        SharedPreferences localStorage = await SharedPreferences
                            .getInstance();
                        localStorage.remove('token');
                        Navigator.push(
                            context, new MaterialPageRoute(builder: (context) =>
                            SignIn()));
                      },
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


  _getUserProfile(user) async {
    setState(() {
      _isLoading = true;
    });
    await userService.getUserProfile(user.toString()).then((response) {
      if (response.error) {
        errorMessage = response.errorMessage ?? 'An error occurred';
      }
      UserNameController.text = response.data.username;
      mailController.text = response.data.email;
      print(response.data.username);
      print(response.data.email);
      print(response.data.id);
      // _titleController.text = floor.nom;
      // _contentController.text = note.noteContent;
    });
    setState(() {
      _isLoading = false;
    });
  }

}