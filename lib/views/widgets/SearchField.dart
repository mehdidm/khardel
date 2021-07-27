import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onchangeValue;
  final VoidCallback onEditingComplete;

  const SearchBarWidget({this.onchangeValue, this.onEditingComplete, Key key})
      : super(key: key);

  @override
  SearchBarWidgetState createState() => SearchBarWidgetState();
}

class SearchBarWidgetState extends State<SearchBarWidget> {
  ///Edit controller
  TextEditingController _controller;

  ///Whether to display the delete button
  bool _hasDeleteIcon = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  Widget buildTextField() {
    //theme sets a partial theme
    return TextField(
      controller: _controller,
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
      maxLines: 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xffF6F6F6),
        //Input box decoration attribute
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
        //Set search picture
        prefixIcon: Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            )),
        prefixIconConstraints: BoxConstraints(
          //Set the left alignment of the search picture
          minWidth: 30,
          minHeight: 25,
        ),
        border: InputBorder.none,
        //Rimless
        hintText: 'بحث',
        hintStyle: new TextStyle(fontSize: (14), color: Colors.grey),
        //Set the clear button
        suffixIcon: Container(
          padding: EdgeInsetsDirectional.only(
            start: 2.0,
            end: _hasDeleteIcon ? 0.0 : 0,
          ),
          child: _hasDeleteIcon
              ? new InkWell(
                  onTap: (() {
                    setState(() {
                      /// Make sure to trigger the cancellation of the empty content in the first frame of the component build
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => _controller.clear());
                      _hasDeleteIcon = false;
                    });
                  }),
                  child: Icon(
                    Icons.cancel,
                    size: 18.0,
                    color: Colors.grey,
                  ),
                )
              : new Text(''),
        ),
      ),
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            _hasDeleteIcon = false;
          } else {
            _hasDeleteIcon = true;
          }
          widget.onchangeValue(_controller.text);
        });
      },
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(FocusNode());
        widget.onEditingComplete();
      },
      style: new TextStyle(fontSize: 14, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //Background and rounded corners
      decoration: new BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1.0), //frame
        color: Colors.black12,
        borderRadius: new BorderRadius.all(new Radius.circular(18)),
      ),
      alignment: Alignment.center,
      //height: BaseSize.dp(36),
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      child: buildTextField(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
