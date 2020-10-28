class Store {
  String id;
  String name;
  String displayName;
  String email;
  String address;
  double latitude;
  double longitude;
  double distance;
  bool isOpen;
  num rate;
  num deliveryTime;
  num radius;
  String cnpj;
  String logo;
  num deliveryFee;
  num rateCount;
  DateTime createdAt;
  DateTime updatedAt;
  String logoUrl;

  Store({
    this.id,
    this.displayName,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.distance,
    this.isOpen,
    this.rate,
    this.deliveryTime,
    this.radius,
    this.cnpj,
    this.logo,
    this.deliveryFee,
    this.createdAt,
    this.updatedAt,
    this.logoUrl,
    this.rateCount,
  });

  Store.fromJsonChat(Map<String, dynamic> json) {
    id = json["store_id"];
    name = json["store_name"];
    logoUrl = json["store_logo_url"];
  }

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['display_name'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    distance = json['distance'];
    isOpen = json['isOpen'];
    rate = json['rate'];
    deliveryTime = json['delivery_time'];
    radius = json['radius'];
    cnpj = json['cnpj'];
    logo = json['logo'];
    rateCount = json['rateCount'] != null ? json['rateCount'] : null;
    deliveryFee = json['delivery_fee'];
    if (json['created_at'] != null) {
      createdAt = DateTime.parse(json['created_at']);
    }
    if (json['updated_at'] != null) {
      updatedAt = DateTime.parse(json['updated_at']);
    }
    logoUrl = json['logo_url'];
  }
}
