import 'offer.dart';

class Product{
  String name;
  String imgUrl;
  String description;
  num price;
  Offer currentOffer;
  Offer currentGeneralOffer;

  Product({

    this.name,
    this.description,
    this.price,

    this.currentGeneralOffer,
    this.currentOffer,
  });


  Product.fromJson(Map<String, dynamic> json){
    name = json["name"];
    imgUrl = json["imgUrl"];
    description = json["description"];
    price = json["price"];
  }
}