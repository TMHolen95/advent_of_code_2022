import 'dart:io';
import 'package:path/path.dart';

main() async {
  var pathToFile = join(dirname(Platform.script.toFilePath()), 'data.txt');
  List<String> lines = File(pathToFile).readAsLinesSync();

  int containedSum = 0;
  for(var line in lines) {
    List<String> intervalStrings = line.split(",");
    List<String> firstString = intervalStrings.first.split("-");
    List<String> lastString = intervalStrings.last.split("-");
    Interval first = Interval(int.parse(firstString.first), int.parse(firstString.last));
    Interval last = Interval(int.parse(lastString.first), int.parse(lastString.last));
    containedSum = first.contains(last) || last.contains(first) ? containedSum + 1 : containedSum;
  }
  print(containedSum);
}

class Interval {
  final int start;
  final int end;

  const Interval(this.start, this.end);

  contains(Interval other) {
    return start <= other.start && other.end <= end;
  }
}