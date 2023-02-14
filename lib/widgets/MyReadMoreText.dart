import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:readmore/readmore.dart';
import 'package:food_e/core/_config.dart' as cnf;

class MyReadMoreText extends StatefulWidget
{

  String text;
  int trimLines;
  String showMore;
  String showLess;
  double fontSize;
  String fontFamily;
  FontWeight fontWeight;
  String showColor;
  String textColor;


  MyReadMoreText({
    required this.text,
    this.trimLines = 2,
    this.showMore = 'Show more',
    this.showLess = 'Show less',
    this.fontSize = cnf.text_size,
    this.fontFamily = "Poppins",
    this.fontWeight = FontWeight.w500,
    this.showColor = cnf.colorBlack,
    this.textColor = cnf.colorBlack,
  });

  @override
  State<MyReadMoreText> createState() {
    return _MyReadMoreText();
  }
}


class _MyReadMoreText extends State<MyReadMoreText>
{
  @override
  Widget build(BuildContext context) {
    return _myReadMoreText();
  }
  
  
  Widget _myReadMoreText()
  {
    return ReadMoreText(
      "${this.widget.text}",
      trimLines: this.widget.trimLines,
      colorClickableText: Colors.pink,
      trimMode: TrimMode.Line,
      trimCollapsedText: '${this.widget.showMore}',
      trimExpandedText: '${this.widget.showLess}',
      moreStyle: TextStyle(
        fontSize: this.widget.fontSize,
        fontWeight: FontWeight.w900,
        fontFamily: this.widget.fontFamily,
        color: this.widget.showColor.toColor()
      ),
      lessStyle: TextStyle(
          fontSize: this.widget.fontSize,
          fontWeight: FontWeight.w900,
          fontFamily: this.widget.fontFamily,
          color: this.widget.showColor.toColor(),
      ),
      style: TextStyle(
        fontFamily: this.widget.fontFamily,
        color: this.widget.textColor.toColor(),
       fontWeight: this.widget.fontWeight
      ),
    );
  }
}