import 'package:flutter/cupertino.dart';
import 'package:food_e/core/DatabaseManager.dart';
import 'package:food_e/models/Favourites.dart';


class LikedProvider with ChangeNotifier
{
  List<Favourites> _liked = [];

  List<Favourites> get liked => _liked;

  Future<void> like({required Favourites item}) async {
    await DatabaseManager().favourite(item: item);
    checkFavourite(item.idFavourite!).then((value){
      if (value == false) {
        _liked.add(item);
      } else {
        _liked.removeWhere((element) => element.idFavourite == item.idFavourite);
      }
    });
    notifyListeners();
  }

  Future<void> removeLiked(String id) async {
    await DatabaseManager().removeItemInFavourite(id: id);
    _liked.removeWhere((likedItem) => likedItem.idFavourite == id);
    notifyListeners();
  }

  Future<void> clearLiked() async {
    await DatabaseManager().clearFavourite();
    _liked.clear();
    this.fetchLiked();
  }

  Future<void> fetchLiked() async {
    DatabaseManager().fetchFavouriteItem().then((value){
      value.forEach((element) {
        _liked.add(
          Favourites(
            idFavourite: element['idFavourite'],
            nameFavourite: element['nameFavourite'],
            priceFavourite: element['priceFavourite'],
            thumbnailFavourite: element['thumbnailFavourite']
          )
        );
      });
      notifyListeners();
    });
  }

  checkFavourite(String id) async {
    bool _isFavourite = await DatabaseManager().checkFavourite(id: id);
    return _isFavourite;
  }

  int countLiked() {
    int _count = 0;
    _liked.forEach((element) {
      _count ++;
    });
    return _count;
  }
}