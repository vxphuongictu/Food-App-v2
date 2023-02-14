
class ProductDetails {
  String ? name;
  String ? title;
  String ? content;
  String ? price;
  List ? galleryImages;

  ProductDetails({
    this.name,
    this.title,
    this.content,
    this.price,
    this.galleryImages
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      title: json['title'],
      name: json['name'],
      content: json['content'],
      price: json['price'],
      galleryImages: json['galleryImages']['nodes']
    );
  }
}