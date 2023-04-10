import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/main.dart';


class CartInheritedWidget extends InheritedWidget {
  // final Cart cart;
  final AppState appState;

  const CartInheritedWidget(
      {Key? key, required Widget child, required this.appState})
      : super(key: key, child: child);

  static CartInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartInheritedWidget>();
  }

  @override
  bool updateShouldNotify(CartInheritedWidget oldWidget) {
    // return cart.clothesItems != oldWidget.cart.clothesItems;
    return appState != oldWidget.appState;
  }
}
