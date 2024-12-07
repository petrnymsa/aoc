import 'dart:convert';
import 'dart:io';

import 'package:aoc_2024/05.dart';

void main(List<String> arguments) async {
  List<String> lines = [];

  if (arguments.isNotEmpty) {
    lines = await File(arguments[0]).readAsLines();
  } else {
    await for (final line in stdin.transform(utf8.decoder).transform(const LineSplitter())) {
      lines.add(line);
    }
  }
  print('PART 1\n=====\n');
  solvePart1(lines);
  print('PART 2\n=====\n');
  solvePart2(lines);
}
