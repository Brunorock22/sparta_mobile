import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sparta_marketplace/core/common/global_information.dart';
import 'package:sparta_marketplace/core/model/item_order.dart';
import 'package:sparta_marketplace/core/model/product.dart';
import 'package:sparta_marketplace/core/model/store.dart';
import 'package:sparta_marketplace/core/util/theme_colors.dart';
import 'package:sparta_marketplace/ui/shopping_cart_screen.dart';
import 'package:sparta_marketplace/ui/widgets/shopping_cart_tray.dart';

class StoreProductScreen extends StatefulWidget {
  Store store;
  Product product;

  StoreProductScreen(this.store, this.product);

  @override
  _StoreProductScreenState createState() => _StoreProductScreenState();
}

class _StoreProductScreenState extends State<StoreProductScreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        /// Override de quando botao nativo do android ou swipe do ios para setState da tela anterior acontecer
        Navigator.pop(context, true);
        return null;
      },
      child: Scaffold(
          body: Scaffold(
            appBar: AppBar(
              backgroundColor: ThemeColorsUtil.accentColor,
              title: Text('Detalhes do produto',
                  style: TextStyle(fontFamily: 'Montserrat')),
              centerTitle: true,
              leading: IconButton(
                onPressed: () => Navigator.pop(context, true),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
            ),
            body: page(),
            bottomNavigationBar: GlobalInformation.shoppingCart != null
                ? GlobalInformation.shoppingCart.hasItems
                    ? GestureDetector(
                        onTap: () async {
                          final Route route = MaterialPageRoute(
                              builder: (context) => ShoppingCartScreen());

                          ///Reload na tela depois de ser alterado
                          final result = await Navigator.push(context, route);
                          try {
                            if (result != null) {
                              setState(() {});
                            }
                          } catch (e) {}
                        },
                        child: ShoppingCartTray())
                    : SizedBox()
                : SizedBox(),
          ),
          bottomNavigationBar: Container(
            height: 50,
            padding: EdgeInsets.all(8),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity--;
                        quantity = max(quantity, 1);
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      color: ThemeColorsUtil.accentColor,
                      child: Icon(
                        Icons.remove,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '$quantity',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity++;
                        quantity = min(quantity, 99);
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      color: ThemeColorsUtil.accentColor,
                      child: Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: MaterialButton(
                        height: 40,
                        onPressed: addItem,
                        color: ThemeColorsUtil.accentColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Adicionar',
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget page() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 180,
                  height: 180,
                  child: CachedNetworkImage(
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageUrl: widget.product.imgUrl,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${widget.product.name}',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '${widget.product.description}',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 10),
                buildCurrentPrice(widget.product),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCurrentPrice(Product product) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "R\$ ${product.price}",
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.green),
        ),
      ),
    );
  }

  void addItem() {
    ItemOrder item = loadItemOrder(widget.product);
    GlobalInformation.shoppingCart.addOrder(item);
    setState(() {});
  }

  ItemOrder loadItemOrder(Product product) {
    if (product.currentOffer != null && product.currentGeneralOffer != null) {
      if (product.currentOffer.individualDiscountPercentage >
          product.currentGeneralOffer.individualDiscountPercentage) {
        return ItemOrder(
            quantity,
            widget.store,
            Product(
                price: product.price -
                    (product.price *
                        (product.currentOffer.individualDiscountPercentage /
                            100)),
                name: product.name));
      } else {
        return ItemOrder(
            quantity,
            widget.store,
            Product(
                price: product.price -
                    (product.price *
                        (product.currentGeneralOffer
                                .individualDiscountPercentage /
                            100)),
                name: product.name));
      }
    } else {
      if (product.currentOffer != null) {
        return ItemOrder(
            quantity,
            widget.store,
            Product(
                price: product.price -
                    (product.price *
                        (product.currentOffer.individualDiscountPercentage /
                            100)),
                name: product.name));
      }

      if (product.currentGeneralOffer != null) {
        return ItemOrder(
            quantity,
            widget.store,
            Product(
                price: product.price -
                    (product.price *
                        (product.currentGeneralOffer
                                .individualDiscountPercentage /
                            100)),
                name: product.name));
      }

      return ItemOrder(quantity, widget.store, product);
    }
  }
}
