import 'dart:convert';
import 'dart:io';

import 'package:aoc_2023/03.dart';

void main(List<String> arguments) async {
  List<String> lines = [];

  if (arguments.isNotEmpty) {
    lines = await File(arguments[0]).readAsLines();
  } else {
    await for (final line in stdin.transform(utf8.decoder).transform(const LineSplitter())) {
      lines.add(line);
    }
  }

  solvePart2(lines);
}
