import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyInput.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/requests/forgot_password.dart.dart';
import 'package:provider/provider.dart';


class ResetPassword extends StatefulWidget
{

  String email;

  ResetPassword({required this.email});

  @override
  State<ResetPassword> createState() {
    return _ResetPassword();
  }
}

class _ResetPassword extends State<ResetPassword>
{

  final double _distanceOfInput = 30.0;
  bool hiddenNewPassword = true;
  bool hiddenConfirmPassword = true;
  TextEditingController _code = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  IconData hiddenNewPasswordIcon = Icons.remove_red_eye;
  IconData hiddenConfirmPasswordIcon = Icons.remove_red_eye;


  void _resetPassword() async {
    if (this._code.text == "") {
      EasyLoading.showError("Invalid verification code", duration: const Duration(seconds: 3));
    } else if (this.newPassword.text == "" || this.confirmPassword.text == "") {
      EasyLoading.showError("Invalid username & password", duration: const Duration(seconds: 3));
    } else if (this.newPassword.text != this.confirmPassword.text) {
      EasyLoading.showError("Password incorrect", duration: const Duration(seconds: 3));
    } else {
      EasyLoading.show(status: "Processing ...");
      String _reset = await changePassword(code: this._code.text, email: this.widget.email, password: this.confirmPassword.text);
      if (_reset == "") {
        EasyLoading.showSuccess(duration: const Duration(seconds: 3), "Change password successfully");
        Future.delayed(
          Duration(seconds: 3),
          () => Navigator.pushNamed(context, 'login/'),
        );
      } else {
        EasyLoading.showError(duration: const Duration(seconds: 3), "${_reset}");
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return BaseScreen(
            appbar: true,
            appbarBgColor: (value.darkmode == true) ? cnf.darkModeColorbg.toColor() : Colors.white,
            extendBodyBehindAppBar: false,
            screenBgColor: cnf.colorWhite,
            disabledBodyHeight: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: (value.darkmode == true) ? cnf.colorWhite.toColor() : cnf.colorBlack.toColor(),
              ),
            ),
            margin: true,
            body: _resetPasswordScreen()
        );
      },
    );
  }

  Widget _resetPasswordScreen()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTitle(
                label: "RESET PASSWORD",
                color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
              ),
              Image.asset("assets/images/confirm-image.png"),
              this.resetPasswordScreen(),
              Padding(
                padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop, top: cnf.wcLogoMarginTop),
                child: LargeButton(
                  onTap: this._resetPassword,
                  label: "RESET PASSWORD",
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget resetPasswordScreen()
  {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: this._distanceOfInput),
            child: MyInput(
              title: "CODE",
              textController: this._code,
              placeholder: "Enter the code received from the email",
              suffixOnTap: () => setState(() {
                this.hiddenNewPassword = !this.hiddenNewPassword;
              }),
            )
        ),
        Padding(
            padding: EdgeInsets.only(bottom: this._distanceOfInput),
            child: MyInput(
              title: "NEW PASSWORD",
              sufix: this.hiddenNewPasswordIcon,
              hiddenText: this.hiddenNewPassword,
              textController: this.newPassword,
              placeholder: "******",
              suffixOnTap: () => setState(() {
                this.hiddenNewPassword = !this.hiddenNewPassword;
                (this.hiddenNewPassword == true) ? FontAwesomeIcons.eyeSlash : Icons.remove_red_eye;
              }),
            )
        ),
        MyInput(
          title: "CONFIRM PASSWORD",
          sufix: this.hiddenConfirmPasswordIcon,
          hiddenText: this.hiddenConfirmPassword,
          textController: this.confirmPassword,
          placeholder: "******",
          suffixOnTap: () => setState(() {
            this.hiddenConfirmPassword = !this.hiddenConfirmPassword;
            (this.hiddenConfirmPassword == true) ? FontAwesomeIcons.eyeSlash : Icons.remove_red_eye;
          }),
        ),
      ],
    );
  }
}