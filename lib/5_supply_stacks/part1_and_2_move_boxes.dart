import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';

/// Yikes, this code feels like a train-wreck...
main() async {
  var pathToFile = join(dirname(Platform.script.toFilePath()), 'data.txt');
  List<String> lines = File(pathToFile).readAsLinesSync();
  List<String> boxLines = lines.take(9).toList();

  Map<String, List<String>> stacks = {};
  int lineLength = boxLines.first.length;

  for(var columnIndex = 1; columnIndex < lineLength; columnIndex += 4) {
    String stackIndex = boxLines[boxLines.length - 1].substring(columnIndex, columnIndex + 1);
    for(var rowIndex = boxLines.length - 2; rowIndex >= 0; rowIndex--) {
      String value = boxLines[rowIndex].substring(columnIndex, columnIndex + 1);
      if (value != " ") {
        stacks[stackIndex] = (stacks[stackIndex] ?? [])..add(
            boxLines[rowIndex].substring(columnIndex, columnIndex + 1)
        );
      }
    }
  }

  List<String> instructionLines = lines.sublist(10).toList();
  int moveIndex = 1;
  int fromIndex = 3;
  int toIndex = 5;

  for(var line in instructionLines) {
    print(line);
    List<String> instruction = line.split(" ");
    int moveAmount = int.parse(instruction[moveIndex]);
    String fromKey = instruction[fromIndex];
    String toKey = instruction[toIndex];

    List<String> data = stacks[fromKey] ?? [];
    List<String> dataShipment = data.getRange(max(data.length - moveAmount, 0), data.length).toList();
    stacks[fromKey] = data..removeRange(max(data.length - moveAmount, 0), data.length);

    // Part 1
    // stacks[toKey] = (stacks[toKey] ?? [])..addAll(dataShipment.reversed);
    // Part 2
    stacks[toKey] = (stacks[toKey] ?? [])..addAll(dataShipment);
  }

  String code = "";
  for(String key in stacks.keys){
    code += stacks[key]?.last ?? "";
  }
  print(code); // Part 1: PTWLTDSJV , Part 2: WZMFVGGZP

}