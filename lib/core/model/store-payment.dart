
import 'accepted-credit-brands.dart';
import 'accepted-debit-brands.dart';

class StorePayment {
  bool acceptMoney;
  bool acceptDebitCard;
  bool acceptOnline;
  bool acceptCreditCard;
  List<AcceptedDebitBrands> acceptedDebitBrands;
  List<AcceptedCreditBrands> acceptedCreditBrands;
  String sId;
  String storeId;
  String createdAt;
  String updatedAt;
  int iV;

  StorePayment({this.acceptMoney, this.acceptDebitCard, this.acceptOnline, this.acceptCreditCard, this.acceptedDebitBrands, this.acceptedCreditBrands, this.sId, this.storeId, this.createdAt, this.updatedAt, this.iV});

  StorePayment.fromJson(Map<String, dynamic> json) {
    acceptMoney = json['accept_money'];
    acceptDebitCard = json['accept_debit_card'];
    acceptOnline = json['accept_online'];
    acceptCreditCard = json['accept_credit_card'];
    if (json['accepted_debit_brands'] != null) {
      acceptedDebitBrands = new List<AcceptedDebitBrands>();
      json['accepted_debit_brands'].forEach((v) {
        acceptedDebitBrands.add(new AcceptedDebitBrands.fromJson(v));
      });
    }
    if (json['accepted_credit_brands'] != null) {
      acceptedCreditBrands = new List<AcceptedCreditBrands>();
      json['accepted_credit_brands'].forEach((v) {
        acceptedCreditBrands.add(new AcceptedCreditBrands.fromJson(v));
      });
    }
    sId = json['_id'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accept_money'] = this.acceptMoney;
    data['accept_debit_card'] = this.acceptDebitCard;
    data['accept_online'] = this.acceptOnline;
    data['accept_credit_card'] = this.acceptCreditCard;
    if (this.acceptedDebitBrands != null) {
      data['accepted_debit_brands'] = this.acceptedDebitBrands.map((v) => v.toJson()).toList();
    }
    if (this.acceptedCreditBrands != null) {
      data['accepted_credit_brands'] = this.acceptedCreditBrands.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['store_id'] = this.storeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
