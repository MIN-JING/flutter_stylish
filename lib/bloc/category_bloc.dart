import 'package:bloc/bloc.dart';

import '../model/clothes.dart';

class ClothesCategoryState {
  final String clothesCategory;
  final List<ClothesItem> clothes;

  ClothesCategoryState({required this.clothesCategory, required this.clothes});
}

class ClothesCategoryBloc
    extends Bloc<ToggleCategoryEvent, ClothesCategoryState> {
  ClothesCategoryBloc()
      : super(ClothesCategoryState(
            clothesCategory: "女裝",
            clothes: generateMockClothesItems(20, "女裝"))) {
    on<ToggleCategoryEvent>((event, emit) {
      final newCategory = event.category;
      final newClothes = generateMockClothesItems(20, newCategory);
      emit(ClothesCategoryState(
          clothesCategory: newCategory, clothes: newClothes));
    });
  }
}

class ToggleCategoryEvent {
  final String category;

  ToggleCategoryEvent(this.category);
}
