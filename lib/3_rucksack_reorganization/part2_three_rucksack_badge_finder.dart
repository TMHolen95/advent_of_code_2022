import 'dart:io';
import 'package:path/path.dart';

main() async {
  var pathToFile = join(dirname(Platform.script.toFilePath()), 'data.txt');
  List<String> lines = File(pathToFile).readAsLinesSync();

  int sum = 0;
  while (lines.isNotEmpty) {
    int value = lines.take(3)
        .map((e) => e.codeUnits.toSet())
        .reduce((value, element) => value.intersection(element))
        .first;
    sum += getPriority(value);
    lines.removeRange(0, 3);
  }
  print(sum); // 2805
}

int getPriority(int item) => (97 <= item && item <= 122) ? (item - 96) : (item - 38);