import 'package:food_e/core/_config.dart' as cnf;
import 'package:flutter/material.dart';
import 'package:food_e/widgets/MyText.dart';


class MyTitle extends StatelessWidget
{

  String label;
  String fontFamily;
  FontWeight fontWeight;
  String color;
  FontStyle fontStyle;
  double fontSize;
  int maxLines;
  bool ? textOverflow;
  TextAlign align;

  MyTitle({
    this.label = "Default title",
    this.fontFamily = "Bebas Neue",
    this.fontWeight = FontWeight.w400,
    this.color = cnf.colorBlack,
    this.fontStyle = FontStyle.normal,
    this.fontSize = cnf.title_font_size,
    this.maxLines = 0,
    this.textOverflow,
    this.align = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return _Title();
  }

  Widget _Title(){
    return MyText(
      align: this.align,
      textOverflow: (this.textOverflow == true) ? true : null,
      maxLines: this.maxLines,
      text: this.label,
      fontFamily: this.fontFamily,
      fontWeight: this.fontWeight,
      color: this.color,
      fontStyle: this.fontStyle,
      fontSize: this.fontSize,
    );
  }
}