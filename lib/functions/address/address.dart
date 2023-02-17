import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/models/Address.dart';
import 'package:food_e/screens/Payment/MyPaymentMethod.dart';
import 'package:food_e/screens/address/AddressSetup.dart';
import 'package:food_e/screens/address/MyAddress.dart';

handleAddAddress({
  required BuildContext context,
  String ? screenTitle,
  String ? addressLineOne,
  String ? addressLineTwo,
  String ? zipCode,
  String ? city,
  String ? country,
  bool selectOffice = false,
  bool selectPrivateHouse = false,
  bool selectPartyPlace = false,
  bool isDefault = false,
  bool isPickup = false,
  bool isShipping = false
  }) async {

  String type = "";

  if (addressLineOne == "") {
    EasyLoading.showError(duration: const Duration(seconds: 3), "Address Line 1 is required");
  } else if (zipCode == "") {
    EasyLoading.showError(duration: const Duration(seconds: 3), "Zip code is required");
  } else if (city == "") {
    EasyLoading.showError(duration: const Duration(seconds: 3), "City is required");
  } else if (country == "" || country == null) {
    EasyLoading.showError(duration: const Duration(seconds: 3), "Country is required");
  } else {
    if (selectOffice) {
      type = "Office";
    } else if (selectPartyPlace) {
      type = "Party place";
    } else {
      type = "Private house";
    }

    if (isDefault) {
      await DatabaseManager().updateAddress();
    }

    await DatabaseManager().insertAddress(address: Address(
      country: country,
      city: city,
      zipCode: zipCode,
      addressLineTwo: addressLineTwo,
      addressLineOne: addressLineOne,
      isDefault: isDefault,
      isPickup: isPickup,
      isShipping: isShipping,
      type: type
    ));
    (screenTitle == null) ? Navigator.push(context,
    MaterialPageRoute(builder: (context) => MyPaymentMethod())) : Navigator.push(context,
    MaterialPageRoute(builder: (context) => MyAddress()));
  }
}