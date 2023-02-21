import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_e/models/Cart.dart';
import 'package:food_e/provider/BasketProvider.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/screens/checkout/CheckOut.dart';
import 'package:food_e/screens/product/ProductDetail.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/widgets/CartItem.dart';
import 'package:provider/provider.dart';


class Basket extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _Basket();
  }
}


class _Basket extends State<Basket>
{

  @override
  void initState() {
    Provider.of<BasketProvider>(context, listen: false).fetchCart(); // load cart
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appbar: false,
      screenBgColor: cnf.colorWhite,
      extendBodyBehindAppBar: false,
      body: (Provider.of<BasketProvider>(context, listen: false).totalPrice().toInt() > 0) ? _basketScreen() : _cartEmty()
    );
  }

  // screen when cart is empty
  Widget _cartEmty()
  {
    return Padding(
      padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/cart-empty.webp'),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: MyText(
                text: "Your Cart is Empty",
                color: cnf.colorLightBlack,
                fontWeight: FontWeight.w900,
                fontSize: 25.0,
              ),
            ),
            MyText(
              text: "Looks like you haven't added anything to your cart yet",
              color: cnf.colorLightGrayShadow,
              fontWeight: FontWeight.w600,
              fontSize: 15.0,
            ),
          ],
        ),
      ),
    );
  }

  // screen will show when has cart
  Widget _basketScreen()
  {
    return Consumer<BasketProvider>(
      builder: (context, value, child) {
        List<Cart> listCartItem = value.cart;
        return Padding(
          padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: cnf.wcLogoMarginLeft, right: cnf.wcLogoMarginLeft),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Consumer<ThemeModeProvider>(
                        builder: (context, value, child) => MyTitle(
                          label: 'BASKET',
                          color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            EasyLoading.show(status: "Waiting ...");
                            Provider.of<BasketProvider>(context, listen: false).clearCart();
                            EasyLoading.showSuccess("Done");
                          },
                          child: MyText(
                            text: "Clear All",
                            color: cnf.colorGray,
                            align: TextAlign.right,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      )
                    ]
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
                    child: Column(
                      children: [
                        Expanded(child: this.listCart(listCartItem)),
                        this.details()
                      ],
                    ),
                  )
              ),
            ],
          ),
        );
      },
    );
  }

  // details of cart
  Widget details()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTitle(
                label: "TOTAL",
                fontFamily: "Bebas Neue",
                fontSize: 18.0,
                color: (value.darkmode == true) ? cnf.colorWhite : cnf.colorBlack,
              ),
              MyTitle(
                label: "\$ ${Provider.of<BasketProvider>(context, listen: false).totalPrice().toStringAsFixed(2)}",
                fontFamily: "Bebas Neue",
                fontSize: 36.0,
                color: cnf.colorOrange,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: LargeButton(
                  onTap: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            CheckOut(
                              totalPrice: Provider.of<BasketProvider>(context, listen: false).totalPrice().toStringAsFixed(2),
                            )),
                      ),
                  label: "PROCEED TO CHECKOUT",
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget listCart(List<Cart> listCart)
  {
    return AnimationLimiter(
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listCart.length,
          itemBuilder: (context, int index) {
            return AnimationConfiguration.staggeredGrid(
              columnCount: 1,
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              ProductDetail(id: "${listCart[index].productID}")
                          )
                      );
                    },
                    child: CartItem(
                      screentype: 0,
                      onDelete: () {
                        EasyLoading.show(status: "Deleting ...");
                        Provider.of<BasketProvider>(context, listen: false).removeCart("${listCart[index].productID}");
                        EasyLoading.showSuccess("Done");
                      },
                      quantity: "${listCart[index].productQuantity}",
                      title: "${listCart[index].productName}",
                      thumbnails: Image.network(listCart[index].productThumbnails),
                      price: "${listCart[index].productPrice}",
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}