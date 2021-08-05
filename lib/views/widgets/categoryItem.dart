import 'package:flutter/material.dart';
import 'package:khardel/Constant.dart';


class FilterChipWidget extends StatefulWidget {
  final String chipName;
  final List<String> chips;
  FilterChipWidget({Key key, this.chipName, this.chips}) : super(key: key);

  @override
  _FilterChipWidgetState createState() => _FilterChipWidgetState();
}
class _FilterChipWidgetState extends State<FilterChipWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(widget.chipName),
      ),
      labelStyle:
      TextStyle(color: KMauve, fontSize: 16.0, fontWeight: FontWeight.bold),
      selected: _isSelected,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      backgroundColor: Color(0xffededed),
      onSelected: (isSelected) {
        setState(() {
          _isSelected = isSelected;
          return widget.chipName;
        });
      },
      selectedColor: Color(0xffeadffd),
    );
  }
}