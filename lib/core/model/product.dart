class Product{
  String name;
  String imgUrl;

  Product.fromJson(Map<String, dynamic> json){
    name = json["name"];
    imgUrl = json["imgUrl"];
  }
}