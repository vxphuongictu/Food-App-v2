/*
 * Item on basket and favourite
 */

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:provider/provider.dart';

class CartItem extends StatefulWidget
{
  Image ? thumbnails;
  String ? title;
  String ? titleColor;
  String ? price;
  String ? quantity;
  VoidCallback? onDelete;
  VoidCallback? basketOnClick;
  GestureTapCallback? onChangeQuantity;
  int? screentype;

  CartItem({
    this.thumbnails,
    this.title="Egg Salad",
    this.price="\$ 10.00",
    this.quantity="1",
    this.onDelete,
    this.basketOnClick,
    this.onChangeQuantity,
    this.screentype = 0,
    this.titleColor
  });

  @override
  State<CartItem> createState() {
    return _CartItem();
  }
}


class _CartItem extends State<CartItem>
{
  @override
  Widget build(BuildContext context) {
    return _cartBody();
  }

  Widget _cartBody()
  {
    return Consumer<ThemeModeProvider> (
      builder: (context, value, child) {
        return Container(
          margin: const EdgeInsets.only(bottom: 35.0),
          height: 80.0,
          child: Row(
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0)
                    )
                ),
                margin: const EdgeInsets.only(right: 20.0),
                child: this.widget.thumbnails,
              ),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width / 2),
                    child: MyTitle(
                      label: "${this.widget.title}",
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      fontSize: 14.0,
                      align: TextAlign.start,
                      maxLines: 2,
                      color: (this.widget.titleColor != null) ? this.widget.titleColor! : (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                    ),
                  ),
                  MyText(
                    text: "${this.widget.price}",
                    fontFamily: "Bebas Neue",
                    fontSize: 24.0,
                    fontWeight: FontWeight.w400,
                    color: cnf.colorMainStreamBlue,
                  )
                ],
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Stack(
                      children: [
                        Center(child: Container(
                          decoration: BoxDecoration(
                              color: cnf.colorLightRed.toColor(),
                              borderRadius: const BorderRadius.all(Radius.circular(5.0))
                          ),
                        )),
                        Center(child: IconButton(
                            onPressed: this.widget.onDelete,
                            padding: const EdgeInsets.only(left: 1.5),
                            alignment: Alignment.center,
                            icon: FaIcon(FontAwesomeIcons.trashCan, size: 13.0, color: cnf.colorWhite.toColor())
                        )),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  (this.widget.screentype == 0) ? GestureDetector(
                    onTap: this.widget.onChangeQuantity,
                    child: Row(
                      children: [
                        MyText(
                          text: "${this.widget.quantity}",
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: FaIcon(FontAwesomeIcons.angleDown, size: 8.0, color: cnf.colorBlack.toColor()),
                        )
                      ],
                    ),
                  ) :
                  SizedBox(
                    width: 22.0,
                    height: 22.0,
                    child: Stack(
                      children: [
                        Center(child: Container(
                          decoration: BoxDecoration(
                              color: cnf.colorMainStreamBlue.toColor(),
                              borderRadius: const BorderRadius.all(Radius.circular(5.0))
                          ),
                        )),
                        Center(child: IconButton(
                            onPressed: this.widget.basketOnClick,
                            padding: const EdgeInsets.only(left: 1.5),
                            alignment: Alignment.center,
                            icon: FaIcon(FontAwesomeIcons.shoppingBasket, size: 13.0, color: cnf.colorWhite.toColor())
                        )),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

}

