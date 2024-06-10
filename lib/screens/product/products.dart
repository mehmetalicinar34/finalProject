import 'package:flutter/material.dart';
import 'package:flutter_advanced_dev/bloc/client/client_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/cart/cart_cubit.dart';
import '../../bloc/products/products_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/localizations.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late ProductsCubit productsCubit;
  late CartCubit cartCubit;
  late ClientCubit clientCubit;

  @override
  void initState() {
    super.initState();
    productsCubit = context.read<ProductsCubit>();
    cartCubit = context.read<CartCubit>();
    clientCubit = context.read<ClientCubit>();
  }

  @override
  Widget build(BuildContext context) {
    var products = [
      {
        "id": 1,
        "name": "MacBook Pro 2024 M2 Pro",
        "in-stock": true,
        "price": 65000.00,
        "photo":
            "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/refurb-mbp14-m2-silver-202303?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1680103614090",
      },
      {
        "id": 2,
        "name": "iPhone 15 Pro Max",
        "in-stock": false,
        "price": 0,
        "photo":
            "https://st-troy.mncdn.com/mnresize/1500/1500/Content/media/ProductImg/original/mu793tua-apple-iphone-15-pro-max-256gb-natural-titanium-638305576694571609.jpg",
      },
      {
        "id": 3,
        "name": "Asus VivoBook",
        "in-stock": true,
        "price": 35000.00,
        "photo":
            "https://dlcdnwebimgs.asus.com/gain/a1e0bd3b-16cf-4f88-be0d-91a90e03ab0f/",
      },
      {
        "id": 4,
        "name": "Xiaomi X",
        "in-stock": true,
        "price": 15999.00,
        "photo":
            "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/refurb-mbp14-m2-silver-202303?wid=2000&hei=1536&fmt=jpeg&qlt=95&.v=1680103614090",
      },
      {
        "id": 5,
        "name": "Samsung S23",
        "in-stock": false,
        "price": 0,
        "photo":
            "https://st-troy.mncdn.com/mnresize/1500/1500/Content/media/ProductImg/original/mu793tua-apple-iphone-15-pro-max-256gb-natural-titanium-638305576694571609.jpg",
      },
      {
        "id": 6,
        "name": "Lenovo X1",
        "in-stock": true,
        "price": 43000.00,
        "photo":
            "https://dlcdnwebimgs.asus.com/gain/a1e0bd3b-16cf-4f88-be0d-91a90e03ab0f/",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).getTranslate("products")),
        actions: [
          if (clientCubit.state.darkMode)
            IconButton(
              onPressed: () {
                clientCubit.changeDarkMode(darkMode: false);
              },
              icon: const Icon(Icons.sunny),
            )
          else
            IconButton(
              onPressed: () {
                clientCubit.changeDarkMode(darkMode: true);
              },
              icon: const Icon(Icons.nightlight),
            ),
          IconButton(
            onPressed: () {
              if (clientCubit.state.language == "tr") {
                clientCubit.changeLanguage(language: "en");
              } else {
                clientCubit.changeLanguage(language: "tr");
              }
            },
            icon: const Icon(Icons.language),
          ),
          IconButton(
            onPressed: () => GoRouter.of(context).push("/favorites"),
            icon: const Icon(Icons.favorite),
          ),
          IconButton(
            onPressed: () => GoRouter.of(context).push("/cart"),
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              itemCount: products.length,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 30.0),
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
                        height: 150,
                        fit: BoxFit.cover,
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
                            builder: (context) => AlertDialog(
                              title: Text(
                                AppLocalizations.of(context)
                                    .getTranslate("cart"),
                              ),
                              content: Text(
                                AppLocalizations.of(context)
                                    .getTranslate("added-to-cart"),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () =>
                                      GoRouter.of(context).push("/cart"),
                                  child: const Text("Added to basket"),
                                ),
                                ElevatedButton(
                                  onPressed: () => GoRouter.of(context).pop(),
                                  child: const Text("Close"),
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
  }
}
