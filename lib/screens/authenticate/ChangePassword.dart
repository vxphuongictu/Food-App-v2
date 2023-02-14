import 'package:flutter/material.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/requests/changePassword.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyInput.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';


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
    return BaseScreen(
      appbar: true,
      appbarBgColor: cnf.colorWhite,
      extendBodyBehindAppBar: false,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios,
          color: cnf.colorBlack.toColor(),
          size: cnf.leadingIconSize,
        ),
      ),
      margin: true,
      body: _screen(),
    );
  }

  Widget _screen()
  {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTitle(
            label: "CHANGE PASSWORD",
          ),
          const Expanded(child: SizedBox()),
          this.form_input(),
          this.submit_button()
        ],
      ),
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
              confirmPassword: this._confirmPwd.text
          );
        },
        label: "CHANGE PASSWORD",
      ),
    );
  }
}