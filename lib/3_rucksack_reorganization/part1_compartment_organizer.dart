import 'dart:io';
import 'package:path/path.dart';

main() async {
  var pathToFile = join(dirname(Platform.script.toFilePath()), 'data.txt');
  List<String> lines = File(pathToFile).readAsLinesSync();

  int sum = 0;
  for (var rucksackContent in lines) {
    List<int> items = rucksackContent.codeUnits;
    List<int> rucksack1 = items.sublist(0, items.length ~/ 2);
    List<int> rucksack2 = items.sublist(items.length ~/ 2);

    assert (rucksack1.length == rucksack2.length, "Backpack length is not equal!");

    Map<int, int> commonItemsCount = {};
    for (var item in rucksack1) {
      if (rucksack2.contains(item)) {
        commonItemsCount[item] = (commonItemsCount[item]  ?? 0) + 1;
      }
    }

    print(commonItemsCount);
    sum += commonItemsCount.keys.map((e) => getPriority(e)).reduce((value, element) => value + element);
  }
  print(sum);
}

int getPriority(int item) {
  if (97 <= item && item <= 122) {
    return item -96;
  } else {
    return item - 64 + 26;
  }
}