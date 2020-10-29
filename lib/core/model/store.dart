import 'package:sparta_marketplace/core/model/product.dart';

class Store {
  String id;
  String name;
  String logoUrl;
  List<Product> products = List();

  Store({
    this.id,
    this.name,
    this.logoUrl,
  });

  Store.fromJsonChat(Map<String, dynamic> json) {
    id = json["store_id"];
    name = json["store_name"];
    logoUrl = json["store_logo_url"];
  }

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logoUrl = json['imgUrl'];

    List<dynamic> listProducts = json['produtos'];
    if(listProducts != null){
      listProducts.forEach((element) {
        this.products.add(Product.fromJson(element));
      });
    }

  }
}
