import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/screens/authenticate/EmailSent.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyInput.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/requests/forgot_password.dart.dart';


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
    return BaseScreen(
      appbar: true,
      appbarBgColor: cnf.colorWhite,
      extendBodyBehindAppBar: false,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.close,
          color: cnf.colorBlack.toColor(),
        ),
      ),
      margin: true,
      body: _registerScreen(),
    );
  }

  Widget _registerScreen()
  {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTitle(
            label: "FORGOT PASSWORD",
          ),
          MyText(
            text: "We’ll send a password reset link to your email.",
            color: cnf.colorGray,
            align: TextAlign.start,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontFamily: "Poppins",
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 500),
            opacity: (this._visiable) ? 1.0 : 0.0,
            child: Image.asset('assets/images/forgot-password-concept-isolated-white_263070-194.webp'),
          ),
          this.formForgot()
        ],
      ),
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