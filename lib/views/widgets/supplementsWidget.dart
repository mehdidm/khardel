import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:khardel/Constant.dart';


class SuppWidget extends StatefulWidget {
  final List<String>list;
  final String label;
  final List<String> listSelected;
  SuppWidget({this.list,this.label,this.listSelected});
  @override
  _SuppWidgetState createState() => _SuppWidgetState();
}

class _SuppWidgetState extends State<SuppWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Padding(
        padding: const EdgeInsets.only(right:18.0),
        child: Column(
         // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(widget.label,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
            ),
        GroupButton(
        spacing: 15,
        isRadio: false,
        groupingType: GroupingType.wrap,
        crossGroupAlignment: CrossGroupAlignment.start,
        mainGroupAlignment: MainGroupAlignment.spaceAround,
        direction: Axis.horizontal,
        onSelected: (index, isSelected) {
          //List<String> selected=[];
          widget.listSelected.add(widget.list[index]);
          // _findFoodUsingCategory(listFood, selected);
        },
        buttons: widget.list,
        //  selectedButtons: [0, 1], /// [List<int>] after 2.2.1 version
        selectedTextStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: Colors.white,
        ),
        unselectedTextStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black45
        ),
        selectedColor: KMauve,
        unselectedColor: Color(0xffffffff),
        borderRadius: BorderRadius.circular(20.0),
        selectedShadow: <BoxShadow>[BoxShadow(color: Colors.transparent)],
        unselectedShadow: <BoxShadow>[BoxShadow(color: Colors.transparent)],
    ),
          ],
        ),
      )
    );
  }
}
