import 'package:flutter/material.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/authenticate/logout.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/requests/changePassword.dart';
import 'package:food_e/screens/welcome/AuthenticatedOptionsScreen.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyInput.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';
import 'package:provider/provider.dart';


class ChangePassword extends StatefulWidget
{
  @override
  State<ChangePassword> createState() {
    return _ChangePassword();
  }
}


class _ChangePassword extends State<ChangePassword>
{
  TextEditingController _oldPwd = TextEditingController();
  TextEditingController _newPwd = TextEditingController();
  TextEditingController _confirmPwd = TextEditingController();

  String ? _userID;

  @override
  void initState() {
    super.initState();
    SharedPreferencesClass().get_user_info().then((value) {
      if (value.userID != "" && value.userID != null) {
        setState(() {
          this._userID = value.userID;
        });
      }
    });
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
          disabledBodyHeight: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: (value.darkmode == true) ? cnf.colorWhite.toColor() : cnf.colorBlack.toColor(),
              size: cnf.leadingIconSize,
            ),
          ),
          margin: true,
          body: _screen(),
        );
      },
    );
  }

  Widget _screen()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTitle(
                label: "CHANGE PASSWORD",
                color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .3,
              ),
              this.form_input(),
              this.submit_button()
            ],
          ),
        );
      },
    );
  }

  Widget form_input()
  {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
          child: MyInput(
            title: "OLD PASSWORD",
            textController: this._oldPwd,
            placeholder: "Old password",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
          child: MyInput(
            title: "New PASSWORD",
            textController: this._newPwd,
            placeholder: "New password",
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
          child: MyInput(
            title: "CONFIRM PASSWORD",
            textController: this._confirmPwd,
            placeholder: "Confirm password",
          ),
        )
      ],
    );
  }

  Widget submit_button()
  {
    return Padding(
      padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop, bottom: cnf.wcLogoMarginTop),
      child: LargeButton(
        onTap: () async {
          await changePassword(
              id: this._userID!,
              newPassword: this._newPwd.text,
              confirmPassword: this._confirmPwd.text,
          );
          logout();
          Future.delayed(
            const Duration(seconds: 3),
            () => Navigator.push(context, MaterialPageRoute(builder:  (context) => AuthenticatedOptionsScreen()))
          );
        },
        label: "CHANGE PASSWORD",
      ),
    );
  }
}