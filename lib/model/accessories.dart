import 'dart:math';

String getRandomAccessories() {
  final accessories = [
    '皮帶',
    '手套',
    '帽子',
    '襪子',
    '圍巾',
    '鞋子',
    '皮包',
    '手提包',
    '領帶',
    '領帶夾',
  ];

  final random = Random();
  int randomIndex = random.nextInt(accessories.length);

  return accessories[randomIndex];
}
