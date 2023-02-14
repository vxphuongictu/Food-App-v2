import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/models/Payment.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyInput.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/functions/card/card.dart';


class PaymentSetup extends StatefulWidget
{

  String ? title;

  PaymentSetup({this.title});

  @override
  State<PaymentSetup> createState() => _PaymentSetupState();
}

class _PaymentSetupState extends State<PaymentSetup> {

  final listCountry = const [DropdownMenuItem(child: Text("Country"),value: "Country")];

  double _scale = 0.0;

  // text controller
  final controller = CardFormEditController();
  CardFieldInputDetails ? card;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () => setState((){
      this._scale = 0.8;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appbar: true,
      appbarBgColor: cnf.colorWhite,
      extendBodyBehindAppBar: false,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.close,
          color: cnf.colorBlack.toColor(),
        ),
      ),
      margin: true,
      body: paymentSetupScreen(context),
    );
  }

  Widget paymentSetupScreen(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTitle(
            label: (this.widget.title == null) ? "PAYMENT SETUP" : this.widget.title!,
          ),
          AnimatedScale(
            scale: this._scale,
            duration: const Duration(milliseconds: 500),
            child: Image.asset("assets/images/payment.png"),
          ),
          this.formInput(context)
        ],
      ),
    );
  }

  Widget formInput(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CardFormField(
          controller: controller,
          enablePostalCode: true,
          autofocus: true,
          onCardChanged: (details) {
            setState(() {
              this.card = details;
            });
          },
          dangerouslyGetFullCardDetails: true,
          dangerouslyUpdateFullCardDetails: true,
        ),
        Padding(
          padding: const EdgeInsets.only(top: cnf.wcDistanceButtonAndText),
          child: LargeButton(
            onTap: () => handleAddCard(
              context: context,
              title: this.widget.title,
              cvv: this.card?.cvc,
              expiryDate: "${this.card?.expiryMonth}/${this.card?.expiryYear}",
              cardNumber: this.card?.number,
            ),
            label: "Add card",
          ),
        ),
        if (this.widget.title == null) Padding(
          padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop, bottom: cnf.wcLogoMarginTop),
          child: LargeButton(
            label: "Skip for now",
            buttonColor: cnf.colorWhite,
            textColor: cnf.colorGray,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            fontSize: 14.0,
            buttonShadow: false,
            borderColor: cnf.colorWhite,
            borderWidth: 0.0,
            buttonHeight: 20.0,
          ),
        )
      ],
    );
  }
}