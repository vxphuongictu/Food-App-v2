import 'dart:math';

import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/requests/deleteUser.dart';
import 'package:food_e/screens/authenticate/ChangePassword.dart';
import 'package:food_e/screens/welcome/AuthenticatedOptionsScreen.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyInput.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/requests/updateUser.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';
import 'package:food_e/functions/authenticate/logout.dart';
import 'package:provider/provider.dart';


class AccountProfile extends StatefulWidget
{
  @override
  State<AccountProfile> createState() {
    return _AccountProfile();
  }
}


class _AccountProfile extends State<AccountProfile>
{

  TextEditingController _firstName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _email = TextEditingController();
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
          disabledBodyHeight: true,
          appbarBgColor: (value.darkmode == true) ? cnf.darkModeColorbg.toColor() : Colors.white,
          extendBodyBehindAppBar: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: (value.darkmode == true) ? cnf.colorWhite.toColor() : cnf.colorBlack.toColor(),
              size: cnf.leadingIconSize,
            ),
          ),
          margin: true,
          screenBgColor: cnf.colorWhite,
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
                label: "ACCOUNT AND PROFILE",
                color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
              ),
              this.delete_account(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              this.input_form(),
              this.change_password(),
              this.submit_btn()
            ],
          ),
        );
      },
    );
  }

  Widget delete_account({GestureTapCallback? onTap})
  {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(
                FontAwesomeIcons.trashCan,
                color: cnf.colorLightRed.toColor(),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (await confirm(
                  context,
                  title: MyText(text: "Are you sure?"),
                  content: MyText(text: "Are you sure to delete your accounts ?")
                )) {
                  EasyLoading.show(status: "Deleting ...");
                  deleteUser(id: this._userID!).then((value) {
                    if (value['status'] == false) {
                      EasyLoading.showError(value['message']);
                    } else {
                      EasyLoading.showSuccess("Done");
                      Future.delayed(
                        Duration(seconds: 2),
                        () async {
                          await logout();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AuthenticatedOptionsScreen()));
                        },
                      );
                    }
                  });
                } else {
                  EasyLoading.showSuccess("Cancel");
                }
              },
              child: MyText(
                text: "Delete Account",
                color: cnf.colorLightRed,
                fontSize: 14.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget input_form()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyInput(
              width: MediaQuery.of(context).size.width * 0.4,
              textController: this._firstName,
              title: "FIRST NAME",
              placeholder: "John",
            ),
            MyInput(
              width: MediaQuery.of(context).size.width * 0.4,
              textController: this._lastName,
              title: "LAST NAME",
              placeholder: "Doe",
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop),
          child: MyInput(
            textController: this._email,
            title: "EMAIL",
            placeholder: "johndoe@email.com",
          ),
        )
      ],
    );
  }

  Widget change_password()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop),
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangePassword())
            ),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(
                      FontAwesomeIcons.lock,
                      color: cnf.colorMainStreamBlue.toColor(),
                      size: 20.0,
                    )
                ),
                Expanded(
                  child: MyText(
                    text: "Change Password",
                    align: TextAlign.start,
                    color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorLightGrayShadow,
                  ),
                ),
                Icon(
                  FontAwesomeIcons.angleRight,
                  size: 20.0,
                  color: (value.darkmode == true) ? cnf.colorWhite.toColor() : cnf.colorLightGrayShadow.toColor(),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget submit_btn()
  {
    return Padding(
      padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop, bottom: cnf.wcLogoMarginTop),
      child: LargeButton(
        onTap: () {
          EasyLoading.show(status: "Updating ...");
          updateUser(
            id: this._userID!,
            lastName: this._lastName.text,
            firstName: this._firstName.text,
            email: this._email.text
          ).then((value) {
            if (value['status'] == true) {
              EasyLoading.showSuccess("Completed!");
              logout();
              Navigator.push(context, MaterialPageRoute(builder: (context) => AuthenticatedOptionsScreen()));
            } else {
              EasyLoading.showError(value['message']);
            }
            Future.delayed(
              const Duration(seconds: 3),
              () => EasyLoading.dismiss(),
            );
          });
        },
        label: "UPDATE",
      ),
    );
  }
}