import 'package:flutter/material.dart';

import '../model/clothes.dart';

class Cart extends ChangeNotifier {
  // Make the list private
  final List<ClothesItem> _clothesItems = [];

  // Expose the list through a getter
  List<ClothesItem> get clothesItems => _clothesItems;

  void addClothesItem(ClothesItem clothesItem) {
    _clothesItems.add(clothesItem);
    notifyListeners();
  }

  bool removeClothesItem(ClothesItem item) {
    final removed = _clothesItems.remove(item);
    if (removed) {
      notifyListeners();
    }
    return removed;
  }

  void clearClothesItems() {
    clothesItems.clear();
  }
}
