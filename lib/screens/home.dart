
import 'package:flutter/material.dart';
import 'package:flutter_advanced_dev/bloc/products/products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc/cart/cart_cubit.dart';
import '../bloc/client/client_cubit.dart';
import '../core/localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String userName = '';
  late String userEmail = '';
  late ClientCubit clientCubit;
  late CartCubit cartCubit;
  TextEditingController ilKoduYoneticisi = TextEditingController(text: "34");

  @override
  void initState() {
    super.initState();
    clientCubit = context.read<ClientCubit>();
    cartCubit = context.read<CartCubit>();
    getUserInfo();
  }

  void getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? '';
      userEmail = prefs.getString('user_email') ?? '';
    });
  }

  Map<String, dynamic> states = {};


  @override
  Widget build(BuildContext context) {
    var products = [
      {
        "id": 1,
        "name": "MacBook Pro 2024 M3 Pro",
        "in-stock": false,
        "price": 0,
        "photo":
            "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/mba13-midnight-select-202402?wid=904&hei=840&fmt=jpeg&qlt=90&.v=1708367688034",
      },
      {
        "id": 2,
        "name": "iPhone 15 Pro Max",
        "in-stock": true,
        "price": 98999.00,
        "photo":
            "https://st-troy.mncdn.com/mnresize/1500/1500/Content/media/ProductImg/original/mu793tua-apple-iphone-15-pro-max-256gb-natural-titanium-638305576694571609.jpg",
      },
      {
        "id": 3,
        "name": "Asus Zenbook 14 OLED ",
        "in-stock": true,
        "price": 74500.00,
        "photo":
            "https://dlcdnwebimgs.asus.com/gain/838fbdac-6d10-4190-8e52-d4b9463f5d23/",
      },
      {
        "id": 4,
        "name": "Macbook Air 2024",
        "in-stock": true,
        "price": 29999.00,
        "photo":
            "https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/macbookair-og-202402?wid=600&hei=315&fmt=jpeg&qlt=95&.v=1707414684423",
      },
      {
        "id": 5,
        "name": "Samsung S23 Ultra",
        "in-stock": false,
        "price": 0,
        "photo":
            "https://images.samsung.com/tr/smartphones/galaxy-s23-ultra/compare/images/galaxy-s23-plus-compare-lavender-s.jpg",
      },
      {
        "id": 6,
        "name": "Xiaomi 13 Pro",
        "in-stock": true,
        "price": 32000.00,
        "photo":
            "https://cdn.vatanbilgisayar.com/Upload/PRODUCT/xiaomi/thumb/1-8_large.jpg",
      },
      {
        "id": 7,
        "name": "Huawei P60 Pro",
        "in-stock": true,
        "price": 52080.00,
        "photo":
            "https://img01.huaweifile.com/eu/tr/huawei/pms/uomcdn/TRHW/pms/202306/gbom/6941487291045/428_428_7B4C65CACE723AF0DAB3B603D419777Bmp.png",
      },
    ];
    return BlocBuilder<ClientCubit, ClientState>(
      builder: (context, state) {
        return Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: GestureDetector(
                    onTap: () => context.push("/profile"),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withAlpha(150),
                              width: 3,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const CircleAvatar(
                            maxRadius: 42,
                            child: Icon(
                              Icons.person,
                              size: 50,
                            ),
                          ),
                        ),
                        const Gap(20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.home,
                  ),
                  title: Text(
                    AppLocalizations.of(context).getTranslate("home"),
                  ),
                  selected: true,
                  onTap: () => context.push("/home"),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                  ),
                  title: Text(
                    AppLocalizations.of(context).getTranslate("settings"),
                  ),
                  onTap: () => context.push("/settings"),
                ),
                SwitchListTile(
                  value: clientCubit.state.darkMode,
                  onChanged: (value) {
                    clientCubit.changeDarkMode(darkMode: value);
                  },
                  secondary: clientCubit.state.darkMode
                      ? const Icon(Icons.sunny)
                      : const Icon(Icons.nightlight),
                  title: const Text('Night Mode'),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.align_horizontal_left_rounded),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            actions: [
              if (clientCubit.state.darkMode)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () {
                        clientCubit.changeDarkMode(darkMode: false);
                      },
                      icon: const Icon(Icons.sunny)),
                )
              else
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                      onPressed: () {
                        clientCubit.changeDarkMode(darkMode: true);
                      },
                      icon: const Icon(Icons.nightlight)),
                ),
              Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: IconButton(
                  onPressed: () {
                    if (clientCubit.state.language == "tr") {
                      clientCubit.changeLanguage(language: "en");
                    } else {
                      clientCubit.changeLanguage(language: "tr");
                    }
                  },
                  icon: const Icon(Icons.language),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: IconButton(
                  onPressed: () => GoRouter.of(context).push("/cart"),
                  icon: const Icon(Icons.shopping_cart),
                ),
              ),
            ],
          ),
          body: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  itemCount: products.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 30.0),
                  itemBuilder: (context, index) => Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.network(
                            products[index]["photo"].toString(),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 12.0),
                          Text(
                            products[index]["name"].toString(),
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (products[index]["in-stock"] as bool)
                                Row(
                                  children: [
                                    const Icon(Icons.check_box),
                                    Text(AppLocalizations.of(context)
                                        .getTranslate("in-stock")),
                                  ],
                                )
                              else
                                Row(
                                  children: [
                                    const Icon(Icons.error),
                                    Text(AppLocalizations.of(context)
                                        .getTranslate("not-available")),
                                  ],
                                ),
                              Text(
                                products[index]["price"].toString() + " ₺",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12.0),
                          ElevatedButton(
                            onPressed: () {
                              cartCubit.sepeteEkle(
                                id: products[index]["id"] as int,
                                photo: products[index]["photo"].toString(),
                                ad: products[index]["name"].toString(),
                                sayi: 1,
                                fiyat: products[index]["price"] as double,
                              );

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    AppLocalizations.of(context)
                                        .getTranslate("added-to-cart"),
                                  ),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () => GoRouter.of(context)
                                              .push("/cart"),
                                          child: const Text("Go to basket"),
                                        ),
                                        const Gap(5),
                                        ElevatedButton(
                                          onPressed: () =>
                                              GoRouter.of(context).pop(),
                                          child: const Text("Close"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context)
                                  .getTranslate("add_to_basket"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
