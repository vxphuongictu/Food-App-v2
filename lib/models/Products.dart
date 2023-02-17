
class Products {
  String ? id;
  String ? name;
  String ? title;
  String ? description;
  String ? price;
  String ? thumbnail;
  List ? galleryImages;

  Products({
    this.id,
    this.name,
    this.title,
    this.description,
    this.price,
    this.thumbnail,
    this.galleryImages
  });

  factory Products.formJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'],
      name: json['name'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      thumbnail: (json['image'] != null) ? json['image']['sourceUrl'] : null
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'name': name,
      'title': title,
      'description': description,
      'price': price,
      'thumbnail': thumbnail
    };
    return map;
  }

  Products.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    title = map['title'];
    description = map['description'];
    price = map['price'];
    thumbnail = map['thumbnail'];
  }
}