import 'package:flutter/material.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/models/Address.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyDropDown.dart';
import 'package:food_e/widgets/MyInput.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/functions/address/address.dart';
import 'package:food_e/requests/fetchCountries.dart';
import 'package:food_e/widgets/SwitchGroup.dart';
import 'package:food_e/widgets/TypeOfLocation.dart';
import 'package:provider/provider.dart';


class AddressSetup extends StatefulWidget
{

  String ? title;
  AddressSetup({this.title});

  @override
  State<AddressSetup> createState() => _AddressSetupState();

}

class _AddressSetupState extends State<AddressSetup> {

  final double _distanceOfInput = 30.0;
  final double heightItem   = 50.0;

  // define location type in settings
  bool officeSelected       = false;
  bool privateHouseSelected = true;
  bool partyPlace = false;

  // define set address
  bool setDefaultAddress    = true;
  bool setPickupAddress     = false;
  bool setShippingAddress   = false;

  // input controller address line 1
  TextEditingController _addressLineOne = TextEditingController();
  // input controller address line 2
  TextEditingController _addressLineTwo = TextEditingController();
  // input controller zipcode
  TextEditingController _zipCode = TextEditingController();
  // input controller city
  TextEditingController _city = TextEditingController();

  // define list of country
  String ? country;

  // define list countries data
  List<DropdownMenuItem<String>> _countryData = [
    const DropdownMenuItem(child: Text("Select your country"), value: "")
  ];

  // define address loader
  Address ? _myAddress;

  /* functions */
  void _setDefaultCallback(bool action)
  {
    setState(() {
      this.setDefaultAddress = action;
    });
  }

  void _setPickupCallback(bool action)
  {
    setState(() {
      this.setPickupAddress = action;
    });
  }

  void _setShippingCallback(bool action)
  {
    setState(() {
      this.setShippingAddress = action;
    });
  }

  void countryValue(String ? value) {
    setState(() {
      this.country = value;
    });
  }
  /* end functions */

  @override
  void initState() {
    fetchCountries().then((value) {
      for (var item in value) {
        this._countryData.add(DropdownMenuItem(child: MyText(text: "${item.common}"),value: "${item.common}"));
      }
    });
    if (this.widget.title == null) {
      DatabaseManager().fetchAddress().then((value) {
        print(value);
        setState(() {
          this._myAddress = value;
          this._addressLineOne.text = value.addressLineOne!;
          this._addressLineTwo.text = value.addressLineTwo!;
          this._zipCode.text = value.zipCode!;
          this._city.text = value.city!;
          this.country = value.country!;
        });
      });
    }
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
          scroll: true,
          disabledBodyHeight: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: (value.darkmode == true) ? cnf.colorWhite.toColor() : cnf.colorBlack.toColor(),
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
                label: (this.widget.title == null) ? "ADDRESS SETUP" : this.widget.title!,
                color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
              ),
              this.formInput(context)
            ],
          ),
        );
      },
    );
  }

  Widget formInput(BuildContext context)
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: this._distanceOfInput),
                  child: MyInput(
                    width: MediaQuery.of(context).size.width * 0.42,
                    textController: this._addressLineOne,
                    title: "ADDRESS LINE 1",
                    placeholder: "What is your address?",
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: this._distanceOfInput),
                  child: MyInput(
                    width: MediaQuery.of(context).size.width * 0.42,
                    textController: this._addressLineTwo,
                    title: "ADDRESS LINE 2",
                    placeholder: "What is your address?",
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: this._distanceOfInput),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyInput(
                    width: MediaQuery.of(context).size.width * 0.42,
                    textController: this._zipCode,
                    title: "ZIP CODE",
                    placeholder: "000 - 000",
                  ),
                  MyInput(
                    width: MediaQuery.of(context).size.width * 0.42,
                    textController: this._city,
                    title: "CITY",
                    placeholder: "Thai Nguyen",
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: this._distanceOfInput),
              child: MyDropDown(
                title: "COUNTRY",
                width: double.infinity,
                list: this._countryData,
                valueCallback: this.countryValue,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: this._distanceOfInput),
              child: this.settings(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: cnf.wcDistanceButtonAndText, bottom: cnf.wcLogoMarginTop),
              child: LargeButton(
                onTap: () {
                  handleAddAddress(
                      context: context,
                      screenTitle: this.widget.title,
                      addressLineOne: this._addressLineOne.text,
                      city: this._city.text,
                      addressLineTwo: this._addressLineTwo.text,
                      zipCode: this._zipCode.text,
                      country: this.country,
                      selectOffice: this.officeSelected,
                      selectPartyPlace: this.partyPlace,
                      selectPrivateHouse: this.privateHouseSelected,
                      isShipping: this.setShippingAddress,
                      isPickup: this.setPickupAddress,
                      isDefault: this.setDefaultAddress
                  ).then((value) {
                    setState(() {
                      // refresh
                    });
                  });
                },
                label: (this.widget.title == null) ? "ADD ADDRESS" : "ADD NEW ADDRESS",
              ),
            ),
            if (this.widget.title == null) Padding(
              padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
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
                onTap: () => Navigator.pushNamed(context, 'payment-setup/'),
              ),
            )
          ],
        );
      },
    );
  }

  Widget settings()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                height: this.heightItem,
                child: MyText(
                  text: "Settings",
                  color: cnf.colorMainStreamBlue,
                  fontSize: cnf.input_text_fontSize,
                  fontFamily: "Bebas Neue",
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: this.heightItem,
                child: typeOfLocation(),
              ),
              SizedBox(
                height: this.heightItem,
                child: SwitchGroup(
                  label: "Set as default address",
                  isOn: this.setDefaultAddress,
                  callback: _setDefaultCallback,
                  lableColor: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                ),
              ),
              SizedBox(
                height: this.heightItem,
                child: SwitchGroup(
                  label: "Set as pickup address",
                  isOn: this.setPickupAddress,
                  callback: _setPickupCallback,
                  lableColor: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                ),
              ),
              SizedBox(
                height: this.heightItem,
                child: SwitchGroup(
                    label: "Set as the shipping address",
                    isOn: this.setShippingAddress,
                    callback: _setShippingCallback,
                  lableColor: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget typeOfLocation()
  {
    return Row(
      children: [
        Expanded(
          child: MyText(
            align: TextAlign.start,
            text: "Type",
            fontSize: 15.0,
            color: cnf.colorLightGrayShadow,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                this.partyPlace = !this.partyPlace;
                if (this.officeSelected == true || this.privateHouseSelected == true) {
                  this.officeSelected = false;
                  this.privateHouseSelected = false;
                }
              });
            },
            child: TypeOfLocation(name: "Party place", isSelected: this.partyPlace),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 15.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                this.officeSelected = !this.officeSelected;
                if (this.privateHouseSelected == true || this.partyPlace == true) {
                  this.privateHouseSelected = false;
                  this.partyPlace = false;
                }
              });
            },
            child: TypeOfLocation(name: "Office", isSelected: this.officeSelected),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              this.privateHouseSelected = !this.privateHouseSelected;
              if (this.officeSelected == true || this.partyPlace == true) {
                this.officeSelected = false;
                this.partyPlace = false;
              }
            });
          },
          child: TypeOfLocation(name: "Private house", isSelected: this.privateHouseSelected),
        ),
      ],
    );
  }
}