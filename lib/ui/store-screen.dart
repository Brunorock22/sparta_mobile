import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sparta_marketplace/core/common/global_information.dart';
import 'package:sparta_marketplace/core/model/accepted-credit-brands.dart';
import 'package:sparta_marketplace/core/model/accepted-debit-brands.dart';
import 'package:sparta_marketplace/core/model/offer.dart';
import 'package:sparta_marketplace/core/model/product.dart';
import 'package:sparta_marketplace/core/model/store-payment.dart';
import 'package:sparta_marketplace/core/model/store.dart';
import 'package:sparta_marketplace/core/util/theme_colors.dart';
import 'package:sparta_marketplace/ui/store_product_screen.dart';
import 'package:sparta_marketplace/ui/widgets/grid_item.dart';
import 'package:sparta_marketplace/ui/widgets/shopping_cart_tray.dart';


class StoreScreen extends StatefulWidget {
  Store store;

  StoreScreen(this.store);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  ScrollController scrollController = ScrollController();
  bool isLoading = true;
  bool isWithinDistance = true;
  bool searchFieldLogoMustAppear = false;
  Color effectColor;
  int offerPage = 0;
  bool canLoad = true;
  List<List<int>> amount = List<List<int>>();
  List<int> subAmount = List<int>();
  StorePayment storePayment = StorePayment();
  List<Offer> offers = List<Offer>();

  void initState() {
    super.initState();
    load();

    effectColor = ThemeColorsUtil.accentColor;
    scrollController.addListener(() {
      if (scrollController.offset > 75) {
        effectColor = Colors.white;
        searchFieldLogoMustAppear = true;
        setState(() {});
      } else {
        searchFieldLogoMustAppear = false;
        effectColor = ThemeColorsUtil.accentColor;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: NestedScrollView(
          controller: scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [buildAppBar()];
          },
          body: isLoading ? buildLoadingContent() : buildLoadedContent(context),
        ),
      ),
      bottomNavigationBar: GlobalInformation.shoppingCart != null
              ? GlobalInformation.shoppingCart.hasItems
                  ? GestureDetector(
                      onTap: () async {
                        // final Route route = MaterialPageRoute(builder: (context) => ShoppingCartScreen());
                        //
                        // ///Reload na tela depois de ser alterado
                        // final result = await Navigator.push(context, route);
                        // try {
                        //   if (result != null) {
                        //     load();
                        //   }
                        // } catch (e) {
                        //   print(e.toString());
                        // }
                      },
                      child: ShoppingCartTray(),
                    )
                  : SizedBox()
              : SizedBox(),
    );
  }

  Future load([String storeId]) async {
    isLoading = true;
    setState(() {});
    isLoading = false;
    setState(() {});
  }

