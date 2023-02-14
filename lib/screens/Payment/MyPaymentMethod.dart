import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/screens/Payment/PaymentSetup.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/core/DatabaseManager.dart';


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
    return BaseScreen(
      appbar: true,
      appbarBgColor: cnf.colorWhite,
      extendBodyBehindAppBar: false,
      scroll: false,
      disabledBodyHeight: true,
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
              label: "MY PAYMENT METHODS",
            ),
          ),
          this.screen(),
          Padding(
            padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
            child: LargeButton(
              label: "ADD NEW PAYMENT METHOD",
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PaymentSetup(title: "ADD NEW CARD")
                  )
              ),
            ),
          )
        ],
      ),
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
          titleColor: cnf.colorBlack,
          textColor: cnf.colorGray,
          textLeft: "${this._listCard[index]['cardNumber']}"
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
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyText(
                text: (textLeft != null) ? textLeft : '',
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
                align: TextAlign.start,
                color: textColor!,
              ),
              MyText(
                text: (textRight != null) ? textRight : '',
                fontWeight: FontWeight.w500,
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