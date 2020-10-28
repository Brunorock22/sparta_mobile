import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sparta_marketplace/core/common/global_information.dart';
import 'package:sparta_marketplace/core/model/category.dart';
import 'package:sparta_marketplace/core/model/offer.dart';
import 'package:sparta_marketplace/core/model/store.dart';
import 'package:sparta_marketplace/core/util/theme_colors.dart';
import 'package:sparta_marketplace/ui/main_screen/widgets/shopping_cart_tray.dart';

import '../store-screen.dart';

class HomeScreenByStores extends StatefulWidget {
  @override
  _HomeScreenByStoresState createState() => _HomeScreenByStoresState();
}

class _HomeScreenByStoresState extends State<HomeScreenByStores> {
  ScrollController scrollController = ScrollController();
  bool isLoading = true;
  bool searchFieldLogoMustAppear = false;
  Color effectColor;
  int offerPage = 0;
  List<Store> stores = List<Store>();
  List<Offer> offers = List<Offer>();
  List<Category> categories = List();

  @override
  void initState() {
    super.initState();
    categories.add(Category(name: "Cerveja", icon: Icons.local_drink));
    categories
        .add(Category(name: "Cafe", icon: Icons.emoji_food_beverage_rounded));
    categories.add(Category(name: "Lanche", icon: Icons.fastfood_outlined));
    categories.add(Category(name: "Fitness", icon: Icons.fitness_center));

    offers.add(Offer());

    stores.add(Store(displayName: "Distribuidora Brahma ", logoUrl: "https://extra.globo.com/noticias/economia/21639530-7a8-27d/w976h550-PROP/brahma.jpg"));
    stores.add(Store(displayName: "Smart Fitness", logoUrl: "https://s2.glbimg.com/DJsLIxXvDj83PP-HSyag4cOuryY=/620x350/e.glbimg.com/og/ed/f/original/2017/08/16/smartfit.jpg"));
    stores.add(Store(displayName: "Java Café ", logoUrl: "https://1.bp.blogspot.com/-y5dyA_AlQg4/VXd2P_BiRhI/AAAAAAAABAw/TWNMtOEuhU4/s1600/cafe.jpg"));
    load();

    effectColor = ThemeColorsUtil.primaryColor;
    scrollController.addListener(() {
      if (scrollController.offset > 75) {
        effectColor = ThemeColorsUtil.textTitleColor;
        searchFieldLogoMustAppear = true;
        setState(() {});
      } else {
        searchFieldLogoMustAppear = false;
        effectColor = ThemeColorsUtil.primaryColor;
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
                    //     // load();
                    //     setState(() {});
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

  Future load() async {
    isLoading = true;
    setState(() {});
    // StoreService service = StoreService();
    // GlobalInformation.store = await service.getStore();
    // offers = List<Offer>();
    // GlobalInformation.category = List<Category>();
    // offers = await service.getGeneralOffers();
    // // offers = await service.getOffers(GlobalInformation.store.id);
    // GlobalInformation.category = await service.getCategories();
    // stores = await service.getStores(GlobalInformation.currentPosition);
    isLoading = false;
    setState(() {});
  }

  Widget buildAppBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      brightness: Brightness.dark,
      backgroundColor: ThemeColorsUtil.primaryColor,
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
                    child: Text(
                      "Seja Bem-Vindo a Sparta ",
                      style: TextStyle(
                        color: ThemeColorsUtil.textTitleColor,
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              searchFieldLogoMustAppear
                  ? Row(
                      children: [
                        SizedBox(width: 5),
                        Image.asset("assets/images/logo_helmet.png",
                            height: 40),
                      ],
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildFlexibleSpaceBar() {
    return FlexibleSpaceBar(
      background: Container(
        color: ThemeColorsUtil.primaryColor,
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
      color: ThemeColorsUtil.primaryColor,
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
              'Divinópolis - MG',
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
      child: CircularProgressIndicator(
          valueColor:
              AlwaysStoppedAnimation<Color>(ThemeColorsUtil.accentColor)),
    );
  }

  Widget buildLoadedContent(BuildContext context) {
    return CustomScrollView(
      slivers: [
        buildFirstContent(context),
        SliverToBoxAdapter(
            child: offers.length != 0 ? Divider(thickness: 10) : SizedBox()),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Pelo que está interessado?",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        buildCategories(),
        SliverToBoxAdapter(child: SizedBox(height: 15)),
        SliverToBoxAdapter(child: Divider(thickness: 10)),
        buildStores(),
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
          child: buildOffersContainer(context),
        ),
      ),
    );
  }

  Widget buildOffersContainer(BuildContext context) {
    if (offers.length > 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Text(
              "Se liga nas promo!",
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
      );
    } else {
      return SizedBox();
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
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 5),
      autoPlayCurve: Curves.fastOutSlowIn,
      enableInfiniteScroll: true,
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
        // final Route route = MaterialPageRoute(builder: (context) => MainOfferScreen(isGeneral: true));
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
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageUrl:
              "https://i.pinimg.com/736x/4c/ef/c9/4cefc9ca4879b56ff482fcf6a5a5b4f6.jpg",
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
    return isLoading
        ? SizedBox()
        : AnimatedSmoothIndicator(
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
        childCount: 4,
      ),
    );
  }

  Widget buildCategoryItem(Category category) {
    return GestureDetector(
      onTap: () async {
        // final Route route = MaterialPageRoute(builder: (context) => SearchScreen(category: category));
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
        Icon(category.icon),
        SizedBox(width: 5),
        Text(
          "${category.name}",
          style: TextStyle(
            color: ThemeColorsUtil.accentColor,
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget buildStores() {
    return SliverToBoxAdapter(
      child: stores != null && stores.length > 0
          ? ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(15),
              shrinkWrap: true,
              itemCount: stores.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                final Store store = stores[index];
                return buildStoresItem(index, store);
              },
            )
          : Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Text(
                'Não encontramos ninguém que possa te ajudar :(',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }

  Widget buildStoresItem(int index, Store store) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        index == 0
            ? Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: buildStoresTitle(),
              )
            : SizedBox(),
        buildStoreContainer(store),
      ],
    );
  }

  Widget buildStoresTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Text(
        "Parceiros da Sparta",
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildStoreContainer(Store store) {
    return GestureDetector(
      onTap: () => onClickedStore(store),
      child: Container(
        height: 100,

        child: Card(
          elevation: 2,
          child: Row(
            children: [
              buildStoreImage(store),
              SizedBox(width: 15),
              buildStoreContainerContent(store),
            ],
          ),
        ),
      ),
    );
  }

  Future onClickedStore(Store store) async {
    // GlobalInformation.store = store;
    Navigator.push(context, MaterialPageRoute(builder: (context) => StoreScreen()));
    // if (!GlobalInformation.isWithinRadius) {
    //   load();
    // }
    // setState(() {});
  }

  Widget buildStoreContainerContent(Store store) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            buildStoreName(store),
            SizedBox(height: 5),
            Row(
              children: [
                buildStoreRate(store),
                SizedBox(width: 5),
                buildCircleSeparator(),
                SizedBox(width: 5),
                buildStoreDistance(store),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Row(
              children: [
                buildStoreDeliveryTime(store),
                SizedBox(width: 5),
                buildCircleSeparator(),
                SizedBox(width: 5),
                buildStoreDeliveryFee(store),
              ],
            ),
            SizedBox(height: 5),
          ],
        ),
      ],
    );
  }

  Widget buildStoreImage(Store store) {
      return buildStoreOpenedImage(store);

  }

  Widget buildStoreOpenedImage(Store store) {
    return Image(
      image: NetworkImage(store.logoUrl),
      fit: BoxFit.cover,
    );
  }

  Widget buildStoreClosedStatusImage(Store store) {
    return Stack(
      children: [
        buildStoreClosedLogoImage(store),
        buildStoreClosedContainerShadow(),
        buildStoreClosedStatusText(),
      ],
    );
  }

  Widget buildStoreClosedLogoImage(Store store) {
    return Container(
      height: double.infinity,
      width: 98,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(store.logoUrl), fit: BoxFit.cover),
      ),
    );
  }

  Widget buildStoreClosedContainerShadow() {
    return Container(
      height: double.infinity,
      width: 98,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black87, Colors.transparent],
          stops: [0.5, 1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget buildStoreClosedStatusText() {
    return Container(
      width: 98,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(15),
      child: Text(
        "Fechado",
        style: TextStyle(fontFamily: 'Montserrat', color: Colors.grey[400]),
      ),
    );
  }

  Widget buildStoreName(Store store) {
    return Text("${store.displayName}",
        style: TextStyle(fontFamily: 'Montserrat', fontSize: 15));
  }

  Widget buildStoreRate(Store store) {
    if (store.rate != 0) {
      return Row(
        children: [
          Text("⭐"),
          SizedBox(width: 5),
          Text("5",
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  color: ThemeColorsUtil.primaryColor)),
        ],
      );
    } else {
      return Text("Novo!",
          style: TextStyle(
              fontFamily: 'Montserrat', color: ThemeColorsUtil.primaryColor));
    }
  }

  Widget buildStoreDistance(Store store) {
    return Text(
      "${15} km".replaceAll('.', ','),
      style: TextStyle(color: Colors.grey),
    );
  }

  Widget buildStoreDeliveryTime(Store store) {
    return Text("60 min",
        style: TextStyle(color: Colors.grey));
  }

  Widget buildCircleSeparator() {
    return Text("●", style: TextStyle(color: Colors.grey));
  }

  Widget buildStoreDeliveryFee(Store store) {
    if (store.deliveryFee != 0) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          "Entrega Gratis",
          style: TextStyle(color: Colors.grey),
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Text(
          "ENTREGA GRÁTIS",
          style: TextStyle(color: Colors.green),
        ),
      );
    }
  }
}
