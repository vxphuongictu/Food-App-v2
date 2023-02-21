import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/screens/Payment/PaymentSetup.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/functions/card/replaceCardNumber.dart';
import 'package:provider/provider.dart';


class MyPaymentMethod extends StatefulWidget
{
  @override
  State<MyPaymentMethod> createState() => _MyPaymentMethod();
}

class _MyPaymentMethod extends State<MyPaymentMethod> {

  List<dynamic> _listCard = [];

  @override
  void initState() {
    super.initState();
    DatabaseManager().fetchCard().then((value) {
      if (value != null) {
        setState(() {
          this._listCard = value;
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
          extendBodyBehindAppBar: false,
          scroll: true,
          disabledBodyHeight: true,
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
              MyTitle(
                label: "MY PAYMENT METHODS",
                color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
              ),
              (this._listCard.length > 0) ? this.screen() : Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * .5,
                margin: const EdgeInsets.only(bottom: cnf.wcDistanceButtonAndText),
                child: Image.asset("assets/images/no-payment.png"),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .1,
              ),
              LargeButton(
                label: "ADD NEW PAYMENT METHOD",
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PaymentSetup(title: "ADD NEW CARD")
                    )
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget screen()
  {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: this._listCard.length,
        itemBuilder: (context, index) => Slidable(
            key: UniqueKey(),
            endActionPane: ActionPane(
              dismissible: DismissiblePane(
                onDismissed: () {
                  EasyLoading.show(status: "Deleting ...");
                  DatabaseManager().removeItemInCard(id: this._listCard[index]['id']).then((value){
                    EasyLoading.showSuccess("Done");
                    setState(() {
                      DatabaseManager().fetchCard().then((value) {
                        this._listCard = value;
                      });
                    });
                  });
                },
              ),
              motion: const ScrollMotion(),
              children: const [
                SlidableAction(
                  onPressed: null,
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: this.detailItem(
                title: "CASH",
                titleColor:  (this._listCard[index]['isDefault'] == 1) ? cnf.colorOrange : cnf.colorGray,
                textColor: cnf.colorGray,
                textLeft: carNumber("${this._listCard[index]['cardNumber']}"),
                textRight: "${this._listCard[index]['expiryDate']}"
            )),
      );
  }

  Widget detailItem({String ? title, String ? titleColor, String ? textColor, String ? textLeft, String ? textRight})
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: MyTitle(
              label: title!,
              color: titleColor!,
              fontSize: 12.0,
              fontWeight: FontWeight.w900,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: (textLeft != null) ? textLeft : '',
                fontWeight: FontWeight.w900,
                fontSize: 14.0,
                align: TextAlign.start,
                color: textColor!,
              ),
              MyText(
                text: (textRight != null) ? textRight : '',
                fontWeight: FontWeight.w900,
                fontSize: 14.0,
                align: TextAlign.start,
                color: textColor,
              )
            ],
          )
        ],
      ),
    );
  }
}