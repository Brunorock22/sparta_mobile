
import 'package:flutter/material.dart';
import 'package:sparta_marketplace/core/common/global_information.dart';
import 'package:sparta_marketplace/ui/widgets/shopping_cart_tray.dart';

import '../shopping_cart_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: page(context),
      bottomNavigationBar: GlobalInformation.shoppingCart != null
          ? GlobalInformation.shoppingCart.hasItems
              ? GestureDetector(
                  onTap: () async {
                    final Route route = MaterialPageRoute(builder: (context) => ShoppingCartScreen());

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
    );
  }

  Widget page(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(0),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: GestureDetector(
                onTap: () => {},
                child: ListTile(
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
                  ),
                  title: Text(
                    "Bruno Camargos",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600, fontFamily: "Montserrat"),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text("Editar perfil"),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 8),
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  onTap: () {},
                  leading: Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Chats',
                    style: TextStyle(fontSize: 18, fontFamily: "Montserrat", fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('Minhas conversas'),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ),
                Divider(),
                ListTile(
                  // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CouponScreen(true))),
                  onTap: () => {},
                  title: Text(
                    'Cupons',
                    style: TextStyle(fontSize: 18, fontFamily: "Montserrat", fontWeight: FontWeight.w600),
                  ),
                  leading: Icon(
                    Icons.card_giftcard,
                    color: Colors.black,
                  ),
                  subtitle: Text('Meus cupons de desconto'),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ),
                // Divider(),
                // ListTile(
                //   leading: Icon(
                //     Icons.favorite_border,
                //     color: Colors.black,
                //   ),
                //   title: Text(
                //     'Favoritos',
                //     style: TextStyle(
                //         fontSize: 18,
                //         fontFamily: "Montserrat",
                //         fontWeight: FontWeight.w600),
                //   ),
                //   subtitle: Text('Meus locais favoritos'),
                //   trailing: Icon(
                //     Icons.arrow_forward_ios,
                //     size: 14,
                //   ),
                // ),
                Divider(),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, '/delivery_address'),
                  leading: Icon(
                    Icons.place,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Endereços',
                    style: TextStyle(fontSize: 18, fontFamily: "Montserrat", fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text('Meus endereços de entrega'),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ),
                Divider(),

                ListTile(
                  onTap: () => {},
                  title: Text(
                    'Cartões',
                    style: TextStyle(fontSize: 18, fontFamily: "Montserrat", fontWeight: FontWeight.w600),
                  ),
                  leading: Icon(
                    Icons.credit_card,
                    color: Colors.black,
                  ),
                  subtitle: Text('Meus cartões de crédito salvos'),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  ),
                ),
                Divider(),
                SizedBox(height: 80),
                // ListTile(
                //   leading: Icon(Icons.help_outline),
                //   title: Text(
                //     'Ajuda',
                //     style: TextStyle(
                //         fontSize: 18,
                //         fontFamily: "Montserrat",
                //         fontWeight: FontWeight.w600,
                //         color: Colors.grey),
                //   ),
                //   trailing: Icon(
                //     Icons.arrow_forward_ios,
                //     size: 14,
                //   ),
                // ),
                // Divider(),
                // ListTile(
                //   leading: Icon(Icons.settings),
                //   title: Text(
                //     'Configurações',
                //     style: TextStyle(
                //         fontSize: 18,
                //         fontFamily: "Montserrat",
                //         fontWeight: FontWeight.w600,
                //         color: Colors.grey),
                //   ),
                //   trailing: Icon(
                //     Icons.arrow_forward_ios,
                //     size: 14,
                //   ),
                // ),
                // Divider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
