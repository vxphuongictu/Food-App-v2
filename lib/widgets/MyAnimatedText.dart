import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';


class MyAnimatedText extends StatefulWidget{

  List<AnimatedText> animatedTexts;
  double ? fontSize;
  String ? textColor;
  String ? fontFamily;
  FontWeight? fontWeight;

  MyAnimatedText({
    required this.animatedTexts,
    this.fontSize = 16.0,
    this.textColor = cnf.colorLightBlack,
    this.fontFamily = 'Poppins',
    this.fontWeight = FontWeight.w500,
  });

  @override
  State<MyAnimatedText> createState() {
    return _MyAnimatedText();
  }
}


class _MyAnimatedText extends State<MyAnimatedText>
{
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: this.widget.fontFamily,
        fontWeight: this.widget.fontWeight,
        fontSize: this.widget.fontSize,
        color: this.widget.textColor?.toColor(),
        fontStyle: FontStyle.normal,
      ),
      child: AnimatedTextKit(
        isRepeatingAnimation: false,
        animatedTexts: this.widget.animatedTexts
      ),
    );
  }

}