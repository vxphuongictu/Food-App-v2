import 'package:food_e/core/_config.dart' as cnf;
import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';


class LargeButton extends StatelessWidget
{

  String ? label;
  String ? fontFamily;
  FontWeight ? fontWeight;
  double ? fontSize;
  String ? textColor;
  double ? buttonHeight;
  double ? buttonRadius;
  bool buttonShadow;
  String buttonColor;
  String borderColor;
  double borderWidth;
  GestureTapCallback? onTap;

  LargeButton({
    super.key,
    this.label = "Default Lable",
    this.fontFamily = "Bebas Neue",
    this.fontWeight = FontWeight.w400,
    this.fontSize = cnf.large_button_font_size,
    this.textColor = cnf.colorWhite,
    this.buttonHeight = cnf.large_button_h,
    this.buttonRadius = cnf.large_button_radius,
    this.buttonShadow = true,
    this.buttonColor = cnf.colorMainStreamBlue,
    this.onTap=null,
    this.borderColor="",
    this.borderWidth=2.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        width: double.infinity,
        height: this.buttonHeight,
        decoration: BoxDecoration(
            color: this.buttonColor.toColor(),
            border: (this.borderColor != "") ? Border.all(
              color: this.borderColor.toColor(),
              width: this.borderWidth
            ) : null,
            borderRadius: BorderRadius.all(
              Radius.circular(this.buttonRadius!),
            ),
            boxShadow: [
              (this.buttonShadow == true) ? BoxShadow(
                color: cnf.colorLightGrayShadow.toColor(),
                blurRadius: 3,
                offset: const Offset(0, 4),
              ) : const BoxShadow(),
            ]
        ),
        child: (this.label != null) ? Center(
          child: Text(
            "${this.label}",
            style: TextStyle(
              fontFamily: this.fontFamily,
              fontSize: this.fontSize,
              color: this.textColor!.toColor(),
              fontWeight: this.fontWeight,
            ),
          ),
        ) : const SizedBox(),
      ),
    );
  }
}