
class Favourites {
  String ? idFavourite;
  String ? nameFavourite;
  String ? thumbnailFavourite;
  String ? priceFavourite;

  Favourites({
    this.idFavourite,
    this.nameFavourite,
    this.thumbnailFavourite,
    this.priceFavourite
  });

  factory Favourites.formJson(Map<String, dynamic> json) {
    return Favourites(
        idFavourite: json['idFavourite'],
        nameFavourite: json['nameFavourite'],
        thumbnailFavourite: json['thumbnailFavourite'],
        priceFavourite: json['priceFavourite'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'idFavourite': idFavourite,
      'nameFavourite': nameFavourite,
      'thumbnailFavourite': thumbnailFavourite,
      'priceFavourite': priceFavourite,
    };
    return map;
  }
  //
  // Products.fromMap(Map<String, dynamic> map) {
  //   id = map['id'];
  //   name = map['name'];
  //   title = map['title'];
  //   description = map['description'];
  //   price = map['price'];
  //   thumbnail = map['thumbnail'];
  // }
}