/*
 * Opacity button like Favourite in box item or leading, action in product details
 */


import 'package:flutter/material.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';


class ButtonContainer extends StatefulWidget
{

  Widget ? childWidget;
  double width;
  double height;
  GestureTapCallback ? onTap;

  ButtonContainer({
    this.childWidget,
    this.width = 30.0,
    this.height = 30.0,
    this.onTap,
  });

  @override
  State<ButtonContainer> createState() {
    return _ButtonContainer();
  }
}


class _ButtonContainer extends State<ButtonContainer>
{
  @override
  Widget build(BuildContext context) {
    return this.buttonContainer();
  }

  Widget buttonContainer()
  {
    return GestureDetector(
      onTap: this.widget.onTap,
      child: Stack(
        children: [
          Opacity(
            opacity: .2,
            child: Container(
              height: this.widget.height,
              width: this.widget.width,
              decoration: BoxDecoration(
                  color: cnf.colorLightBlack.toColor(),
                  borderRadius: const BorderRadius.all(
                      Radius.circular(5.0)
                  )
              ),
            ),
          ),
          Container(
              height: this.widget.height,
              width: this.widget.height,
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(left: 2.0, top: 1.0),
                child: this.widget.childWidget,
              )
          )
        ],
      ),
    );
  }
}