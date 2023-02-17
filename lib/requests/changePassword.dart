/// the function is used to handle change password
/// but api doesn't support so usually return true


import 'package:flutter_easyloading/flutter_easyloading.dart';

changePassword({required String id, required String newPassword, required String confirmPassword}) async {

  /// here is a dict will response when called this function
  Map<String, dynamic> _result = {"status": false, "msg": ""};

  if (newPassword == "" || confirmPassword == "") {
    /// check blank password
    EasyLoading.showError("you need to enter password");
  } else if (newPassword != confirmPassword) {
    /// check new pwd and confirm
    EasyLoading.showError("Password incorrect");
  } else {
    /// if pass two conditions
    _result["status"] = true;
    EasyLoading.show(status: "Waitting ...");
    Future.delayed(
      const Duration(seconds: 3),
          () {
        EasyLoading.showSuccess("Done");
      },
    );
  }
  return _result;
}