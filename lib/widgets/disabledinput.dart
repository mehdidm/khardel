import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constant.dart';


class DisabledInputBox extends StatefulWidget {
  bool enabled;
  String inputHint;
  Color color;
  TextEditingController controller;
  bool validate;

  DisabledInputBox({this.inputHint, this.color,this.controller,this.enabled,this.validate});
  @override
  _DisabledInputBoxState createState() => _DisabledInputBoxState();
}

class _DisabledInputBoxState extends State<DisabledInputBox> {
  bool isSubmitted = false;
  final checkBoxIcon = 'assets/checkbox.svg';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 15),
          child: Container(
            margin: EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width*0.75,
            height: MediaQuery.of(context).size.height*0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: widget.color , width: 1),
            ),
            child: TextFormField(
              textAlign: TextAlign.end,
              enabled: widget.enabled,
              controller: widget.controller,
              style: TextStyle(
                  fontSize: 20,
                  color: KBlue,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                errorText: widget.validate ? 'Value Can\'t Be Empty' : null,
                enabled: true,
                hintText: widget.inputHint,
                hintStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[350],
                    fontWeight: FontWeight.w600),
                contentPadding:
                EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                focusColor: widget.color,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: widget.color),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey[350],
                  ),
                ),
              ),
            ),
          ),
        ),
        //
      ],
    );
  }
}
