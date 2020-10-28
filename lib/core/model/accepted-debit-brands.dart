class AcceptedDebitBrands {
  String id;
  String brandName;
  String brandPicture;
  int type;
  String createdAt;
  String updatedAt;
  String brandPictureUrl;
  String sId;

  AcceptedDebitBrands({
    this.id,
    this.brandName,
    this.brandPicture,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.brandPictureUrl,
    this.sId,
  });

  AcceptedDebitBrands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
    brandPicture = json['brand_picture'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    brandPictureUrl = json['brand_picture_url'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand_name'] = this.brandName;
    data['brand_picture'] = this.brandPicture;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['brand_picture_url'] = this.brandPictureUrl;
    data['_id'] = this.sId;
    return data;
  }
}
