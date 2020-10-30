import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sparta_marketplace/core/model/store.dart';

class FirebaseService {
  final firestoreInstance = FirebaseFirestore.instance;

  Future<List<Store>> getStores() async {
    List<Store> stores = List();

    await firestoreInstance.collection("loja").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        stores.add(Store.fromJson(result.data()));
      });

    });
    return stores;

  }
}
