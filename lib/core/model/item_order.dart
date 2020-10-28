import 'store.dart';

class ItemOrder {
  int quantity;
  Store store;
  dynamic product;

  ItemOrder(this.quantity, this.store, this.product);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = product.id;
    data['quantity'] = this.quantity;

    if (this.product.offerId != null) {
      data['offer_id'] = this.product.offerId;
    }

    return data;
  }

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = Map<String, dynamic>();

//     if (product.offerId != null) {
//       Map<String, dynamic> data = {
//         "id": product.id,
//         "quantity": quantity,
//       };
//     } else {
//       Map<String, dynamic> data = {
//         "id": product.id,
//         "quantity": quantity,
//         "offer_id": product.offerId,
//       };
//     }

//     return data;
//   }
}
