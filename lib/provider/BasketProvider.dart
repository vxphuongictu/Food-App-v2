import 'package:flutter/cupertino.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/models/Cart.dart';


class BasketProvider with ChangeNotifier
{
  List<Cart> _card = [];

  List<Cart> get cart => _card;

  Future<void> addCart(Cart item) async {
    await DatabaseManager().insertCart(cart: item);
    _card.clear();
    this.fetchCart();
  }

  Future<void> removeCart(String id) async {
    await DatabaseManager().removeItemInCart(id);
    _card.removeWhere((cartItem) => cartItem.productID == id);
    notifyListeners();
  }

  Future<void> clearCart() async {
    await DatabaseManager().clearCart();
    _card.clear();
    notifyListeners();
  }

  void fetchCart() {
    DatabaseManager().fetchCart().then((value){
      value.forEach((element) {
        _card.add(
          Cart(
              productID: element['productID'],
              productName: element['productName'],
              productQuantity: element['productQuantity'],
              productThumbnails: element['productThumbnails'],
              productPrice: element['productPrice']
          )
        );
      });
      notifyListeners();
    });
  }

  double totalPrice() {
    double _count = 0;
    _card.forEach((element) {
      String _price = element.productPrice.replaceAll("\$", "");
      try {
        _price = _price.split("-")[1].trim();
      } catch (e) {
        _price = _price.trim();
      }
      _count = _count + double.parse(_price);
    });
    return _count;
  }
}