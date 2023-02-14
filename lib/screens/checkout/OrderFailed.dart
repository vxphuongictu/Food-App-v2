import 'package:flutter/material.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';


class OrderFailed extends StatefulWidget
{
  @override
  State<OrderFailed> createState() {
    return _OrderFailed();
  }
}

class _OrderFailed extends State<OrderFailed>
{
  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      scroll: false,
      screenBgColor: cnf.colorLightRed,
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
                label: "SOMETHING WENT WRONG!",
                color: cnf.colorWhite,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                child: Image.asset('assets/images/orderfailed.png'),
              ),
              MyText(
                text: "Something went wrong. We’ll look into the issue right away.",
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
            label: "TRY AGAIN",
            textColor: cnf.colorMainStreamBlue,
            buttonColor: cnf.colorWhite,
            buttonShadow: false,
          ),
        )
      ],
    );
  }
}