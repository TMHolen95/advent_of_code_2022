import 'dart:io';
import 'package:path/path.dart';

enum GameMove {
  rock(1), paper(2), scissors(3);

  final int value;
  const GameMove(this.value);

  factory GameMove.cpu(String value) {
    return GameMove._fromValue(value.codeUnits.first - 64);
  }

  factory GameMove._fromValue(int value) {
    return values.firstWhere((e) => e.value == value);
  }

  factory GameMove.me(String value) {
    if (value.codeUnits.first == 89) {
      return GameMove._fromValue(2);
    } else if (value.codeUnits.first == 88) {
      return GameMove._fromValue(1);
    } else {
      return GameMove._fromValue(3);
    }
  }
}

class GameRound {
  final GameMove cpu;
  final GameMove me;

  GameRound(this.cpu, this.me);

  int get loss => me.value + 0;
  int get draw => me.value + 3;
  int get win => me.value + 6;
  bool get mePlayScissors => me == GameMove.scissors;
  bool get mePlayRock => me == GameMove.rock;
  bool get mePlayPaper => me == GameMove.paper;

  int getRoundScore() {
    if (cpu == me) return draw;
    switch (cpu) {
      case GameMove.rock:
        return mePlayScissors ? loss : win;
      case GameMove.paper:
        return mePlayRock ? loss : win;
      case GameMove.scissors:
        return mePlayPaper ? loss : win;
    }
  }

  static GameMove predeterminedResult(GameMove cpu, String value) {
    if (value == "Y") return cpu;

    switch (cpu) {
      case GameMove.rock:
        return value == "X" ? GameMove.scissors : GameMove.paper;
      case GameMove.paper:
        return value == "X" ? GameMove.rock : GameMove.scissors;
      case GameMove.scissors:
        return value == "X" ? GameMove.paper : GameMove.rock;
    }
  }
}

main() async {
  var pathToFile = join(dirname(Platform.script.toFilePath()), 'data.txt');
  List<String> lines = File(pathToFile).readAsLinesSync();
  int score = 0;
  for (var e in lines) {
    List<String> values = e.split(" ");
    GameMove cpu = GameMove.cpu(values.first);
    GameMove me = GameRound.predeterminedResult(cpu, values.last);
    int roundScore = GameRound(cpu, me).getRoundScore();
    print(roundScore);
    score += roundScore;
  }
  print(score);
}
