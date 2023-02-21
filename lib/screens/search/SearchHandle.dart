/*
 - This widget will show when clients tap to input form and handle data from endpoint
 */

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/models/Cart.dart';
import 'package:food_e/models/Products.dart';
import 'package:food_e/screens/product/ProductDetail.dart';
import 'package:food_e/widgets/ItemBox.dart';
import 'package:food_e/widgets/Loading.dart';
import 'package:food_e/requests/searchProducts.dart';

class SearchHandle extends StatefulWidget
{

  String searchText;

  SearchHandle({
    this.searchText = "",
  });

  @override
  State<SearchHandle> createState() {
    return _SearchHandle();
  }
}

class _SearchHandle extends State<SearchHandle>
{

  // space between
  final double spaceBetweenFromTitleToContent = 40.0;

  // has data
  List<Products> ? _response;

  @override
  void initState() {
    super.initState();
    searchProduct(name: this.widget.searchText).then((value) {
      setState(() {
        this._response = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _focusWidget();
  }


  Widget _focusWidget()
  {
    if (this._response == null) {
      return Loading();
    } else {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 4 / 6.8,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15
          ),
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: this._response!.length,
          itemBuilder: (context, index) {
            return ItemBox(
              title: "${this._response?[index].title}",
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProductDetail(id: "${this._response?[index].id}"))
              ),
              cartCallback: () {
                EasyLoading.showSuccess("Added to cart");
                DatabaseManager().insertCart(
                    cart: Cart(
                        productID: "${this._response?[index].id}",
                        productName: "${this._response?[index].title.toString()}",
                        productQuantity: 1,
                        productThumbnails: "${this._response?[index].thumbnail}",
                        productPrice: "${this._response?[index].price.toString()}"
                    )
                ).then((value){
                  Future.delayed(
                    const Duration(seconds: 1),
                        () => EasyLoading.dismiss(),
                  );
                });
              },
              price: "${this._response?[index].price}",
              productQuantity: 1,
              productID: "${this._response?[index].id}",
              thumbnails: "${this._response?[index].thumbnail}",
            );
          },
        ),
      );
    }
  }
}