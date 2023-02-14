

class Cart
{
  String productID;
  String productName;
  int productQuantity;
  String productThumbnails;
  String productPrice;

  Cart({
    required this.productID,
    required this.productName,
    required this.productQuantity,
    required this.productThumbnails,
    required this.productPrice
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "productID": productID,
      "productName": productName,
      "productQuantity": productQuantity,
      "productThumbnails": productThumbnails,
      "productPrice": productPrice,
    };
    return map;
  }

  // Cart.fromMap(Map<String, dynamic> map) {
  //   productID = map['productID'];
  //   productName = map['productName'];
  //   productQuantity = map['productQuantity'];
  //   productThumbnails = map['productThumbnails'];
  //   productPrice = map['productPrice'];
  // }
}