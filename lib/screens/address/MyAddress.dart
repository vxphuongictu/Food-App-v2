import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/screens/address/AddressSetup.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:provider/provider.dart';


class MyAddress extends StatefulWidget
{
  @override
  State<MyAddress> createState() => _MyAddress();
}

class _MyAddress extends State<MyAddress> {

  List<dynamic> address = [];

  @override
  void initState() {
    super.initState();
    DatabaseManager().fetchAddress().then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          this.address = value;
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
                label: "MY ADDRESSES",
                color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
              ),
              (this.address.isNotEmpty) ? this.screen() : Expanded(
                child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: cnf.wcDistanceButtonAndText),
                    child: Image.asset("assets/images/location.png")
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
                child: LargeButton(
                  onTap: () =>
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            AddressSetup(title: "Add new address"),
                      )),
                  label: "ADD NEW ADDRESS",
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget screen()
  {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: this.address.length,
      itemBuilder:(context, index) {
        return this.detailItem(
          id: this.address[index]['id'],
          title: this.address[index]['type'],
          address: this.address[index]['addressLineOne'],
          isDefault: this.address[index]['isDefault']
        );
      },
    );
  }

  Widget detailItem({int? id, String ? title, String ? address, int isDefault = 0})
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: Slidable(
            key: UniqueKey(),
            endActionPane: ActionPane(
              dismissible: DismissiblePane(
                onDismissed: () {
                  EasyLoading.show(status: "Deleting ...");
                  DatabaseManager().removeAddress(id: id).then((value){
                    EasyLoading.showSuccess("Done");
                    setState(() {
                      DatabaseManager().fetchAddress().then((value) {
                        this.address = value;
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
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: MyTitle(
                        label: title!,
                        color: (isDefault == 1) ? cnf.colorOrange : cnf.colorBlack,
                        fontSize: 12.0,
                      ),
                    ),
                    MyText(
                      text: address!,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      align: TextAlign.start,
                      color: (isDefault == 1) ? (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack : (value.darkmode == true) ? cnf.colorGray : cnf.colorBlack,
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}