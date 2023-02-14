import 'package:food_e/core/_config.dart' as cnf;
import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/widgets/MyText.dart';


class MyDropDown extends StatefulWidget
{

  String title;
  double width;
  List<DropdownMenuItem<String>> list;
  String? valueSelect;
  String bgColor;
  double radius;
  Function ? valueCallback;
  String titleColor;
  double fontSize;
  FontWeight titleFontWeight;
  String titleFontFamily;
  TextAlign titleAlign;
  FontStyle titleFontStyle;
  IconData dropDownIcon;
  String dropDownIconColor;


  MyDropDown({
    this.title = '',
    this.width = double.infinity,
    required this.list,
    this.valueSelect,
    this.bgColor = cnf.colorGrayInputBg,
    this.radius = cnf.input_radius,
    this.valueCallback,
    this.fontSize = cnf.input_text_fontSize,
    this.titleColor=cnf.colorMainStreamBlue,
    this.titleFontWeight=FontWeight.w400,
    this.titleFontFamily="Bebas Neue",
    this.titleAlign = TextAlign.left,
    this.titleFontStyle = FontStyle.normal,
    this.dropDownIcon=Icons.arrow_drop_down_rounded,
    this.dropDownIconColor=cnf.colorMainStreamBlue
  });

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown>
{

  @override
  Widget build(BuildContext context) {
    return myDropDown();
  }

  Widget myDropDown()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (this.widget.title != "") Container(
          margin: const EdgeInsets.only(left: cnf.input_padding_left_text, bottom: 10.0),
          child: MyText(
            text: "${this.widget.title}",
            fontSize: this.widget.fontSize,
            color: this.widget.titleColor,
            fontWeight: this.widget.titleFontWeight,
            fontFamily: this.widget.titleFontFamily,
            align: this.widget.titleAlign,
            fontStyle: this.widget.titleFontStyle,
          ),
        ),
        SizedBox(
            width: this.widget.width,
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: cnf.input_padding_left_text, right: cnf.input_padding_left_text),
                  filled: true,
                  fillColor: this.widget.bgColor.toColor(),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(this.widget.radius)
                      ),
                      borderSide: const BorderSide(
                          width: 0,
                          color: Colors.transparent
                      )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                        Radius.circular(this.widget.radius)
                    ),
                    borderSide: const BorderSide(
                        width: 0,
                        color: Colors.transparent
                    ),
                  )
              ),
              items: this.widget.list,
              onChanged: (String? newValue) {
                if (this.widget.valueCallback != null) this.widget.valueCallback!(newValue);
                setState(() {
                  this.widget.valueSelect = newValue!;
                });
              },
              icon: Icon(this.widget.dropDownIcon),
              iconEnabledColor: this.widget.dropDownIconColor.toColor(),
              value: (this.widget.valueSelect != null) ? this.widget.valueSelect : this.widget.list.first.value!,
            )
        )
      ],
    );
  }
}