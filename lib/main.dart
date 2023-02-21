import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_e/provider/LikedProvider.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/screens/Payment/MyPaymentMethod.dart';
import 'package:food_e/screens/account/Account.dart';
import 'package:food_e/screens/account/AccountProfile.dart';
import 'package:food_e/screens/address/MyAddress.dart';
import 'package:food_e/screens/cart/Basket.dart';
import 'package:food_e/screens/Payment/PaymentSetup.dart';
import 'package:food_e/screens/address/AddressSetup.dart';
import 'package:food_e/screens/authenticate/ForgotPassword.dart';
import 'package:food_e/screens/authenticate/Login.dart';
import 'package:food_e/screens/authenticate/register.dart';
import 'package:food_e/screens/cart/OrderHistory.dart';
import 'package:food_e/screens/checkout/OrderConfirm.dart';
import 'package:food_e/screens/checkout/OrderFailed.dart';
import 'package:food_e/screens/home/Home.dart';
import 'package:food_e/screens/search/Search.dart';
import 'package:food_e/screens/settings/Settings.dart';
import 'package:food_e/screens/welcome/FirstScreen.dart';
import 'package:food_e/screens/welcome/SecondScreen.dart';
import 'package:food_e/screens/welcome/StartAppScreen.dart';
import 'package:food_e/screens/welcome/ThirdScreen.dart';
import 'package:food_e/screens/welcome/AuthenticatedOptionsScreen.dart';
import 'package:food_e/widgets/BottomNavbarMenu.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'provider/BasketProvider.dart';


void main() async {
  await initHiveForFlutter();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((value) {
    runApp(ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: foodApp(),
    ));
  });
}



class ThemeModel extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

class foodApp extends StatefulWidget {
  @override
  State<foodApp> createState() {
    return _foodApp();
  }
}

class _foodApp extends State<foodApp>
{

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BasketProvider()),
        ChangeNotifierProvider(create: (context) => LikedProvider()),
        ChangeNotifierProvider(create: (context) => ThemeModeProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            )
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        builder: EasyLoading.init(),
        onGenerateRoute: (settings){
          switch(settings.name) {
            case 'home/':
              return PageTransition(child: Home(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'welcome-first/':
              return PageTransition(child: FirstScreen(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'welcome-second/':
              return PageTransition(child: SecondScreen(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'welcome-third/':
              return PageTransition(child: ThirdScreen(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'authenticated-options/':
              return PageTransition(child: AuthenticatedOptionsScreen(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'register/':
              return PageTransition(child: Register(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'login/':
              return PageTransition(child: Login(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'forgot-password/':
              return PageTransition(child: ForgotPassword(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'bottom-nav-bar-menu/':
              return PageTransition(child: BottomNavbarMenu(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'search/':
              return PageTransition(child: Search(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'address-setup/':
              return PageTransition(child: AddressSetup(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'payment-setup/':
              return PageTransition(child: PaymentSetup(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'basket/':
              return PageTransition(child: Basket(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'order-history/':
              return PageTransition(child: OrderHistory(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'order-confirm/':
              return PageTransition(child: OrderConfirm(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'order-failed/':
              return PageTransition(child: OrderFailed(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'account/':
              return PageTransition(child: Account(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'address-manager/':
              return PageTransition(child: MyAddress(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'my-payment/':
              return PageTransition(child: MyPaymentMethod(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'account-profile/':
              return PageTransition(child: AccountProfile(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            case 'settings/':
              return PageTransition(child: Settings(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
            default:
              return PageTransition(child: StartAppScreen(), type: PageTransitionType.scale, alignment: Alignment.bottomCenter, duration: Duration(milliseconds: 500));
          }
        },
      ),
    );
  }
}
