import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_e/screens/checkout/CheckOut.dart';
import 'package:food_e/screens/home/Home.dart';
import 'package:food_e/screens/product/ProductDetail.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/LargeButton.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/widgets/CartItem.dart';
import 'package:food_e/core/DatabaseManager.dart';


class Basket extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _Basket();
  }
}


class _Basket extends State<Basket>
{

  // list cart
  late Future<List<dynamic>> listCartItem;

  // define total price
  double totalPrice = 0;

  /* functions */
  void totalPriceCaculator({required String price}) {
    String _price = price.replaceAll("\$", "");
    try {
      _price = _price.split("-")[1].trim();
    } catch (e) {
      _price = _price.trim();
    }

    setState(() {
      this.totalPrice = this.totalPrice + double.parse(_price);
    });
  }

  void clearAllcart() {
    DatabaseManager().clearCart().then((_) {
      setState(() {
        this.totalPrice = 0; // reset total price
        this.fetchCart();
      });
    });
  }

  void fetchCart() {
    this.listCartItem = DatabaseManager().fetchCart();
    this.listCartItem.then((value) {
      value.forEach((element) {
        this.totalPriceCaculator(price: element['productPrice']);
      });
    });
  }

  /* end functions */

  @override
  void initState() {
    this.fetchCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appbar: false,
      extendBodyBehindAppBar: false,
      body: (this.totalPrice.toInt() > 0) ? _basketScreen() : _cartEmty()
    );
  }

  // screen when cart is empty
  Widget _cartEmty()
  {
    return Padding(
      padding: EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/cart-empty.webp'),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: MyText(
                text: "Your Cart is Empty",
                color: cnf.colorBlack,
                fontWeight: FontWeight.w900,
                fontSize: 25.0,
              ),
            ),
            MyText(
              text: "Looks like you haven't added anythingto your cart yet",
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
                MyTitle(label: 'BASKET'),
                Expanded(
                  child: GestureDetector(
                    onTap: () => clearAllcart(),
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
                    Expanded(child: this.listCart()),
                    this.details()
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }

  // details of cart
  Widget details()
  {
    return Padding(
      padding: const EdgeInsets.only(bottom: cnf.wcLogoMarginTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTitle(
            label: "TOTAL",
            fontFamily: "Bebas Neue",
            fontSize: 18.0,
          ),
          MyTitle(
            label: "\$ ${this.totalPrice.toStringAsFixed(2)}",
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
                          totalPrice: this.totalPrice.toStringAsFixed(2),
                        )),
                  ),
              label: "PROCEED TO CHECKOUT",
            ),
          )
        ],
      ),
    );
  }

  Widget listCart()
  {
    return FutureBuilder<List<dynamic>>(
      future: this.listCartItem,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AnimationLimiter(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.length,
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
                                    ProductDetail(id: "${snapshot.data?[index]['productID']}")
                                )
                            );
                          },
                          child: CartItem(
                            screentype: 0,
                            onDelete: () async {
                              await DatabaseManager().removeItemInCart("${snapshot.data?[index]['productID']}");
                              setState(() {
                                this.totalPrice = 0; // reset total price
                                this.fetchCart();
                              });
                            },
                            quantity: "${snapshot.data?[index]['productQuantity']}",
                            title: "${snapshot.data?[index]['productName']}",
                            thumbnails: Image.network(snapshot.data?[index]['productThumbnails']),
                            price: "${snapshot.data?[index]['productPrice']}",
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}