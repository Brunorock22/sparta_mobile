import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sparta_marketplace/core/common/global_information.dart';
import 'package:sparta_marketplace/core/model/accepted-credit-brands.dart';
import 'package:sparta_marketplace/core/model/accepted-debit-brands.dart';
import 'package:sparta_marketplace/core/model/category.dart';
import 'package:sparta_marketplace/core/model/offer.dart';
import 'package:sparta_marketplace/core/model/store-payment.dart';
import 'package:sparta_marketplace/core/util/theme_colors.dart';

import 'widgets/shopping_cart_tray.dart';

class StoreScreen extends StatefulWidget {
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
  List<Category> categories = List();

  void initState() {
    super.initState();
    categories.add(Category(name: "Puro Malte", iconUrl: "https://extra.globo.com/noticias/economia/21639530-7a8-27d/w976h550-PROP/brahma.jpg"));
    categories.add(Category(name: "Padrao", iconUrl: "https://extra.globo.com/noticias/economia/21639530-7a8-27d/w976h550-PROP/brahma.jpg"));
    categories.add(Category(name: "Meio Malte", iconUrl: "https://extra.globo.com/noticias/economia/21639530-7a8-27d/w976h550-PROP/brahma.jpg"));
    load();

    effectColor = Color(0xfff4e316);
    scrollController.addListener(() {
      if (scrollController.offset > 75) {
        effectColor = Colors.white;
        searchFieldLogoMustAppear = true;
        setState(() {});
      } else {
        searchFieldLogoMustAppear = false;
        effectColor = Color(0xfff4e316);
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
    //
    // StoreService service = StoreService();
    // await service.getRateCount();
    // GlobalInformation.isWithinRadius = await service.isNearby();
    // storePayment = await service.getStorePaymentMethods();
    // offers = List<Offer>();
    // GlobalInformation.category = List<Category>();
    // GlobalInformation.productsByCategory = Map<String, List<Product>>();
    // offers = await service.getOffers(GlobalInformation.store.id);
    // GlobalInformation.category = await service.getCategories();
    //
    // for (int i = 0; i < GlobalInformation.category.length; i++) {
    //   //   List<Product> products = await service.getStores2(GlobalInformation.currentPosition, categoryID: GlobalInformation.category[i].id, onlyProducts: true);
    //   print("Store id: ${GlobalInformation.store.id}");
    //   print("Category id: ${GlobalInformation.category[i].id}");
    //   List<Product> products = await service.getProducts(GlobalInformation.store, categoryID: GlobalInformation.category[i].id);
    //   if (products.length != 0) {
    //     GlobalInformation.productsByCategory.putIfAbsent(GlobalInformation.category[i].name, () => products);
    //     print("Length: ${GlobalInformation.productsByCategory.length}");
    //
    //     if (GlobalInformation.productsByCategory[GlobalInformation.category[i].name].length < 5) {
    //       //   GlobalInformation.productsByCategory[GlobalInformation.category[i].name] = GlobalInformation.productsByCategory[GlobalInformation.category[i].name].sublist(0, GlobalInformation.productsByCategory[GlobalInformation.category[i].name].length);
    //     } else {
    //       //   GlobalInformation.productsByCategory[GlobalInformation.category[i].name] = GlobalInformation.productsByCategory[GlobalInformation.category[i].name].sublist(0, 5);
    //     }
    //   }
    // }
    //
    // amount = List<List<int>>(GlobalInformation.productsByCategory.length);
    //
    // for (int i = 0; i < GlobalInformation.productsByCategory.length; i++) {
    //   subAmount = List.filled(GlobalInformation.productsByCategory[GlobalInformation.productsByCategory.keys.elementAt(i)].length, 1);
    //   amount[i] = subAmount;
    // }

    isLoading = false;
    setState(() {});
  }

  Widget buildAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      brightness: Brightness.dark,
      backgroundColor: Color(0xfff4e316),
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
                        Image.asset("assets/images/logo2.png", height: 40),
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
        color: Color(0xfff4e316),
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
      color: Color(0xfff4e316),
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
          "assets/images/logo2.png",
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
        // SliverToBoxAdapter(
        //   child: buildStoreHeader(),
        // ),
        buildOffers(context),
        SliverToBoxAdapter(child: Divider(thickness: 10)),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Text(
              "O que a diretoria oferta",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        buildCategories(),
        SliverToBoxAdapter(child: Divider(thickness: 10)),
        buildListOfProductsByCategory(),
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
          image: NetworkImage("https://extra.globo.com/noticias/economia/21639530-7a8-27d/w976h550-PROP/brahma.jpg"),
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
              buildAcceptMoney(),
              SizedBox(height: 5),
              buildDebitBrands(),
              SizedBox(height: 5),
              buildCreditBrands(),
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

  Widget buildAcceptMoney() {
    if (storePayment.acceptMoney != null && storePayment.acceptMoney) {
      return Row(
        children: [
          Icon(Icons.monetization_on, size: 20, color: Colors.green),
          SizedBox(width: 5),
          Text(
            "Dinheiro",
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.white,
            ),
          ),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget buildDebitBrands() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDebitBrandsTitle(),
          SizedBox(height: 5),
          buildListOfDebitBrands(),
        ],
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

  Widget buildListOfDebitBrands() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
        childAspectRatio: 7,
      ),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: storePayment.acceptedDebitBrands.length,
      itemBuilder: (context, index) {
        AcceptedDebitBrands brand = storePayment.acceptedDebitBrands[index];
        return buildDebitBrand(brand);
      },
    );
  }

  Widget buildDebitBrand(AcceptedDebitBrands brand) {
    return Row(
      children: [
        Icon(Icons.credit_card, size: 20, color: Colors.white),
        SizedBox(width: 5),
        Text(
          brand.brandName,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildCreditBrands() {
    if (storePayment.acceptCreditCard && storePayment.acceptedCreditBrands.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCreditBrandsTitle(),
          SizedBox(height: 5),
          buildListOfCreditBrands(),
        ],
      );
    } else {
      return SizedBox();
    }
  }

  Widget buildCreditBrandsTitle() {
    return Text(
      "Cartões de crédito",
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget buildListOfCreditBrands() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150, childAspectRatio: 7),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: storePayment.acceptedCreditBrands.length,
      itemBuilder: (context, index) {
        AcceptedCreditBrands brand = storePayment.acceptedCreditBrands[index];
        return buildCreditBrand(brand);
      },
    );
  }

  Widget buildCreditBrand(AcceptedCreditBrands brand) {
    return Row(
      children: [
        Icon(Icons.credit_card_rounded, size: 20, color: Colors.white),
        SizedBox(width: 5),
        Text(
          brand.brandName,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildStoreName() {
    return Text(
      "Distribuidora Brahmah",
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

  Widget buildOffers(BuildContext context) {
    if (offers.length > 0) {
      return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Se liga aqui!",
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              height: MediaQuery.of(context).size.width / 1.68,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  buildOffersCarouselRRect(),
                  buildCarouselIndicatorContainer(),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return SliverToBoxAdapter(child: SizedBox());
    }
  }

  Widget buildOffersCarouselRRect() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: buildOffersCarousel(),
    );
  }

  Widget buildOffersCarousel() {
    return CarouselSlider(
      options: loadCarouselOptions(),
      items: offers.map(
        (Offer offer) {
          return buildOfferBanner(offer);
        },
      ).toList(),
    );
  }

  CarouselOptions loadCarouselOptions() {
    return CarouselOptions(
      autoPlay: offers.length == 1 ? false : true,
      autoPlayInterval: Duration(seconds: 5),
      autoPlayCurve: Curves.fastOutSlowIn,
      enableInfiniteScroll: offers.length == 1 ? false : true,
      enlargeCenterPage: false,
      onPageChanged: (index, reason) => onOfferPageChanged(index),
      height: double.infinity,
      viewportFraction: 1,
    );
  }

  Future onOfferPageChanged(int index) async {
    offerPage = index;
    setState(() {});
  }

  Widget buildOfferBanner(Offer offer) {
    return GestureDetector(
      onTap: () async {
        // GlobalInformation.selectedOffer = offer;
        // final Route route = MaterialPageRoute(builder: (context) => MainOfferScreen());
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
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageUrl: "https://s2.glbimg.com/DJsLIxXvDj83PP-HSyag4cOuryY=/620x350/e.glbimg.com/og/ed/f/original/2017/08/16/smartfit.jpg",
        ),
      ),
    );
  }

  Widget buildCarouselIndicatorContainer() {
    return Container(
      alignment: Alignment.bottomCenter,
      height: double.infinity,
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: buildCarouselIndicator(),
      ),
    );
  }

  Widget buildCarouselIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: offerPage,
      count: offers.length,
      effect: WormEffect(
        activeDotColor: ThemeColorsUtil.primaryColor,
      ),
    );
  }

  Widget buildCategories() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4,
        // crossAxisSpacing: 10,
        // mainAxisSpacing: 10,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          final Category category = categories[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: Row(
              children: [
                index.isEven ? SizedBox(width: 10) : SizedBox(),
                Expanded(child: buildCategoryItem(category)),
                index.isOdd ? SizedBox(width: 10) : SizedBox(),
              ],
            ),
          );
        },
        childCount: categories.length,
      ),
    );
  }

  Widget buildCategoryItem(Category category) {
    return GestureDetector(
      onTap: () async {
        // categories = -1;
        // for (int i = 0; i < GlobalInformation.productsByCategory.length; i++) {
        //   if (category.name == GlobalInformation.productsByCategory.keys.elementAt(i)) {
        //     GlobalInformation.categoryIndex = i;
        //   }
        // }
        //
        // GlobalInformation.selectedCategory = category;
        //
        // if (GlobalInformation.categoryIndex == -1) {
        //   Flushbar(
        //     title: GlobalInformation.store.displayName,
        //     message: "Não temos produtos desta categoria ;(",
        //     duration: Duration(seconds: 3),
        //   ).show(context);
        // } else {
        //   final Route route = MaterialPageRoute(builder: (context) => MainCategoryScreen());
        //
        //   ///Reload na tela depois de ser alterado
        //   final result = await Navigator.push(context, route);
        //   try {
        //     if (result != null) {
        //       load();
        //     }
        //   } catch (e) {
        //     print(e.toString());
        //   }
        // }
      },
      child: buildCategoryContainer(category),
    );
  }

  Widget buildCategoryContainer(Category category) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[400]),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: buildCategoryContent(category),
    );
  }

  Widget buildCategoryContent(Category category) {
    return Row(
      children: [
        CachedNetworkImage(
          height: 30,
          color: ThemeColorsUtil.primaryColor,
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageUrl: category.iconUrl,
        ),
        SizedBox(width: 5),
        Text(
          "${category.name}",
          style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildListOfProductsByCategory() {
    return SliverToBoxAdapter(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, i) {
          return buildCategory(i);
        },
      ),
    );
  }

  Widget buildCategory(int categoryIndex) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCategoryTitle(categories[categoryIndex].name),
          SizedBox(height: 15),
          //buildCategoryProducts(categoryIndex),
          Divider(thickness: 10),
        ],
      ),
    );
  }

  Widget buildCategoryTitle(String category) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        category,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Widget buildCategoryProducts(int categoryIndex) {
  //   return Container(
  //     height: 270,
  //     child: ListView.builder(
  //       padding: EdgeInsets.zero,
  //       shrinkWrap: true,
  //       scrollDirection: Axis.horizontal,
  //       // itemCount: 5,
  //       itemCount: GlobalInformation.productsByCategory[GlobalInformation.productsByCategory.keys.elementAt(categoryIndex)].length < 5 ? GlobalInformation.productsByCategory[GlobalInformation.productsByCategory.keys.elementAt(categoryIndex)].length : 5,
  //       itemBuilder: (context, j) {
  //         final Product product = GlobalInformation.productsByCategory[GlobalInformation.productsByCategory.keys.elementAt(categoryIndex)][j];
  //
  //         if (isLastProduct(categoryIndex, j)) {
  //           return buildProductContainerFollowedByButton(categoryIndex, j, product);
  //         } else {
  //           return buildProductContainer(categoryIndex, j, product);
  //         }
  //       },
  //     ),
  //   );
  // }

  bool isLastProduct(int categoryIndex, int productIndex) {
    if (productIndex == 4) {
      print("Product Inde: $productIndex");
      return true;
    } else {
      return false;
    }
  }
  //
  // Widget buildProductContainerFollowedByButton(int categoryIndex, int productIndex, Product product) {
  //   return Row(
  //     children: [
  //       buildProductContainer(categoryIndex, productIndex, product),
  //       buildMoreButton(product, categoryIndex),
  //       SizedBox(width: 15),
  //     ],
  //   );
  // }
  //
  // Widget buildProductContainer(int categoryIndex, int productIndex, Product product) {
  //   return Container(
  //     height: double.infinity,
  //     width: 150,
  //     margin: const EdgeInsets.only(bottom: 15, right: 15, left: 15, top: 10),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(15),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey[200],
  //           blurRadius: 10,
  //           spreadRadius: 2,
  //         ),
  //       ],
  //     ),
  //     child: buildProductContainerContent(categoryIndex, productIndex, product),
  //   );
  // }

  // Widget buildProductContainerContent(int categoryIndex, int productIndex, Product product) {
  //   return Column(
  //     children: [
  //       GestureDetector(
  //         //onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => StoreProductScreen(product.store, product))),
  //         child: Container(
  //           margin: const EdgeInsets.all(15),
  //           child: CachedNetworkImage(
  //             height: 100,
  //             placeholder: (context, url) => CircularProgressIndicator(),
  //             errorWidget: (context, url, error) => Icon(Icons.error),
  //             imageUrl: product.image,
  //           ),
  //           // child: Image.network(product.image, height: 100),
  //         ),
  //       ),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         margin: const EdgeInsets.symmetric(horizontal: 10),
  //         child: Text(
  //           "${product.name}",
  //           style: TextStyle(fontFamily: 'Montserrat'),
  //         ),
  //       ),
  //       Spacer(),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //         child: buildProductPrice(product),
  //       ),
  //       Container(
  //         alignment: Alignment.centerLeft,
  //         margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  //         child: Row(
  //           children: [
  //             buildMinusIconButton(categoryIndex, productIndex),
  //             SizedBox(width: 10),
  //             buildAmount(categoryIndex, productIndex),
  //             SizedBox(width: 10),
  //             buildPlusIconButton(categoryIndex, productIndex),
  //             SizedBox(width: 10),
  //             buildCartIconButton(categoryIndex, productIndex, product),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget buildProductPrice(Product product) {
  //   if (product.currentOffer != null && product.currentGeneralOffer != null) {
  //     if (product.currentOffer.individualDiscountPercentage > product.currentGeneralOffer.individualDiscountPercentage) {
  //       return buildCurrentOfferPrice(product);
  //     } else {
  //       return buildCurrentGeneralOfferPrice(product);
  //     }
  //   } else {
  //     if (product.currentOffer != null) {
  //       return buildCurrentOfferPrice(product);
  //     }
  //
  //     if (product.currentGeneralOffer != null) {
  //       return buildCurrentGeneralOfferPrice(product);
  //     }
  //
  //     return buildCurrentPrice(product);
  //   }
  // }
  //
  // Widget buildCurrentOfferPrice(Product product) {
  //   return Row(
  //     children: [
  //       Text(
  //         "R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(product.price)}",
  //         style: TextStyle(
  //           fontFamily: 'Montserrat',
  //           fontWeight: FontWeight.bold,
  //           decoration: TextDecoration.lineThrough,
  //           fontSize: 12,
  //         ),
  //       ),
  //       SizedBox(width: 10),
  //       Text(
  //         "R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(product.price - (product.price * (product.currentOffer.individualDiscountPercentage / 100)))}",
  //         style: TextStyle(
  //           fontFamily: 'Montserrat',
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget buildCurrentGeneralOfferPrice(Product product) {
  //   return Row(
  //     children: [
  //       Text(
  //         "R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(product.price)}",
  //         style: TextStyle(
  //           fontFamily: 'Montserrat',
  //           fontWeight: FontWeight.bold,
  //           decoration: TextDecoration.lineThrough,
  //           fontSize: 12,
  //         ),
  //       ),
  //       SizedBox(width: 10),
  //       Text(
  //         "R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(product.price - (product.price * (product.currentGeneralOffer.individualDiscountPercentage / 100)))}",
  //         style: TextStyle(
  //           fontFamily: 'Montserrat',
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ],
  //   );
  // }
  //
  // Widget buildCurrentPrice(Product product) {
  //   return Text(
  //     "R\$ ${NumberFormat.currency(locale: 'pt_BR', symbol: '').format(product.price)}",
  //     style: TextStyle(
  //       fontFamily: 'Montserrat',
  //       fontWeight: FontWeight.bold,
  //     ),
  //   );
  // }
  //
  // Widget buildMinusIconButton(int categoryIndex, int productIndex) {
  //   return ClipOval(
  //     child: Container(
  //       height: 30,
  //       width: 30,
  //       color: Colors.grey[200],
  //       child: IconButton(
  //         iconSize: 15,
  //         onPressed: () => onMinusClicked(categoryIndex, productIndex),
  //         icon: Icon(Icons.remove),
  //       ),
  //     ),
  //   );
  // }
  //
  // void onMinusClicked(int categoryIndex, int productIndex) {
  //   if (amount[categoryIndex][productIndex] > 1) {
  //     amount[categoryIndex][productIndex] = amount[categoryIndex][productIndex] - 1;
  //     print("amount: ${amount[categoryIndex][productIndex]}");
  //     setState(() {});
  //   }
  // }
  //
  // Widget buildAmount(int categoryIndex, int productIndex) {
  //   return Text(
  //     amount[categoryIndex][productIndex].toString(),
  //     style: TextStyle(
  //       fontFamily: 'Montserrat',
  //       fontWeight: FontWeight.bold,
  //     ),
  //   );
  // }
  //
  // Widget buildPlusIconButton(int categoryIndex, int productIndex) {
  //   return ClipOval(
  //     child: Container(
  //       height: 30,
  //       width: 30,
  //       color: Colors.grey[200],
  //       child: IconButton(
  //         iconSize: 15,
  //         onPressed: () => onPlusClicked(categoryIndex, productIndex),
  //         icon: Icon(Icons.add),
  //       ),
  //     ),
  //   );
  // }
  //
  // void onPlusClicked(int categoryIndex, int productIndex) {
  //   amount[categoryIndex][productIndex] = amount[categoryIndex][productIndex] + 1;
  //   print("amount: ${amount[categoryIndex][productIndex]}");
  //   setState(() {});
  // }
  //
  // Widget buildCartIconButton(int categoryIndex, int productIndex, Product product) {
  //   return ClipOval(
  //     child: Container(
  //       height: 30,
  //       width: 30,
  //       color: ThemeColorsUtil.primaryColor,
  //       child: IconButton(
  //         iconSize: 15,
  //         onPressed: () => onCartClicked(categoryIndex, productIndex, product),
  //         icon: Icon(Icons.add_shopping_cart, color: Colors.black),
  //       ),
  //     ),
  //   );
  // }
  //
  // void onCartClicked(int categoryIndex, int productIndex, Product product) {
  //   if (GlobalInformation.isWithinRadius) {
  //     ItemOrder item = loadItemOrder(categoryIndex, productIndex, product);
  //
  //     GlobalInformation.shoppingCart.addOrder(item);
  //   } else {
  //     Flushbar(
  //       messageText: Text(
  //         "Loja não entrega na sua região",
  //         style: TextStyle(
  //           fontFamily: 'Montserrat',
  //           fontSize: 15,
  //           color: Colors.white,
  //         ),
  //       ),
  //       flushbarPosition: FlushbarPosition.TOP,
  //       flushbarStyle: FlushbarStyle.GROUNDED,
  //       duration: Duration(seconds: 3),
  //       backgroundColor: Colors.redAccent,
  //     ).show(context);
  //   }
  //
  //   setState(() {});
  // }
  //
  // ItemOrder loadItemOrder(int categoryIndex, int productIndex, Product product) {
  //   if (product.currentOffer != null && product.currentGeneralOffer != null) {
  //     if (product.currentOffer.individualDiscountPercentage > product.currentGeneralOffer.individualDiscountPercentage) {
  //       return ItemOrder(amount[categoryIndex][productIndex], GlobalInformation.store, Product(offerId: product.currentOffer.offerId, price: product.price - (product.price * (product.currentOffer.individualDiscountPercentage / 100)), id: product.id, name: product.name));
  //     } else {
  //       return ItemOrder(amount[categoryIndex][productIndex], GlobalInformation.store, Product(offerId: product.currentGeneralOffer.offerId, price: product.price - (product.price * (product.currentGeneralOffer.individualDiscountPercentage / 100)), id: product.id, name: product.name));
  //     }
  //   } else {
  //     if (product.currentOffer != null) {
  //       return ItemOrder(amount[categoryIndex][productIndex], GlobalInformation.store, Product(offerId: product.currentOffer.offerId, price: product.price - (product.price * (product.currentOffer.individualDiscountPercentage / 100)), id: product.id, name: product.name));
  //     }
  //
  //     if (product.currentGeneralOffer != null) {
  //       return ItemOrder(amount[categoryIndex][productIndex], GlobalInformation.store, Product(offerId: product.currentGeneralOffer.offerId, price: product.price - (product.price * (product.currentGeneralOffer.individualDiscountPercentage / 100)), id: product.id, name: product.name));
  //     }
  //
  //     return ItemOrder(amount[categoryIndex][productIndex], GlobalInformation.store, product);
  //   }
  // }
  //
  // Widget buildMoreButton(Product product, int categoryIndex) {
  //   return Container(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         ClipOval(
  //           child: Container(
  //             color: ThemeColorsUtil.primaryColor,
  //             child: IconButton(
  //               onPressed: () async {
  //                 //   GlobalInformation.category = category[categoryIndex];
  //
  //                 for (int i = 0; i < GlobalInformation.category.length; i++) {
  //                   if (GlobalInformation.productsByCategory.keys.elementAt(categoryIndex) == GlobalInformation.category[i].name) {
  //                     GlobalInformation.selectedCategory = GlobalInformation.category[i];
  //                   }
  //                 }
  //
  //                 GlobalInformation.categoryIndex = categoryIndex;
  //                 final Route route = MaterialPageRoute(builder: (context) => MainCategoryScreen());
  //
  //                 ///Reload na tela depois de ser alterado
  //                 final result = await Navigator.push(context, route);
  //                 try {
  //                   if (result != null) {
  //                     load();
  //                   }
  //                 } catch (e) {
  //                   print(e.toString());
  //                 }
  //               },
  //               icon: Icon(
  //                 Icons.add,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Text(
  //           "Ver mais",
  //           style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
