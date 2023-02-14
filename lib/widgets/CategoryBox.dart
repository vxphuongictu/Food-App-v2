import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/core/_config.dart' as cnf;


class CategoryBox extends StatefulWidget
{

  String activeColor;
  String textColor;
  String boxColor;
  String label;
  final ValueChanged<bool>? onSelected;

  CategoryBox({
    this.activeColor = cnf.colorMainStreamBlue,
    this.boxColor = cnf.colorGrayInputBg,
    this.textColor = cnf.colorBlack,
    required this.label,
    required this.onSelected
  });

  @override
  State<CategoryBox> createState() {
    return _CategoryBox();
  }
}


class _CategoryBox extends State<CategoryBox>
{
  @override
  Widget build(BuildContext context) {
    return FilterChip(
      onSelected: this.widget.onSelected,
      selected: false,
      label: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
        child: MyText(
          text: this.widget.label,
          color: this.widget.textColor,
          fontFamily: "Poppins",
          fontSize: 14.0,
          fontWeight: FontWeight.w900,
        ),
      ),
      disabledColor: this.widget.boxColor.toColor(),
      selectedColor: this.widget.activeColor.toColor(),
    );
  }

}