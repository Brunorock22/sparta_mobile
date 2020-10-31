import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sparta_marketplace/core/common/global_information.dart';
import 'package:sparta_marketplace/core/model/shopping_cart.dart';
import 'package:sparta_marketplace/core/util/theme_colors.dart';

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  DateTime selectedOrderDate = DateTime.now();
  bool isScheduled = false;
  bool mustBeScheduled = false;
  bool gettingCurrentPosition = false;

  @override
  void initState() {
    super.initState();
    GlobalInformation.shoppingCart.orderDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      DateTime.now().hour,
      DateTime.now().minute,
    );

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        /// Override de quando botao nativo do android ou swipe do ios para setState da tela anterior acontecer
        Navigator.pop(context, true);
        return null;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: ThemeColorsUtil.accentColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart),
              SizedBox(
                width: 5,
              ),
              Text(
                'Carrinho',
                style: TextStyle(fontFamily: 'Montserrat'),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: showOptions,
              icon: Icon(Icons.more_vert),
            )
          ],
          leading: IconButton(
            onPressed: () => Navigator.pop(context, true),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: page(),
        bottomNavigationBar: MaterialButton(
          height: 50,
          onPressed: () => onChoosePaymentMethodClicked(),
          color: ThemeColorsUtil.accentColor,
          child: gettingCurrentPosition
              ? CircularProgressIndicator(backgroundColor: Colors.black)
              : Text(
                  'Escolher forma de pagamento',
                  style: TextStyle(
                      fontFamily: 'Montserrat', fontWeight: FontWeight.w600),
                ),
        ),
      ),
    );
  }

  Future onChoosePaymentMethodClicked() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              'Atenção',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Seu dispositivo está em um endereço diferente do selecionado, deseja continuar com o pedido?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black.withAlpha(200)),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () => Navigator.pop(context, true),
                  height: 50,
                  minWidth: 150,
                  color: ThemeColorsUtil.accentColor,
                  child: Text(
                    'Não',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                ),
                MaterialButton(
                  height: 50,
                  minWidth: 150,
                  onPressed: () => {},
                  color: ThemeColorsUtil.accentColor,
                  child: Text(
                    'Sim',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        );
      },
    );
  }

  Widget page() {
    ShoppingCart cart = GlobalInformation.shoppingCart;

    //Não tem items no carrinho
    if (!cart.hasItems) {
      return Center(
        child: Text(
          'Nenhum item no carrinho',
          style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
        ),
      );
    }

    double total;

    total = cart.totalPrice.toDouble() - cart.discount;

    return Padding(
      padding: EdgeInsets.only(top: 16, left: 24, right: 24, bottom: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data do pedido',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 16,
              ),
            ),
            SizedBox(height: 15),
            Card(
              child: GestureDetector(
                onTap: mustBeScheduled
                    ? null
                    : () {
                        setState(() {
                          isScheduled = false;
                          GlobalInformation.shoppingCart.orderDate = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            DateTime.now().hour,
                            DateTime.now().minute,
                          );
                        });
                      },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: !isScheduled
                            ? ThemeColorsUtil.accentColor
                            : Colors.grey[300],
                        width: !isScheduled ? 1 : 0),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: mustBeScheduled
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Loja fechada, agende seu pedido",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Para agora",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${DateFormat().addPattern('dd/MM/yyyy HH:mm').format(DateTime.now())}",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.grey,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "60 min",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(width: 5),
                                buildCircleSeparator(),
                                SizedBox(width: 5),
                                Text(
                                  "Entrega grátis",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ),
            Card(
              child: GestureDetector(
                onTap: () => selectScheduleDate(context),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isScheduled
                            ? ThemeColorsUtil.accentColor
                            : Colors.grey[300],
                        width: isScheduled ? 1 : 0),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Agendada",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      isScheduled
                          ? Text(
                              "${DateFormat().addPattern('dd/MM/yyyy HH:mm').format(selectedOrderDate)}",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.grey,
                              ),
                            )
                          : Text(
                              "Selecione para agendar",
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                color: Colors.grey,
                              ),
                            ),
                      Text(
                        "Entrega grátis",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Endereço de entrega',
              style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
            ),
            SizedBox(height: 10),
            Card(
              // elevation: 6,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: ListTile(
                  leading: Icon(
                    Icons.gps_fixed,
                    color: Colors.black,
                    size: 35,
                  ),
                  onTap: () async {},
                  title: Text('Endereço do dispositivo'),
                  subtitle: Text(
                      'Antes de prosseguir com a compra adicione um endereço para entrega'),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text('Seu pedido em',
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 16)),
            Text(
              '${cart.store.name}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Montserrat'),
            ),
            SizedBox(
              height: 30,
            ),
            Divider(),
            ListView(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: [
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cart.products.length,
                  itemBuilder: (context, index) {
                    //ItemOrder item = cart.products[index];

                    double val = cart.products[index].quantity.toDouble() *
                        cart.products[index].product.price.toDouble();
                    return Dismissible(
                      key: Key(index.toString()),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        final bool res = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "Deseja remover o item:  ${cart.products[index].product.name}?"),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text(
                                      "Cancelar",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  FlatButton(
                                    child: Text(
                                      "Remover",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        cart.removeOrder(index);
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                        return res;
                      },
                      onDismissed: (direction) {
                        // setState(() {});
                      },
                      background: Container(
                        color: Colors.red,
                        child: Align(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                "Remover ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.right,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          alignment: Alignment.centerRight,
                        ),
                      ),
                      child: Container(
                        height: 50,
                        alignment: Alignment.center,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Deslize para a esquerda para remover",
                              style: TextStyle(
                                color: Colors.grey[400],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${cart.products[index].quantity}x ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black.withAlpha(200),
                                  ),
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 220),
                                  child: Text(
                                    '${cart.products[index].product.name}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black.withAlpha(200),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "${NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(val)}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black.withAlpha(100),
                            fontFamily: 'Montserrat')),
                    Text('R\$ ${cart.totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16, color: Colors.black.withAlpha(100))),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat')),
                    Text('R\$ ${total.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              elevation: 6,
              child: ListTile(
                leading: Icon(
                  Icons.card_giftcard,
                  color: ThemeColorsUtil.accentColor,
                  size: 35,
                ),
                onTap: () {},
                title: Text('Cupom'),
                subtitle: Text('Selecione um cupom disponível'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future selectScheduleDate(BuildContext context) async {
    DateTime aux;

    await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 50)),
    ).then((value) => aux = value);

    if (aux != null) {
      await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      ).then(
        (value) => aux = DateTime(
          aux.year,
          aux.month,
          aux.day,
          value.hour,
          value.minute,
        ),
      );

      isScheduled = true;
      selectedOrderDate = aux;
      GlobalInformation.shoppingCart.orderDate = aux;
    }
    setState(() {});
  }

  Widget buildCircleSeparator() {
    return Text("●", style: TextStyle(color: Colors.grey));
  }

  void removeCoupon() {
    setState(() {
      GlobalInformation.shoppingCart.removeCoupon();
    });
  }

  void choiceAction(String choice) {}

  void showOptions() {
    if (!GlobalInformation.shoppingCart.hasItems) {
      Flushbar(
        message: "Não há itens para remover do carrinho",
        icon: Icon(
          Icons.error_outline,
          size: 28.0,
          color: Colors.red[300],
        ),
        duration: Duration(seconds: 2),
        leftBarIndicatorColor: Colors.red[300],
      )..show(context);
      return;
    }

    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                'Carrinho',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Montserrat'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Deseja esvaziar o carrinho ?',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    color: Colors.black.withAlpha(200)),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () => Navigator.pop(context, true),
                    height: 50,
                    minWidth: 150,
                    color: ThemeColorsUtil.accentColor,
                    child: Text(
                      'Não',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  ),
                  MaterialButton(
                    height: 50,
                    minWidth: 150,
                    onPressed: () {
                      setState(() {
                        GlobalInformation.shoppingCart.clear();
                        Navigator.pop(context, true);
                      });
                    },
                    color: ThemeColorsUtil.accentColor,
                    child: Text(
                      'Sim',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              )
            ],
          );
        });
  }
}
