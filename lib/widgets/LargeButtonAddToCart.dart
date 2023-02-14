import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/models/Cart.dart';


class LargeButtonAddToCart extends StatefulWidget
{

  String ? label;
  String ? fontFamily;
  FontWeight ? fontWeight;
  double ? fontSize;
  String ? textColor;
  double ? buttonHeight;
  double ? buttonRadius;
  String buttonColor;
  Cart ? cartItem;

  LargeButtonAddToCart({
    super.key,
    this.label = "ADD TO BASKET",
    this.fontFamily = "Bebas Neue",
    this.fontWeight = FontWeight.w400,
    this.fontSize = cnf.large_button_font_size,
    this.textColor = cnf.colorWhite,
    this.buttonHeight = cnf.large_button_h,
    this.buttonRadius = cnf.large_button_radius,
    this.buttonColor = cnf.colorMainStreamBlue,
    this.cartItem
  });

  @override
  State<LargeButtonAddToCart> createState() => _LargeButtonAddToCartState();
}

class _LargeButtonAddToCartState extends State<LargeButtonAddToCart> {

  // add cart animation
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: this.widget.buttonHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(this.widget.buttonRadius!),
          ),
      ),
      child: (this.widget.label != null) ? Center(
        child: AddToCartButton(
          trolley: const Icon(Icons.shopping_cart_outlined),
          text: MyText(
            text: this.widget.label!,
            fontFamily: this.widget.fontFamily!,
            fontWeight: this.widget.fontWeight!,
            fontSize: this.widget.fontSize!,
            color: this.widget.textColor!,
          ),
          check: const SizedBox(
            width: 48,
            height: 48,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 24,
            ),
          ),
          borderRadius: BorderRadius.circular(24),
          backgroundColor: this.widget.buttonColor.toColor(),
          onPressed: (id) {
            if (id == AddToCartButtonStateId.idle) {
              //handle logic when pressed on idle state button.
              setState(() {
                stateId = AddToCartButtonStateId.loading;
                Future.delayed(const Duration(seconds: 3), () {
                  setState(() {
                    stateId = AddToCartButtonStateId.done;
                  });
                  Future.delayed(const Duration(milliseconds: 500), () async {
                    setState(() {
                      stateId = AddToCartButtonStateId.idle;
                    });
                    await DatabaseManager().insertCart(cart: this.widget.cartItem!);
                    Navigator.of(context, rootNavigator: true).pushNamed("basket/");
                  });
                });
              });
            }
          },
          stateId: stateId,
        ),
      ) : const SizedBox(),
    );
  }
}