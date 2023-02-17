import 'package:banner_carousel/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/models/Products.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/requests/fetchProducts.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/widgets/MyRichText.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/RestaurantBox.dart';
import 'package:food_e/core/SharedPreferencesClass.dart';
import 'package:food_e/models/Account.dart';
import 'package:food_e/widgets/Recommend.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget
{

  @override
  State<Home> createState() {
    return _Home();
  }
}


class _Home extends State<Home>
{

  final double fontSize = 18.0;
  final double spaceBetweenFromBannerToHeader = 30.0;
  final double spaceBetweenFromTitleToContent = 20.0;
  final double spaceBetweenFromBannerToContent = 40.0;

  final List<BannerModel> listBanner = [
    BannerModel(imagePath: "assets/images/BannerCard.png", id: "0", boxFit: BoxFit.cover),
    BannerModel(imagePath: "assets/images/BannerCard.png", id: "1", boxFit: BoxFit.cover)
  ];

  late Future<List<Products>> _listProducts;

  List<dynamic> listRecommended = [
    {"title": "Egg Salad", "thumbnails": "assets/images/prd1.png", "price": 5.0},
    {"title": "Egg Salad", "thumbnails": "assets/images/prd1.png", "price": 5.0},
    {"title": "Egg Salad", "thumbnails": "assets/images/prd1.png", "price": 5.0},
  ];

  List<dynamic> listRestaurants = [
    Image.asset("assets/images/restaurant-1.png"),
    Image.asset("assets/images/restaurant-2.png"),
    Image.asset("assets/images/restaurant-3.png"),
    Image.asset("assets/images/restaurant-4.png"),
    Image.asset("assets/images/restaurant-1.png"),
    Image.asset("assets/images/restaurant-2.png"),
    Image.asset("assets/images/restaurant-3.png"),
    Image.asset("assets/images/restaurant-4.png"),
  ];

  SharedPreferencesClass _share = SharedPreferencesClass();

  // user information
  Account ? user_data;

  @override
  void initState() {
    this._listProducts = fetch_products();
    this._share.get_user_info().then((value){
      if (value != null) {
        setState(() {
          this.user_data = value;
        });
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      screenBgColor: cnf.colorWhite,
      disabledBodyHeight: true,
      body: this._homeBody(),
    );
  }

  Widget _homeBody()
  {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 500),
          childAnimationBuilder: (p0) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: p0,
            ),
          ),
          children: [
            this.userInfo(),
            this.banner(),
            FutureBuilder(
              future: this._listProducts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Recommend(products: snapshot.data!);
                }
                return SizedBox();
              },
            ),
            this.restaurants(),
          ]
        ),
      ),
    );
  }

  Widget userInfo()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop, left: cnf.marginScreen, right: cnf.marginScreen),
          child: Row(
            children: [
              MyRichText(
                firstText: "Hello, ",
                secondText: "${this.user_data?.displayname}",
                thirdText: "!",
                secondTextColor: cnf.colorMainStreamBlue,
                firstTextColor: (value.darkmode == true) ? cnf.colorWhite : cnf.colorLightBlack,
                fontfamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: this.fontSize,
              ),
              const Expanded(child: SizedBox()),
              MyText(
                text: "HOME",
                fontWeight: FontWeight.w400,
                fontFamily: "Bebas Neue",
                fontSize: this.fontSize,
                color: cnf.colorOrange,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 5.0, bottom: 2.5),
                  child: Icon(
                    Icons.location_on_outlined,
                    size: this.fontSize,
                    color: cnf.colorOrange.toColor(),
                  )
              )
            ],
          ),
        );
      },
    );
  }

  Widget banner()
  {
    return Padding(
        padding: EdgeInsets.only(top: this.spaceBetweenFromBannerToHeader),
        child: Image.asset("assets/images/BannerCard.png", width: double.infinity, fit: BoxFit.cover,)
    );
  }

  Widget restaurants()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: this.spaceBetweenFromTitleToContent),
                child: MyText(
                  text: "RESTAURANTS",
                  fontFamily: "Bebas Neue",
                  fontSize: this.fontSize,
                  color: (value.darkmode == true) ? cnf.lightModeColorbg : cnf.darkModeColorbg,
                ),
              ),
              SizedBox(
                height: cnf.boxRestaurantsSize,
                width: double.infinity,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: this.listRestaurants.length,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.only(right: cnf.marginScreen, bottom: cnf.marginScreen),
                      child: RestaurantBox(childWidget: this.listRestaurants[index]),
                    )
                ),
              )
            ],
          ),
        );
      },
    );
  }
}