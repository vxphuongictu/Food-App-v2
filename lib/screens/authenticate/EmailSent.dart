import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/requests/forgot_password.dart.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/screens/authenticate/ResetPassword.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyRichText.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/functions/integerToTime.dart';
import 'dart:async';

import 'package:provider/provider.dart';


class EmailSent extends StatefulWidget
{

  String email;

  EmailSent({
    required this.email
  });

  @override
  State<EmailSent> createState() {
    return _EmailSent();
  }
}

class _EmailSent extends State<EmailSent>
{
  late Timer _time;
  bool _visiableCounDown = false;
  int _start = cnf.ForgotPwdTimeToResend;

  void _voidCountDown() async {
    _time = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        (this._start == 0) ? setState(() {
          timer.cancel();
        }) : setState(() {
          this._start--;
        });
      }
    );
  }


  void _resendEmail() async {
    if (this._start <= 0 || this._visiableCounDown == false) {
      EasyLoading.show(status: "Resend ...");
      final _handle = await forgotPassword(email: this.widget.email);
      if (_handle.message == true) {
        EasyLoading.showSuccess(duration: const Duration(seconds: 3), "Password has been sent to your email");
        setState(() {
          this._start = cnf.ForgotPwdTimeToResend;
          this._visiableCounDown = true;
          _voidCountDown();
        });
      } else {
        EasyLoading.showError(
            duration: const Duration(seconds: 3), "${_handle.message}");
      }
    } else {
      EasyLoading.showError(duration: Duration(seconds: 3), "Too fast, please try again later");
    }
  }

  @override
  void dispose() {
    this._time.cancel();
    super.dispose();
  }

  @override
  void initState() {
    this._voidCountDown();
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
        return Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTitle(
                label: "EMAIL SENT",
                color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
              ),
              Padding(
                  padding: EdgeInsets.zero,
                  child: MyRichText(
                    firstText: "We’ve sent you an email at ",
                    firstTextColor: cnf.colorGray,
                    secondText: "${this.widget.email} ",
                    secondTextColor: cnf.colorMainStreamBlue,
                    thirdText: "for verification. Check your email for the verification link.",
                    thirdTextColor: cnf.colorGray,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    fontfamily: "Poppins",
                  )
              ),
              Expanded(child: Image.asset("assets/images/email_has_been_sent.png")),
              this.emailSentScreen()
            ],
          ),
        );
      },
    );
  }

  Widget emailSentScreen()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: this._visiableCounDown,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: MyText(
                  text: "${intToTimeLeft(this._start)}",
                  color: cnf.colorOrange,
                  fontFamily: "Bebas Neue",
                  align: TextAlign.start,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: MyText(
                text: "Did not receive the email yet?",
                align: TextAlign.start,
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins",
                color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: cnf.wcDistanceButtonAndText),
              child: GestureDetector(
                onTap: this._resendEmail,
                child: MyText(
                  text: "Resend",
                  color: cnf.colorMainStreamBlue,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
              child: LargeButton(
                onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ResetPassword(email: this.widget.email)),
                ),
                label: "NEXT",
              ),
            ),
          ],
        );
      },
    );
  }
}