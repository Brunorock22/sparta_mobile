
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sparta_marketplace/core/common/global_information.dart';
import 'package:sparta_marketplace/core/util/theme_colors.dart';

class ShoppingCartTray extends StatefulWidget {
  @override
  _ShoppingCartTrayState createState() => _ShoppingCartTrayState();
}

class _ShoppingCartTrayState extends State<ShoppingCartTray> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 8),
      color: ThemeColorsUtil.primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    color: ThemeColorsUtil.accentColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('${GlobalInformation.shoppingCart.numItems}')
                ],
              ),
            ),
          ),
          Text('Ver sacola', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600)),
          Text('R\$ ${GlobalInformation.shoppingCart.totalPrice.toStringAsFixed(2)}', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}
