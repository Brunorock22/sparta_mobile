class AcceptedCreditBrands {
  String sId;
  String brandName;
  String brandPicture;
  int type;
  String createdAt;
  String updatedAt;
  int iV;
  String brandPictureUrl;
  String id;

  AcceptedCreditBrands({this.sId, this.brandName, this.brandPicture, this.type, this.createdAt, this.updatedAt, this.iV, this.brandPictureUrl, this.id});

  AcceptedCreditBrands.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    brandName = json['brand_name'];
    brandPicture = json['brand_picture'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
    brandPictureUrl = json['brand_picture_url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['brand_name'] = this.brandName;
    data['brand_picture'] = this.brandPicture;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    data['brand_picture_url'] = this.brandPictureUrl;
    data['id'] = this.id;
    return data;
  }
}
