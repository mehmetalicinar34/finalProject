import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/cart/cart_cubit.dart';
import '../../core/localizations.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  void _artir(BuildContext context, int id) {
    context.read<CartCubit>().artir(id: id);
  }

  void _azalt(BuildContext context, int id) {
    context.read<CartCubit>().azalt(id: id);
  }

  void _sepettenCikart(BuildContext context, int id) {
    context.read<CartCubit>().sepettenCikart(id: id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).getTranslate("cart")),
        actions: [
          IconButton(
            onPressed: () => GoRouter.of(context).push("/favorites"),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          double totalAmount = 0;

          return state.sepet.isEmpty
              ? Center(
                  child: Text(
                    AppLocalizations.of(context).getTranslate("cart-empty"),
                  ),
                )
              : ListView.builder(
                  itemCount: state.sepet.length,
                  itemBuilder: (context, index) {
                    final product = state.sepet[index];
                    final productTotal =
                        product["count"] * (product["price"] as double);
                    totalAmount += productTotal;

                    return Card(
                      elevation: 4.0,
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(
                          product["photo"].toString(),
                          height: 120,
                        ),
                        title: Text(product["name"].toString()),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product["count"]} x ${product["price"]} ₺",
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () =>
                                      _azalt(context, product["id"] as int),
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(product["count"].toString()),
                                IconButton(
                                  onPressed: () =>
                                      _artir(context, product["id"] as int),
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          onPressed: () =>
                              _sepettenCikart(context, product["id"] as int),
                          icon: const Icon(Icons.remove_shopping_cart),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          double totalAmount = 0;
          for (var product in state.sepet) {
            totalAmount += (product["count"] * (product["price"] as double));
          }
          return Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).getTranslate("total-amount"),
                ),
                Text(
                  "${totalAmount.toStringAsFixed(2)} ₺",
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
