import 'dart:io';
import 'package:path/path.dart';

main() async {
  var pathToFile = join(dirname(Platform.script.toFilePath()), 'data.txt');
  List<String> lines = File(pathToFile).readAsLinesSync();

  List<int> sums = [];
  int current = 0;
  for (String entry in lines) {
    int? value = int.tryParse(entry);
    if (value != null) {
      current += value;
    } else {
      sums.add(current);
      current = 0;
    }
  }

  sums.sort((a,b) => b.compareTo(a));
  print(sums.take(1).toString());
  print(sums.take(3).reduce((value, element) => value + element));
}