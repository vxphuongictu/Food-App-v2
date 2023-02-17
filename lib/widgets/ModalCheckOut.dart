import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/screens/address/AddressSetup.dart';
import 'package:food_e/screens/address/MyAddress.dart';
import 'package:food_e/screens/checkout/OrderConfirm.dart';
import 'package:food_e/screens/checkout/OrderFailed.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_e/functions/card/replaceCardNumber.dart';
import 'package:food_e/functions/payment/payment_stripe.dart';
import 'package:provider/provider.dart';
import 'package:food_e/core/_config.dart' as cnf;


class ModalCheckOut extends StatefulWidget
{

  late String ? totalCost;
  CardFieldInputDetails ? _card;
  ModalCheckOut({super.key, this.totalCost});

  @override
  State<ModalCheckOut> createState() {
    return _ModalCheckout();
  }
}


class _ModalCheckout extends State<ModalCheckOut>
{

  late List<dynamic> fetchDelivery;
  String currentLocationName = "";
  String ? currentCardNumber;

  /*
   - define order info. You need create a model or get it in end point in your productions
   - Because my enpoint did not support this info so I define it in below to test
   */
  late String email = "Vxphuongictu998@gmail.com";
  late String phone = "0877946666";
  late String ? postCode = "2500000";
  late String city = "Thai Nguyen";

  /* functions */
  void fetchDataPayment() {
    DatabaseManager().getDefaultAddress().then((value){
      if (value != null) {
        setState(() {
          this.currentLocationName = "${value[0]['addressLineOne']}, ${value[0]['country']}";
        });
      }
    });

    DatabaseManager().fetchCard().then((value){
      if (value != null) {
        setState(() {
          this.currentCardNumber = "${value[0]['cardNumber']}";
        });
      }
    });
  }
  /* end functions */


  @override
  void initState() {
    super.initState();
    fetchDataPayment(); // get payment data
  }

  @override
  Widget build(BuildContext context) {
    return checkOut();
  }

  Widget checkOut()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: (value.darkmode == true) ? cnf.darkModeColorbg.toColor() : Colors.white,
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 30.0, left: 25.0, right: 25.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(
                        text: "Checkout",
                        fontSize: 24.0,
                        color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: (value.darkmode == true) ? cnf.colorWhite.toColor() : cnf.colorBlack.toColor(),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    (this.fetchDelivery != null && this.fetchDelivery.isNotEmpty) ? Navigator.push(context, MaterialPageRoute(builder: (context) => MyAddress())).then((_)=>setState(() {})) : Navigator.push(context, MaterialPageRoute(builder: (context) =>AddressSetup())).then((_) => setState(() {}));
                  },
                  child: this.lineItem(label: "Delivery", value: (this.currentLocationName != null) ? this.currentLocationName : "Select Method"),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SizedBox();
                            // return Payment(bankCallback: this.paymentCallBack);
                          },
                        )
                    );
                  },
                  child: this.lineItem(label: "Payment", value: (this.currentCardNumber != null) ? MyText(text: carNumber("${this.currentCardNumber}")) : Image.asset('assets/images/card.png'), valueIsImage: true),
                ),
                GestureDetector(
                  onTap: () {
                    print("Promo Code");
                  },
                  child: this.lineItem(label: "Promo Code", value: "Pick discount"),
                ),
                this.lineItem(label: "Total Cost", value: "\$${(this.widget.totalCost)}"),
                this.readTerms(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: GestureDetector(
                    onTap: () {
                      EasyLoading.show(status: "Waiting...");
                      if (this.email != "" && this.city != "" && this.postCode != "") {
                        handlePayPress(
                          email: this.email,
                          city: this.city,
                          postCode: this.postCode.toString(),
                          phone: '0877946666',
                          country: 'VN',
                          total_price: double.parse(this.widget.totalCost!),
                        ).then((value) async {
                          if (value == true) {
                            EasyLoading.dismiss();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirm()));
                            await DatabaseManager().clearCart();
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderFailed()));
                          }
                        });

                      } else {
                        EasyLoading.showError("You need to add payment method before order!");
                      }
                    },
                    child: LargeButton(
                      label: "Place Order",
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget readTerms()
  {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Text.rich(
          TextSpan(
              text: "By placing an order you agree to our ",
              style: const TextStyle(
                color: Color.fromRGBO(124, 124, 124, 1),
                fontSize: 14.0,
                fontFamily: "Gilroy-Medium",
              ),
              children: [
                TextSpan(
                    text: "Terms ",
                    style: const TextStyle(
                      color: Color.fromRGBO(83, 177, 117, 1),
                      fontSize: 14.0,
                      fontFamily: "Gilroy-Medium",
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      print('Terms');
                    }
                ),
                const TextSpan(
                  text: " and",
                  style: TextStyle(
                    color: Color.fromRGBO(124, 124, 124, 1),
                    fontSize: 14.0,
                    fontFamily: "Gilroy-Medium",
                  ),
                ),
                TextSpan(
                    text: " Conditions",
                    style: const TextStyle(
                      color: Color.fromRGBO(83, 177, 117, 1),
                      fontSize: 14.0,
                      fontFamily: "Gilroy-Medium",
                    ),
                    recognizer: TapGestureRecognizer()..onTap = (){
                      print("Conditions");
                    }
                ),
              ]
          ),
        )
    );
  }

  lineItem({String ? label, dynamic value, bool valueIsImage = false}) {
    return Consumer<ThemeModeProvider>(
      builder: (context, _value, child) {
        return Container(
            margin: const EdgeInsets.only(top: 20.0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: '#E2E2E2'.toColor()
                    )
                )
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: [
                  MyText(
                    text: "${label}",
                    fontWeight: FontWeight.w900,
                    color: (_value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          (valueIsImage) ? value : Container(
                            width: 180.0,
                            alignment: AlignmentDirectional.centerEnd,
                            child: MyText(
                              text: "${value}",
                              maxLines: 1,
                              textOverflow: true,
                              color: (_value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 30.0,
                            color: (_value.darkmode == true) ? cnf.colorWhite.toColor() : cnf.colorBlack.toColor(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }
}