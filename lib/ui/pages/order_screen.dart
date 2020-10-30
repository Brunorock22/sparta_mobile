
import 'package:flutter/material.dart';
import 'package:sparta_marketplace/core/common/global_information.dart';
import 'package:sparta_marketplace/core/util/theme_colors.dart';
import 'package:sparta_marketplace/ui/widgets/shopping_cart_tray.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Pedidos', style: TextStyle(fontFamily: 'Montserrat'),),
          backgroundColor: Colors.white,
          bottom: TabBar(
            unselectedLabelColor: Colors.black.withAlpha(100),
            labelColor: Colors.amber,
            tabs: <Widget>[
              Tab(
                child: Text('ANTERIORES', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600),),
              ),
              Tab(
                child: Text('EM ANDAMENTO', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600),),
              ),
            ],
          ),
        ),
        body: page(),
        bottomNavigationBar: GlobalInformation.shoppingCart.hasItems ? ShoppingCartTray() : SizedBox(),
      ),
    );
  }

  Widget page(){
    return TabBarView(
      children: <Widget>[
        pagePreviousOrder(),
        Center(child: Text('Lista Vazia',  style: TextStyle(
             fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 16, color: ThemeColorsUtil.accentColor,), ),),
      ],
    );
  }

  Widget pagePreviousOrder(){
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(16),
      children: <Widget>[
        orderCard()
      ],
    );
  }

  Widget orderCard(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Dia, 22  de Setembro 2020', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, fontSize: 16),),
        SizedBox(height: 5,),
        Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.brightness_1, size: 40,),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Nome da loja'),
                          SizedBox(height: 5,),
                          Row(
                            children: <Widget>[
                              Text('Pedido entregue', style: TextStyle(color: Colors.grey),),
                              SizedBox(width: 5,),
                              Icon(Icons.brightness_1, color: Colors.grey, size: 5,),
                              SizedBox(width: 5,),
                              Text('0000', style: TextStyle(color: Colors.grey),),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () => {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Avalie seu pedido', style: TextStyle(color: Colors.black.withAlpha(200)),),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.star, size: 18, color: Colors.amber.withAlpha(80)),
                              Icon(Icons.star, size: 18, color: Colors.amber.withAlpha(80)),
                              Icon(Icons.star, size: 18, color: Colors.amber.withAlpha(80)),
                              Icon(Icons.star, size: 18, color: Colors.amber.withAlpha(80)),
                              Icon(Icons.star, size: 18, color: Colors.amber.withAlpha(80)),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        onPressed: () {},
                        child: Text('Ajuda', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.amber)),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: (){},
                        child: Text('Detalhes', style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w600, color: Colors.amber)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
