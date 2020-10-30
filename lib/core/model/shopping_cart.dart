
import 'item_order.dart';
import 'store.dart';

enum Status { added, store_differ }

class ShoppingCart {
  Store store;
  List<ItemOrder> products = [];
  bool hasItems = false;
  DateTime orderDate;

  int numItems = 0;

  double discount = 0;
  double totalPrice = 0;




  ShoppingCart();

  void clear() {
    store = null;
    totalPrice = 0;
    hasItems = false;
    products = [];
    store = null;
    discount = 0;
  }


  Status addOrder(ItemOrder orderProduct) {
    if (products.isEmpty) {
      store = orderProduct.store;
      products.add(orderProduct);
      //   setStore(store.id);
      _recalculate();
    } else {
      //Caso já exista um produto no carrinho, verifique se pertence a mesma loja
      Store storeTemp = orderProduct.store;

      //Caso for a mesma loja, então iremos continuar adicionando
        //Caso o mesmo produto já foi adicionado, vamos apenas aumentar a quantidade
        bool productExists = false;
        for (var i = 0; i < products.length; ++i) {
            products[i].quantity += orderProduct.quantity;
            productExists = true;
            _recalculate();

        }

        //Produto ainda não foi adicionado
        if (!productExists) {
          //   setStore(store.id);
          products.add(orderProduct);
          _recalculate();
          return Status.added;
        }

    }
  }

  void _recalculate() {
    numItems = 0;
    totalPrice = 0;
    for (var i = 0; i < products.length; ++i) {
      ItemOrder item = products[i];
      double val = item.quantity.toDouble() * item.product.price.toDouble();

      totalPrice += val;

      numItems += item.quantity;
    }

    hasItems = products.length > 0;
  }

  void removeOrder(int index) {
    products.removeAt(index);

    _recalculate();
  }

  void removeCoupon() {
    _recalculate();
  }

}
