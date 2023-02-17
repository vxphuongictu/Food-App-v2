import 'package:flutter/material.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';

class OrderItem extends StatefulWidget
{

  Image thumbnails;
  String title;
  int totalItem;
  double totalPrice;
  String orderDate;
  String ? backgroundColor;
  GestureTapCallback? onTap;
  GestureLongPressCallback? onLongPress;

  OrderItem({
    required this.thumbnails,
    required this.title,
    required this.totalItem,
    required this.totalPrice,
    required this.orderDate,
    this.onTap,
    this.onLongPress,
    this.backgroundColor
  });

  @override
  State<OrderItem> createState() {
    return _OrderItem();
  }
}

class _OrderItem extends State<OrderItem>
{

  final double margin_item = 10.0; // margin of item with box
  final double radius = 10.0; // border radius
  double _box_scale = 0.0; // default thumbnails scale is 0.0

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        setState(() {
          this._box_scale = 1.0;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _orderItem();
  }

  Widget _orderItem()
  {
    return AnimatedScale(
      duration: const Duration(milliseconds: 200),
      scale: this._box_scale,
      child: GestureDetector(
        onTap: this.widget.onTap,
        onLongPress: this.widget.onLongPress,
        child: Container(
          width: double.infinity,
          height: 100.0,
          decoration: BoxDecoration(
              color: (this.widget.backgroundColor != null) ? this.widget.backgroundColor!.toColor() : cnf.colorWhite.toColor(),
              borderRadius: BorderRadius.all(Radius.circular(this.radius)),
              boxShadow: [
                BoxShadow(
                  color: (cnf.colorLightBlack.toColor()).withOpacity(.2),
                  blurRadius: 10.0,
                )
              ]
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: this.margin_item),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(this.radius))
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(this.margin_item),
                    child: this.widget.thumbnails,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: this.margin_item),
                      child: MyText(
                        text: this.widget.title,
                        color: cnf.colorBlack,
                        fontWeight: FontWeight.w900,
                        align: TextAlign.start,
                        fontSize: 18.0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: this.margin_item),
                      child: MyText(
                        text: "${this.widget.totalItem} Items",
                        color: cnf.colorGray,
                        fontWeight: FontWeight.w900,
                        align: TextAlign.start,
                        fontSize: 15.0,
                      ),
                    )
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: this.margin_item, right: this.margin_item),
                    child: MyTitle(
                      label: "\$ ${this.widget.totalPrice}",
                      color: cnf.colorOrange,
                      align: TextAlign.right,
                      fontSize: 18.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: this.margin_item, right: this.margin_item),
                    child: MyText(
                      text: "${this.widget.orderDate}",
                      align: TextAlign.right,
                      fontWeight: FontWeight.w900,
                      color: cnf.colorLightGrayShadow,
                      fontSize: 15.0,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}