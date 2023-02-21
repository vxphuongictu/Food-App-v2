import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyInput.dart';
import 'package:food_e/widgets/MyRichText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/requests/register.dart';
import 'package:provider/provider.dart';


class Register extends StatefulWidget
{
  @override
  State<Register> createState() {
    return _Register();
  }
}

class _Register extends State<Register>
{


  void _handleRegister() async {
    if (this.fullname.text == "") {
      EasyLoading.showError(duration: const Duration(seconds: 3), "Full name is required");
    } else if (this.email.text == "") {
      EasyLoading.showError(duration: const Duration(seconds: 3), "Email is required");
    }else if (this.phone.text == "") {
      EasyLoading.showError(duration: const Duration(seconds: 3), "Phone is required");
    } else if (this.password.text == "" || this.confirm.text == "") {
      EasyLoading.showError(duration: const Duration(seconds: 3), "Password is required");
    } else if (this.password.text != this.confirm.text) {
      EasyLoading.showError(duration: const Duration(seconds: 3), "Password incorrect");
    } else {
      EasyLoading.show(status: "Sign Up ...");
      final _register = await register(email: this.email.text,
          password: this.password.text,
          fullname: this.fullname.text);

      if (_register.toString() == "") {
        EasyLoading.showInfo("Sign up successfully!");
        Future.delayed(const Duration(seconds: 3), () {
          EasyLoading.dismiss();
          Navigator.pushNamed(context, 'login/');
        });
      } else {
        EasyLoading.showError(duration: Duration(seconds: 3), "${_register}");
      }
    }
  }

  final double _distanceOfInput = 30.0;
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();
  bool _showPassword = true;
  bool _showConfirm = true;
  IconData _pwdIcon = Icons.remove_red_eye;
  IconData _pwdIconConfirm = Icons.remove_red_eye;

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return BaseScreen(
          appbar: true,
          scroll: false,
          extendBodyBehindAppBar: false,
          appbarBgColor: (value.darkmode == true) ? cnf.darkModeColorbg.toColor() : Colors.white,
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
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: cnf.wcDistanceButtonAndText),
                  child: MyTitle(
                    label: "REGISTER",
                    color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                  ),
                ),
                this.registerForm()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget registerForm()
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: this._distanceOfInput),
          child: MyInput(
            title: "FULL NAME",
            placeholder: "What is your name?",
            textController: this.fullname,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: this._distanceOfInput),
          child: MyInput(
            title: "EMAIL",
            placeholder: "What is your email?",
            textController: this.email,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: this._distanceOfInput),
          child: MyInput(
            title: "PHONE",
            placeholder: "What is your phone number?",
            textController: this.phone,
            isNumber: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: this._distanceOfInput),
          child: MyInput(
            title: "PASSWORD",
            placeholder: "********",
            sufix: this._pwdIcon,
            hiddenText: this._showPassword,
            textController: this.password,
            suffixOnTap: () => setState(() {
              this._showPassword = !this._showPassword;
              this._pwdIcon = (this._showPassword == true) ? Icons.remove_red_eye : FontAwesomeIcons.eyeSlash;
            }),
          ),
        ),
        MyInput(
          title: "CONFIRM",
          placeholder: "********",
          sufix: this._pwdIconConfirm,
          hiddenText: this._showConfirm,
          textController: this.confirm,
          suffixOnTap: () => setState(() {
            this._showConfirm = !this._showConfirm;
            this._pwdIconConfirm = (this._showConfirm == true) ? Icons.remove_red_eye : FontAwesomeIcons.eyeSlash;
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: cnf.wcDistanceButtonAndText, bottom: cnf.wcLogoMarginTop),
          child: LargeButton(
            onTap: _handleRegister,
            label: "REGISTER",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
          child: MyRichText(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontfamily: "Poppins",
            firstText: "Already have an account? ",
            firstTextColor: cnf.colorGray,
            secondText: "Login",
            secondTextColor: cnf.colorOrange,
            onTapSecondText: () => Navigator.pushNamed(context, 'login/'),
          ),
        )
      ],
    );
  }
}