import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/screens/authenticate/EmailSent.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyInput.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/requests/forgot_password.dart.dart';
import 'package:provider/provider.dart';


class ForgotPassword extends StatefulWidget
{
  @override
  State<ForgotPassword> createState() {
    return _ForgotPassword();
  }
}

class _ForgotPassword extends State<ForgotPassword>
{

  final double _distanceOfInput = 30.0;
  TextEditingController email = TextEditingController();

  // fadeIn image
  bool _visiable = false;


  void _handleForgotPwd() async
  {
    if (this.email.text != "") {
      EasyLoading.show(status: "Processing ...");
      final _handle = await forgotPassword(email: this.email.text);
      if (_handle.message == true) {
        EasyLoading.dismiss();
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EmailSent(email: this.email.text)),
        );
      } else {
        EasyLoading.showError(
            duration: const Duration(seconds: 3), "${_handle.message}");
      }
    } else {
      EasyLoading.showError(duration: const Duration(seconds: 3), "Please enter your email address");
    }
  }

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), () => setState((){
      this._visiable = true;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
        builder: (context, value, child) {
          return BaseScreen(
            appbar: true,
            scroll: false,
            appbarBgColor: (value.darkmode == true) ? cnf.darkModeColorbg.toColor() : Colors.white,
            screenBgColor: cnf.colorWhite,
            extendBodyBehindAppBar: false,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: (value.darkmode == true) ? cnf.colorWhite.toColor() : cnf.colorBlack.toColor(),
              ),
            ),
            margin: true,
            body: _registerScreen(),
          );
        },
    );
  }

  Widget _registerScreen()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyTitle(
                  label: "FORGOT PASSWORD",
                  color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                ),
                MyText(
                  text: "We’ll send a password reset link to your email.",
                  color: cnf.colorGray,
                  align: TextAlign.start,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                ),
                SizedBox(
                  width: double.infinity,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: (this._visiable) ? 1.0 : 0.0,
                    child: Image.asset('assets/images/forgot-password-concept-isolated-white_263070-194.webp'),
                  ),
                ),
                this.formForgot()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget formForgot()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: this._distanceOfInput),
          child: MyInput(
            title: "EMAIL",
            placeholder: "What is your email?",
            textController: this.email,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop, bottom: cnf.wcLogoMarginTop),
          child: LargeButton(
            label: "SEND EMAIL",
            onTap: _handleForgotPwd,
            //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EmailSent(email: "${this.email.text}"))),
          ),
        ),
      ],
    );
  }
}