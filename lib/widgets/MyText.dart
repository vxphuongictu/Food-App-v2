import 'package:food_e/core/_config.dart' as cnf;
import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';


class MyText extends StatelessWidget
{

  String text;
  double fontSize;
  String color;
  String fontFamily;
  FontWeight fontWeight;
  int maxLines;
  TextAlign align;
  FontStyle fontStyle;
  bool ? textOverflow;

  MyText({
    this.text = "Default text",
    this.fontSize = cnf.text_size,
    this.color = cnf.colorLightBlack,
    this.fontFamily = "Poppins",
    this.fontWeight = FontWeight.w500,
    this.maxLines = cnf.text_max_lines,
    this.align = TextAlign.center,
    this.fontStyle = FontStyle.normal,
    this.textOverflow
  });

  @override
  Widget build(BuildContext context) {
    return _MyText();
  }

  Widget _MyText()
  {
    return Text(
      "${this.text}",
      maxLines: (this.maxLines == 0) ? null : this.maxLines,
      textAlign: this.align,
      style: TextStyle(
        overflow: (this.textOverflow == true) ? TextOverflow.ellipsis : null,
        color: this.color.toColor(),
        fontSize: this.fontSize,
        fontFamily: this.fontFamily,
        fontWeight: this.fontWeight,
        fontStyle: this.fontStyle,
      ),
    );
  }
}
