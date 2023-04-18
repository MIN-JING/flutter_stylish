import 'package:flutter_minjing_stylish/bloc/base_bloc.dart';
import 'package:flutter_minjing_stylish/model/clothes.dart';

abstract class CartEvent {}

class CartAddItem extends CartEvent {
  final ClothesItem item;

  CartAddItem(this.item);
}

class CartRemoveItem extends CartEvent {
  final ClothesItem item;

  CartRemoveItem(this.item);
}

class CartClear extends CartEvent {
  CartClear();
}

class CartBloc extends BaseBloc<CartEvent> {
  CartBloc() : super(<ClothesItem>[]) {
    on<CartAddItem>((event, emit) {
      final items = List<ClothesItem>.from(state);
      items.add(event.item);
      emit(items);
    });

    on<CartRemoveItem>((event, emit) {
      final items = List<ClothesItem>.from(state);
      items.remove(event.item);
      emit(items);
    });

    // Handle the CartClear event.
    on<CartClear>((event, emit) {
      emit(<ClothesItem>[]);
    });
  }
}