  Widget buildAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      brightness: Brightness.dark,
      backgroundColor: ThemeColorsUtil.accentColor,
      expandedHeight: 200,
      collapsedHeight: 90,
      pinned: true,
      bottom: buildPreferredSizeAppBar(),
      flexibleSpace: buildFlexibleSpaceBar(),
    );
  }

  Widget buildPreferredSizeAppBar() {
    return PreferredSize(
      preferredSize: Size.zero,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: GestureDetector(
          onTap: () async {
            // final Route route = MaterialPageRoute(builder: (context) => SearchScreen());
            //
            // ///Reload na tela depois de ser alterado
            // final result = await Navigator.push(context, route);
            // try {
            //   if (result != null) {
            //     load();
            //   }
            // } catch (e) {
            //   print(e.toString());
            // }
          },
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: IgnorePointer(
                    child: buildSearchField(),
                  ),
                ),
              ),
              searchFieldLogoMustAppear
                  ? Row(
                      children: [
                        SizedBox(width: 5),
                        Image.asset("assets/images/logo_helmet.png", height: 40),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchField() {
    return TextField(
      //   controller: questionField,
      expands: false,
      readOnly: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.black),
        hintText: "Procurar por produtos",
        hintStyle: TextStyle(fontFamily: 'Montserrat', fontSize: 15),
        fillColor: Colors.grey[100],
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }

  Widget buildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
      background: Container(
        color: ThemeColorsUtil.accentColor,
        child: Stack(
          children: [
            Column(
              children: [
                buildTopSliverAppBar(),
                buildBottomSliverAppBar(),
              ],
            ),
            buildLogoSliverAppBar(),
          ],
        ),
      ),
    );
  }

  Widget buildTopSliverAppBar() {
    return Container(
      height: 100,
      color: Colors.black,
      child: Align(
        alignment: Alignment.bottomRight,
        child: buildNameRow(),
      ),
    );
  }

  Widget buildNameRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Olá, ",
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Bruno Camargos",
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBottomSliverAppBar() {
    return Container(
      height: 100,
      color: ThemeColorsUtil.accentColor,
      child: Align(
        alignment: Alignment.topRight,
        child: buildLocationRow(),
      ),
    );
  }

  Widget buildLocationRow() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(Icons.location_on),
          GestureDetector(
            onTap: () async {
              // final Route route = MaterialPageRoute(builder: (context) => DeliveryAddressScreen());
              //
              // ///Reload na tela depois de ser alterado
              // final result = await Navigator.push(context, route);
              // try {
              //   if (result != null) {
              //     load();
              //   }
              // } catch (e) {
              //   print(e.toString());
              // }
            },
            child: Text(
              'Divinopolis - MG',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }

  Widget buildLogoSliverAppBar() {
    return Positioned(
      left: 0,
      bottom: 80,
      top: 50,
      child: Container(
        child: Image.asset(
          "assets/images/logo_helmet.png",
          height: 100,
        ),
      ),
    );
  }

  Widget buildLoadingContent() {
    return Center(
      child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(ThemeColorsUtil.primaryColor)),
    );
  }

  Widget buildLoadedContent(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildFirstContent(context),
    SliverToBoxAdapter(child:    Container(
      height: 350,
      child: GridView.count(
        padding: EdgeInsets.all(8),
        shrinkWrap: true,
        crossAxisCount: 3,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        physics: ScrollPhysics(),
        children: buildList(context),
      ),
    ),)


      ],
    );
  }

  Widget buildFirstContent(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: effectColor,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: buildStoreHeader(),
        ),
      ),
    );
  }

  Widget buildReturnButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context, true),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context, true),
          ),
          Text(
            "Voltar",
            style: TextStyle(fontFamily: 'Montserrat', color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildStoreHeader() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      height: 350,
      width: double.infinity,
      child: Stack(
        children: [

          buildStoreBannerImage(),

          buildStoreBannerShadow(),

          buildStoreHeaderText(),


        ],
      ),
    );
  }

  Widget buildStoreBannerImage() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        image: DecorationImage(
          image: NetworkImage(widget.store.logoUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildStoreBannerShadow() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        gradient: LinearGradient(
          stops: [0.7, 1],
          colors: [Colors.black54, Colors.black54],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
    );
  }

  Widget buildStoreHeaderText() {
    return Container(
      padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildReturnButton(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildStoreName(),
              SizedBox(height: 5),
              buildStoreRate(),
              SizedBox(height: 2),
              Row(
                children: [
                  buildStoreDeliveryTime(),
                  SizedBox(width: 5),
                  buildCircleSeparator(),
                  SizedBox(width: 5),
                  buildStoreDistance(),
                  SizedBox(width: 5),
                  buildCircleSeparator(),
                  SizedBox(width: 5),
                  buildStoreDeliveryFee(),

                ],
              ),
              SizedBox(height: 10),
              Row(children: [buildStoreSddress()]),
              SizedBox(height: 5),
              Row(children: [buildStoreCnpj()]),
              SizedBox(height: 10),
              buildPaymentOnDeliveryTitle(),
              SizedBox(height: 5),
              // buildAcceptMoney(),
              SizedBox(height: 5),

            ],
          ),
        ],
      ),
    );
  }



  Widget buildPaymentOnDeliveryTitle() {
    return Text(
      "Pagamento na entrega",
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget buildDebitBrandsTitle() {
    return Text(
      "Cartões de débito",
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }


  Widget buildStoreName() {
    return Text(
      widget.store.name,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 25,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildStoreRate() {

      return Text("Novo!", style: TextStyle(fontFamily: 'Montserrat', color: ThemeColorsUtil.primaryColor));

  }

  Widget buildStoreDistance() {
    return Text(
      "15 KM",
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat',
      ),
    );
  }

  Widget buildStoreDeliveryTime() {
    return Text("60 min", style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'));
  }

  Widget buildCircleSeparator() {
    return Text("●", style: TextStyle(color: Colors.white));
  }

  Widget buildStoreDeliveryFee() {

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          "ENTREGA GRÁTIS",
          style: TextStyle(color: Colors.white),
        ),
      );

  }

  Widget buildStoreSddress() {
    return Text(
      "Divinopolis - MG",
      style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
    );
  }

  Widget buildStoreCnpj() {
    return Text(
      "CNPJ: 123456897465",
      style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
    );
  }




  List<Widget> buildList(BuildContext context) {
    List<Widget> items = [];

    for (var i = 0; i < widget.store.products.length; i++) {
      items.add(GridItem(
          CachedNetworkImage(
            imageUrl: widget.store.products[i].imgUrl,
            imageBuilder: (context, imageProvider) => Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
          ),
          widget.store.products[i].name, () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    StoreProductScreen(widget.store , widget.store.products[i])));
      }));
    }
    return items;
  }

}
