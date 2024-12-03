import 'package:collection/collection.dart';

void solvePart1(List<String> lines) {
  final parts =
      lines.map((e) => e.split((RegExp(r'\s+'))).map((e) => int.parse(e)).toList()).map((e) => (e[0], e[1])).toList();

  final diffs = <int>[];

  final left = parts.map((e) => e.$1).toList()..sort();
  final right = parts.map((e) => e.$2).toList()..sort();

  for (var i = 0; i < left.length; i++) {
    final diff = (left[i] - right[i]).abs();
    diffs.add(diff);

    print('${left[i]} - ${right[i]} = $diff');
  }

  print(diffs.sum);
}

void solvePart2(List<String> lines) {
  final parts =
      lines.map((e) => e.split((RegExp(r'\s+'))).map((e) => int.parse(e)).toList()).map((e) => (e[0], e[1])).toList();

  final left = parts.map((e) => e.$1).toList()..sort();
  final right = parts.map((e) => e.$2).toList()..sort();

  var similarity = 0;

  for (final leftNumber in left) {
    final occurences = right.where((x) => x == leftNumber).length;

    similarity += leftNumber * occurences;
  }

  print(similarity);
}
