import 'package:flutter/material.dart';

import '../model/cart.dart';
import 'cart_inherited_widget.dart';

class CartMobile extends StatefulWidget {
  const CartMobile({Key? key}) : super(key: key);

  @override
  State<CartMobile> createState() => _CartMobileState();
}

class _CartMobileState extends State<CartMobile> {
  @override
  Widget build(BuildContext context) {
    // final cartItems = appState?.cart.clothesItems ?? [];
    final appState = CartInheritedWidget.of(context)?.appState;

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(padding: EdgeInsets.fromLTRB(0, 32, 0, 0)),
            const Text(
              "購物車",
              style: TextStyle(fontSize: 32, color: Colors.black),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 32, 0, 0)),
            ValueListenableBuilder(
                valueListenable: appState?.cart ?? Cart(),
                builder: (context, Cart cart, child) {
                  return ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: cart.clothesItems.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(cart.clothesItems[index].name),
                          subtitle:
                              Text(cart.clothesItems[index].price.toString()),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              appState?.cart
                                  .removeClothesItem(cart.clothesItems[index]);
                            },
                          ),
                        ),
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
