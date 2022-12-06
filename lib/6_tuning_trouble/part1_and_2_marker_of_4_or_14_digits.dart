import 'dart:io';
import 'package:path/path.dart';

main() async {
  var pathToFile = join(dirname(Platform.script.toFilePath()), 'data.txt');
  List<String> lines = File(pathToFile).readAsLinesSync();
  String data = lines.first;
  // int markerLength = 4; // Part 1
  int markerLength = 14; // Part 2

  String removedData = "";
  bool done = false;
  while(data.isNotEmpty && !done) {
    if(data.substring(0, markerLength).split("").toSet().length == markerLength) {
      done = true;
    } else {
      removedData += data.substring(0,1);
      data = data.substring(1);
    }
  }
  print(removedData.length + markerLength);
}

