import 'package:flutter/material.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';


class OrderConfirm extends StatefulWidget
{
  @override
  State<OrderConfirm> createState() {
    return _OrderConfirm();
  }
}

class _OrderConfirm extends State<OrderConfirm>
{
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      scroll: false,
      screenBgColor: cnf.colorGreen,
      extendBodyBehindAppBar: true,
      margin: true,
      body: _screen(),
    );
  }


  Widget _screen()
  {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyTitle(
                label: "ORDER CONFIRMED!",
                color: cnf.colorWhite,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                child: Image.asset('assets/images/orderconfirm.png'),
              ),
              MyText(
                text: "Hang on Tight! We’ve received your order and we’ll bring it to you ASAP!",
                align: TextAlign.center,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                color: cnf.colorWhite,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
          child: LargeButton(
            label: "TRACK MY ORDER",
            textColor: cnf.colorMainStreamBlue,
            buttonColor: cnf.colorWhite,
            buttonShadow: false,
          ),
        )
      ],
    );
  }
}