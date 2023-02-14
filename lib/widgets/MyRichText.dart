import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;

class MyRichText extends StatefulWidget
{

  String firstText;
  String firstTextColor;
  Function()? onTapFourText;
  String secondText;
  String secondTextColor;
  Function()? onTapSecondText;
  String thirdText;
  String thirdTextColor;
  String fourText;
  String fourTextColor;
  Function()? onTapThirdText;
  String fontfamily;
  FontWeight fontWeight;
  double fontSize;

  MyRichText({
    this.firstText = "",
    this.firstTextColor = cnf.colorWhite,
    this.secondText = "",
    this.secondTextColor = cnf.colorWhite,
    this.thirdText = "",
    this.thirdTextColor = cnf.colorWhite,
    this.fourText = "",
    this.fourTextColor = cnf.colorWhite,
    this.fontfamily = "Bebas Neue",
    this.fontWeight = FontWeight.w400,
    this.fontSize = 36.0,
    this.onTapFourText,
    this.onTapSecondText,
    this.onTapThirdText
  });

  @override
  State<MyRichText> createState() => _MyRichTextState();
}

class _MyRichTextState extends State<MyRichText> {
  @override
  Widget build(BuildContext context) {
    return _MyRichText();
  }

  Widget _MyRichText() {
    return Text.rich(
      TextSpan(
          text: "${this.widget.firstText}",
          style: TextStyle(
            color: this.widget.firstTextColor.toColor(),
            fontSize: this.widget.fontSize,
            fontFamily: this.widget.fontfamily,
          ),
          children: [
            if (this.widget.secondText != "") TextSpan(
                text: this.widget.secondText,
                style: TextStyle(
                  color: this.widget.secondTextColor.toColor(),
                  fontSize: this.widget.fontSize,
                  fontFamily: this.widget.fontfamily,
                ),
                recognizer: TapGestureRecognizer()..onTap = this.widget.onTapSecondText,
            ),
            if (this.widget.thirdText != "") TextSpan(
              text: "${this.widget.thirdText}",
              style: TextStyle(
                color: this.widget.thirdTextColor.toColor(),
                fontSize: this.widget.fontSize,
                fontFamily: this.widget.fontfamily,
              ),
                recognizer: TapGestureRecognizer()..onTap = this.widget.onTapThirdText,
            ),
            if (this.widget.fourText != "") TextSpan(
                text: "${this.widget.fourText}",
                style: TextStyle(
                  color: this.widget.fourTextColor.toColor(),
                  fontSize: this.widget.fontSize,
                  fontFamily: this.widget.fontfamily,
                ),
                recognizer: TapGestureRecognizer()..onTap = this.widget.onTapFourText,
            ),
          ]
      ),
    );
  }
}