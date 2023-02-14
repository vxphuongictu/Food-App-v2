import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/screens/Payment/MyPaymentMethod.dart';
import 'package:food_e/screens/address/MyAddress.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/ModalCheckOut.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/core/DatabaseManager.dart';


class CheckOut extends StatefulWidget
{
  String totalPrice;
  CheckOut({required this.totalPrice});

  @override
  State<CheckOut> createState() => _CheckOut();
}

class _CheckOut extends State<CheckOut> {

  // define list address
  String ? _typeAddress;
  String ? _cardNumber;

  @override
  void initState() {
    super.initState();
    DatabaseManager().fetchAddress().then((value){
      if (value != null && value.isNotEmpty) {
        setState(() {
          this._typeAddress = value[0]['type'].toString();
        });
      }
    });

    DatabaseManager().fetchCard().then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          this._cardNumber = value[0]['cardNumber'].toString().substring(0, value[0]['cardNumber'].length - 4) + "XXXX";
        });
      }
    });
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
          Icons.arrow_back_ios,
          color: cnf.colorBlack.toColor(),
          size: cnf.leadingIconSize,
        ),
      ),
      margin: true,
      body: addressSetupScreen(context),
    );
  }

  Widget addressSetupScreen(context)
  {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: MyTitle(
              label: "CHECKOUT",
            ),
          ),
          this.checkout()
        ],
      ),
    );
  }

  Widget checkout()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTitle(
          label: "PRICE",
          fontSize: 12.0,
          fontFamily: "Bebas Neue",
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0, top: 10.0),
          child: MyTitle(
            label: "\$ ${this.widget.totalPrice}",
            fontFamily: "Bebas Neue",
            fontSize: 36.0,
            color: cnf.colorMainStreamBlue,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: details(title: "DELIVER TO", lable: "${this._typeAddress}", onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyAddress()
              )
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: details(title: "PAYMENT METHOD", lable: "${this._cardNumber}", onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyPaymentMethod()
              )
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
          child: LargeButton(
            onTap: () => showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              enableDrag: true,
              isDismissible: true,
              isScrollControlled: true,
              builder: (context){
                return ModalCheckOut(totalCost: this.widget.totalPrice);
              },
            ),
            label: "CONFIRM ORDER",
          ),
        )
      ],
    );
  }

  Widget details({String ? title, String ? lable, GestureTapCallback ? onTap})
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: MyTitle(
            label: title!,
            fontSize: 12.0,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: MyText(
                text: lable!,
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                align: TextAlign.left,
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: MyText(
                text: "Change",
                color: cnf.colorOrange,
                fontSize: 14.0,
              ),
            )
          ],
        )
      ],
    );
  }
}