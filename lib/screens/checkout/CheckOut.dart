import 'package:flutter/material.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/screens/Payment/MyPaymentMethod.dart';
import 'package:food_e/screens/Payment/PaymentSetup.dart';
import 'package:food_e/screens/address/AddressSetup.dart';
import 'package:food_e/screens/address/MyAddress.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/ModalCheckOut.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:provider/provider.dart';


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
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return BaseScreen(
          appbar: true,
          appbarBgColor: (value.darkmode == true) ? cnf.darkModeColorbg.toColor() : Colors.white,
          screenBgColor: cnf.colorWhite,
          extendBodyBehindAppBar: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: (value.darkmode == true) ? cnf.colorWhite.toColor() : cnf.colorBlack.toColor(),
              size: cnf.leadingIconSize,
            ),
          ),
          margin: true,
          body: addressSetupScreen(context),
        );
      },
    );
  }

  Widget addressSetupScreen(context)
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: MyTitle(
                  label: "CHECKOUT",
                  color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                ),
              ),
              this.checkout()
            ],
          ),
        );
      },
    );
  }

  Widget checkout()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyTitle(
              label: "PRICE",
              fontSize: 12.0,
              fontFamily: "Bebas Neue",
              color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
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
                onTap: () {
                  if (this._typeAddress == null) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddressSetup(title: "Add new addresss")));
                  } else if (this._cardNumber == null) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentSetup(title: "Add new payment")));
                  } else {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      enableDrag: true,
                      isDismissible: true,
                      isScrollControlled: true,
                      builder: (context) {
                        return ModalCheckOut(totalCost: this.widget.totalPrice);
                      },
                    );
                  }
                },
                label: "CONFIRM ORDER",
              ),
            )
          ],
        );
      },
    );
  }

  Widget details({String ? title, String ? lable, GestureTapCallback ? onTap})
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: MyTitle(
                label: title!,
                fontSize: 12.0,
                color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
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
                    color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
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
      },
    );
  }
}