import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_e/functions/toColor.dart';
import 'package:food_e/models/Cart.dart';
import 'package:food_e/models/Products.dart';
import 'package:food_e/provider/BasketProvider.dart';
import 'package:food_e/provider/LikedProvider.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/screens/favourite/Liked.dart';
import 'package:food_e/screens/product/ProductDetail.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/widgets/CartItem.dart';
import 'package:food_e/widgets/ItemBox.dart';
import 'package:food_e/widgets/Loading.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/requests/fetchProducts.dart';
import 'package:food_e/widgets/ProductBox.dart';
import 'package:provider/provider.dart';


class ListProducts extends StatefulWidget
{
  @override
  State<ListProducts> createState() {
    return _ListProducts();
  }
}


class _ListProducts extends State<ListProducts>
{

  late Future<List<Products>> _products;

  @override
  void initState() {
    super.initState();
    _products = fetch_products();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return BaseScreen(
            appbar: false,
            appbarBgColor: (value.darkmode == true) ? cnf.darkModeColorbg.toColor() : Colors.white,
            screenBgColor: cnf.colorWhite,
            extendBodyBehindAppBar: false,
            disabledBodyHeight: true,
            scroll: true,
            body: _productsScreen()
        );
      },
    );
  }

  Widget _productsScreen() {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: cnf.wcLogoMarginLeft),
                child: MyTitle(
                  label: 'Foods',
                  color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
                child: this.listProducts(),
              )
            ],
          ),
        );
      },
    );
  }

  Widget listProducts() {
    return FutureBuilder(
      future: this._products,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Products> _item = snapshot.data!;
          return AnimationLimiter(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _item.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetail(id: _item[index].id.toString()))),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: cnf.marginScreen),
                            child: ProductBox(
                              title: "${_item[index].name}",
                              productID: "${_item[index].id}",
                              productQuantity: 1,
                              price: "${_item[index].price}",
                              cartCallback: () {
                                EasyLoading.showSuccess("Added to cart");
                                Provider.of<BasketProvider>(context, listen: false).addCart(
                                    Cart(
                                        productID: _item[index].id.toString(),
                                        productName: "${_item[index].name}",
                                        productQuantity: 1,
                                        productThumbnails: _item[index].thumbnail.toString(),
                                        productPrice: "${_item[index].price.toString()}"
                                    )
                                );
                                Future.delayed(
                                  const Duration(seconds: 1),
                                      () => EasyLoading.dismiss(),
                                );
                              },
                              thumbnails: "${_item[index].thumbnail}",
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}