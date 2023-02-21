import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_e/core/_config.dart' as cnf;
import 'package:food_e/models/Cart.dart';
import 'package:food_e/provider/BasketProvider.dart';
import 'package:food_e/provider/ThemeModeProvider.dart';
import 'package:food_e/screens/product/ListProducts.dart';
import 'package:food_e/screens/product/ProductDetail.dart';
import 'package:food_e/widgets/ItemBox.dart';
import 'package:food_e/widgets/MyText.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:provider/provider.dart';


class Recommend extends StatefulWidget
{

  List<dynamic> products;

  Recommend({
    required this.products
  });

  @override
  State<Recommend> createState() {
    return _Recommend();
  }
}


class _Recommend extends State<Recommend>
{


  final double fontSize = 18.0;
  final double spaceBetweenFromTitleToContent = 40.0;
  // font size of title
  final double fontSizeTitle = 14.0;

  @override
  Widget build(BuildContext context) {
    return recommendedForYou();
  }

  Widget recommendedForYou()
  {
    return Consumer<ThemeModeProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.only(left: cnf.marginScreen, right: cnf.marginScreen),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: MyText(
                    text: "Recommended for you",
                    fontFamily: "Bebas Neue",
                    fontSize: this.fontSize,
                    color: (value.darkmode == true) ? cnf.lightModeColorbg : cnf.darkModeColorbg,
                    align: TextAlign.start,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ListProducts()));
                  },
                  child: MyText(
                    text: "View All",
                    fontFamily: "Bebas Neue",
                    fontSize: this.fontSizeTitle,
                    fontWeight: FontWeight.w400,
                    color: cnf.colorOrange,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 330.0,
              width: double.infinity,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: this.widget.products.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(left: 6.0, right: cnf.marginScreen, top: this.spaceBetweenFromTitleToContent, bottom: this.spaceBetweenFromTitleToContent),
                    child: ItemBox(
                      productQuantity: 0,
                      productID: this.widget.products[index].id.toString(),
                      boxWidth: MediaQuery.of(context).size.width / 1.6 - (cnf.marginScreen * 2),
                      price: this.widget.products[index].price.toString(),
                      title: this.widget.products[index].title.toString(),
                      thumbnails: "${this.widget.products[index].thumbnail}",
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductDetail(id: this.widget.products[index].id)),
                      ),
                      cartCallback: () {
                        EasyLoading.showSuccess("Added to cart");
                        context.read<BasketProvider>().addCart(
                          Cart(
                            productID: this.widget.products[index].id,
                            productName: this.widget.products[index].title.toString(),
                            productQuantity: 1,
                            productThumbnails: "${this.widget.products[index].thumbnail}",
                            productPrice: this.widget.products[index].price.toString()
                          )
                        ).then((value) {
                          Future.delayed(
                              const Duration(seconds: 1),
                                  () => EasyLoading.dismiss(),
                            );
                        });
                      },
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
  
}