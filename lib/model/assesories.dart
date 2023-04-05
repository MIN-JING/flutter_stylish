import 'dart:math';

String getRandomAssesoriesName() {
  final assesoriesNames = [
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
  int randomIndex = random.nextInt(assesoriesNames.length);

  return assesoriesNames[randomIndex];
}
