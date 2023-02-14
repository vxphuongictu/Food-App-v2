import 'package:flutter/material.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/SwitchGroup.dart';

class Settings extends StatefulWidget
{
  @override
  State<Settings> createState() {
    return _Settings();
  }
}

class _Settings extends State<Settings>
{

  bool _darkModeSwitch = false;
  bool _emailMarketingSwitch = false;
  bool _notificationSwitch = false;

  /* functions */
  _changeMode(bool isOn) async {
    setState(() {
      this._darkModeSwitch = !this._darkModeSwitch;
    });
    await SharedPreferencesClass().set_dark_mode(option: isOn);
  }
  _changeEmailMarketing(bool isOn){
    setState(() {
      this._emailMarketingSwitch = !this._emailMarketingSwitch;
    });
  }
  _changeNotification(bool isOn){
    setState(() {
      this._notificationSwitch = !this._notificationSwitch;
    });
  }
  /* end functions */

  @override
  void initState() {
    super.initState();
    SharedPreferencesClass().get_dark_mode_options().then((value){
      if (value != null) {
        setState(() {
          this._darkModeSwitch = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appbar: true,
      extendBodyBehindAppBar: false,
      appbarBgColor: cnf.colorWhite,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios,
          color: cnf.colorBlack.toColor(),
        ),
      ),
      title: "Settings",
      body: _screen(),
    );
  }

  Widget _screen()
  {
    return Stack(
      children: [
        Opacity(
          opacity: .1,
          child: Container(
            color: cnf.colorBlack.toColor(),
          ),
        ),
        Column(
          children: [
            _screenMode(),
            _emailMarketing(),
            _notification()
          ],
        )
      ],
    );
  }

  Widget _screenMode() {
    return Column(
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: cnf.colorWhite.toColor(),
          margin: const EdgeInsets.only(top: cnf.marginScreen, bottom: cnf.marginScreen),
          child: Padding(
            padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
            child: SwitchGroup(
              label: "Dark mode",
              isOn: this._darkModeSwitch,
              callback: _changeMode,
              lableFontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
          child: MyText(
            text: "Computers screens originally used what we now call dark mode, because of the capacities of the cathode-ray tubes used several decades ago. But in a bid to encourage people who weren’t programmers to use computers, interfaces were gradually adapted to resemble paper – i.e. black text on white paper.",
            align: TextAlign.start,
            maxLines: 0,
            color: cnf.colorGray,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        )
      ],
    );
  }

  Widget _emailMarketing() {
    return Column(
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: cnf.colorWhite.toColor(),
          margin: const EdgeInsets.only(top: cnf.marginScreen, bottom: cnf.marginScreen),
          child: Padding(
            padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
            child: SwitchGroup(
              label: "Email marketing",
              isOn: this._emailMarketingSwitch,
              callback: _changeEmailMarketing,
              lableFontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
          child: MyText(
            text: "Most of us are heavy users of our smart devices -- for tasks like accessing local information such as weather, social media, mobile banking, reading the news and searching for local services. These interactions would be meaningless without users sharing their location. ",
            align: TextAlign.start,
            maxLines: 0,
            color: cnf.colorGray,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        )
      ],
    );
  }

  Widget _notification() {
    return Column(
      children: [
        Container(
          height: 50.0,
          width: double.infinity,
          color: cnf.colorWhite.toColor(),
          margin: const EdgeInsets.only(top: cnf.marginScreen, bottom: cnf.marginScreen),
          child: Padding(
            padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
            child: SwitchGroup(
              label: "Notification",
              isOn: this._notificationSwitch,
              callback: _changeNotification,
              lableFontWeight: FontWeight.w900,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
          child: MyText(
            text: "A notification is a message, email, icon, or another symbol that appears when an application wants you to pay attention.",
            align: TextAlign.start,
            maxLines: 0,
            color: cnf.colorGray,
            fontWeight: FontWeight.w600,
            fontSize: 14.0,
          ),
        )
      ],
    );
  }
}