/*
 * Item box in home screen (Recommended for you)
 */


import 'package:flutter/material.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';


class RestaurantBox extends StatefulWidget
{

  GestureTapCallback ? restaurantsCallBack;
  double boxWidth;
  double boxHeight;
  Widget ? childWidget;


  RestaurantBox({
    this.restaurantsCallBack,
    this.boxWidth=cnf.boxRestaurantsSize,
    this.boxHeight=cnf.boxRestaurantsSize,
    this.childWidget
  });

  @override
  State<RestaurantBox> createState() {
    return _RestaurantBox();
  }
}


class _RestaurantBox extends State<RestaurantBox>
{

  final double spaceBetween = 10.0;
  bool isFavourite = false;

  @override
  Widget build(BuildContext context) {
    return _itemBox();
  }


  Widget _itemBox()
  {
    return GestureDetector(
      onTap: () => this.widget.restaurantsCallBack,
      child: Container(
        width: this.widget.boxWidth,
        height: this.widget.boxHeight,
        decoration: BoxDecoration(
            color: cnf.colorWhite.toColor(),
            borderRadius: const BorderRadius.all(
                Radius.circular(cnf.boxItemMRadius)
            ),
            boxShadow: [
              BoxShadow(
                color: (cnf.colorLightBlack.toColor()).withOpacity(.1),
                blurRadius: 5.0,
              )
            ]
        ),
        child: this.widget.childWidget,
      ),
    );
  }
}