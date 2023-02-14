import 'package:flutter_easyloading/flutter_easyloading.dart';

changePassword({required String id, required String newPassword, required String confirmPassword}) async {
  EasyLoading.show(status: "Waitting ...");
  Future.delayed(
    const Duration(seconds: 3),
    () => EasyLoading.showSuccess("Done"),
  );
}