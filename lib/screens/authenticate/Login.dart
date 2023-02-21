import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyInput.dart';
import 'package:food_e/widgets/MyRichText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/requests/login.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget
{
  @override
  State<Login> createState() {
    return _Login();
  }
}

class _Login extends State<Login>
{

  final SharedPreferencesClass _shared = SharedPreferencesClass();
  final double _distanceOfInput = 30.0;

  // text controller email & password
  TextEditingController email = TextEditingController(text: "Vxphuongictu998@gmail.com");
  TextEditingController password = TextEditingController(text: "25071998@");

  // show or hidden password
  bool _showPassword = true;

  // icon show or hidden password
  IconData passwordSuffix = Icons.remove_red_eye;

  // fadeIn login image
  bool _visible = false;

  // user address
  String _routerName = 'bottom-nav-bar-menu/';

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 500), () => setState(() {
      this._visible = true;
    }));
  }

  void _login() async
  {
    if (this.email.text == "" || this.password.text == "") {
      EasyLoading.showError(duration: const Duration(seconds: 3), "Username and password are required!");
    } else {
      EasyLoading.show(status: "Sign In ...");
      final sign_in = await login(
          email: this.email.text, password: this.password.text);
      if (sign_in.email != null && sign_in.authToken != null) {
        await this._shared.set_user_info(email: sign_in.email,
            authToken: sign_in.authToken,
            displayname: sign_in.displayname,
            firstname: sign_in.firstname,
            userID: sign_in.userID);
        EasyLoading.dismiss();
        DatabaseManager().fetchAddress().then((value) {
          if (value == null) {
            this._routerName = "address-setup/";
          }
          Navigator.pushNamedAndRemoveUntil(context, this._routerName, (route) => false);
        });
      } else {
        EasyLoading.showError("Username or password invalided");
      }
    }
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
          body: _loginScreen(),
        );
      },
    );
  }

  Widget _loginScreen()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTitle(
                label: "LOGIN",
                color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
              ),
              SizedBox(
                width: double.infinity,
                child: AnimatedOpacity(
                  opacity: this._visible ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: Image.asset('assets/images/login.png'),
                ),
              ),
              this.registerForm()
            ],
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
            title: "EMAIL",
            placeholder: "Enter your email",
            textController: this.email,
          ),
        ),
        MyInput(
          title: "PASSWORD",
          placeholder: "********",
          sufix: this.passwordSuffix,
          hiddenText: this._showPassword,
          textController: this.password,
          suffixOnTap: () => setState(() {
            this._showPassword = !this._showPassword;
            this.passwordSuffix = (this._showPassword == true) ? FontAwesomeIcons.eyeSlash : Icons.remove_red_eye;
          }),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          width: double.infinity,
          alignment: Alignment.centerRight,
          child: MyRichText(
            secondText: "Forgot Password",
            fontfamily: "Poppins",
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            secondTextColor: cnf.colorGray,
            onTapSecondText: () => Navigator.pushNamed(context, 'forgot-password/'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: cnf.wcDistanceButtonAndText, bottom: cnf.wcLogoMarginTop),
          child: LargeButton(
            label: "LOGIN",
            onTap: _login,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
          child: MyRichText(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontfamily: "Poppins",
            firstText: "Don’t have an account? ",
            firstTextColor: cnf.colorGray,
            secondText: "Register",
            secondTextColor: cnf.colorOrange,
            onTapSecondText: () => Navigator.pushNamed(context, 'register/'),
          ),
        )
      ],
    );
  }
}