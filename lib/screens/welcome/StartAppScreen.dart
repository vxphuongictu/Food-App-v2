import 'package:flutter/material.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/BottomNavbarMenu.dart';


class StartAppScreen extends StatefulWidget
{

  @override
  State<StartAppScreen> createState() {
    return _StartApp();
  }
}


class _StartApp extends State<StartAppScreen> with TickerProviderStateMixin {

  // Login status. If false will direct to login screen
  bool loginStatus = false;

  bool isDarkMode = false;

  final SharedPreferencesClass _shared = SharedPreferencesClass();

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  double _widthIcon = 70.0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      scroll: false,
      screenBgColor: (this.isDarkMode == true) ? cnf.darkModeColorbg : cnf.lightModeColorbg,
      extendBodyBehindAppBar: true,
      body: (this.loginStatus) ? BottomNavbarMenu() : _loading(),
    );
  }

  @override
  void initState() {
    this._shared.get_user_info().then((value) {
      if (value != null) {
        if (value.authToken != "") {
          setState(() {
            this.loginStatus = true;
          });
        }
      } else {
        Future.delayed(const Duration(seconds: 3), () => Navigator.pushNamedAndRemoveUntil(context, 'welcome-first/', (route) => false));
      }
    });

    SharedPreferencesClass().get_dark_mode_options().then((value){
      if (value != null) {
        setState(() {
          this.isDarkMode = value;
        });
      }
    });
  }

  Widget _loading()
  {
    return Container(
      decoration: BoxDecoration(
        color: (this.isDarkMode == true) ? cnf.darkModeColorbg.toColor() : cnf.lightModeColorbg.toColor()
      ),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: ScaleTransition(
                scale: _animation,
                child: SizedBox(
                  width: this._widthIcon,
                  height: 40,
                  child: (this.isDarkMode == true) ? Image.asset("assets/images/FOOD-E-White.png", fit: BoxFit.contain,) : Image.asset("assets/images/FOOD-E.png", fit: BoxFit.contain),
                ),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
            child: Image.asset("assets/images/RKFD.png"),
          )
        ],
      ),
    );
  }
}