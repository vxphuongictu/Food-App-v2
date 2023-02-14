import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/models/Cart.dart';
import 'package:food_e/screens/product/ProductDetail.dart';
import 'package:food_e/widgets/BaseScreen.dart';
import 'package:food_e/widgets/Loading.dart';
import 'package:food_e/widgets/MyTitle.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/widgets/CartItem.dart';


class Liked extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    return _Liked();
  }
}


class _Liked extends State<Liked>
{

  int countItem = 0;
  late Future<dynamic> listFavouriteItem;

  @override
  void initState() {
    this.listFavouriteItem = DatabaseManager().fetchFavouriteItem();
    this.listFavouriteItem.then((value) => {
      setState((){
        this.countItem = value.length;
      })
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      appbar: false,
      extendBodyBehindAppBar: false,
      disabledBodyHeight: true,
      scroll: true,
      body: (this.countItem > 0) ? _basketScreen() : _favouriteIsEmpty(),
    );
  }

  Widget _favouriteIsEmpty()
  {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Image.asset("assets/images/favourite-empty.webp"),
      ),
    );
  }


  Widget _basketScreen()
  {
    return Padding(
      padding: const EdgeInsets.only(top: cnf.wcLogoMarginTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: cnf.wcLogoMarginLeft),
            child: MyTitle(label: 'LIKED'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
            child: this.listCart(),
          )
        ],
      ),
    );
  }

  Widget listCart()
  {
    return FutureBuilder(
      future: this.listFavouriteItem,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AnimationLimiter(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    child: SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ProductDetail(id: snapshot.data[index]['idFavourite']))
                          ),
                          child: CartItem(
                            screentype: 1,
                            title: "${snapshot.data[index]['nameFavourite']}",
                            thumbnails: Image.network(snapshot.data[index]['thumbnailFavourite']),
                            price: "${snapshot.data[index]['priceFavourite']}",
                            basketOnClick: () async {
                              EasyLoading.showSuccess("Added to cart");
                              await DatabaseManager().insertCart(cart: Cart(
                                  productID: snapshot.data[index]['idFavourite'],
                                  productName: "${snapshot.data[index]['nameFavourite']}",
                                  productQuantity: 1,
                                  productThumbnails: snapshot.data[index]['thumbnailFavourite'],
                                  productPrice: "${snapshot.data[index]['priceFavourite']}")
                              );
                              Future.delayed(
                                const Duration(seconds: 1),
                                    () => EasyLoading.dismiss(),
                              );
                            },
                            onDelete: () async {
                              EasyLoading.showSuccess("Deleted");
                              await DatabaseManager().removeItemInFavourite(id: snapshot.data[index]['idFavourite']);
                              setState(() {
                                this.listFavouriteItem = DatabaseManager().fetchFavouriteItem();
                                this.countItem = this.countItem - 1;
                              });
                              Future.delayed(
                                const Duration(seconds: 1),
                                    () => EasyLoading.dismiss(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }
            ),
          );
        }
        return Loading();
      },
    );
  }
}