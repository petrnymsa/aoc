import 'dart:io';

import 'package:ansicolor/ansicolor.dart';

typedef Coord = (int x, int y);

List<Coord> foundCoors = [];

void solvePart1(List<String> lines) {
  List<List<String>> map = lines.map((line) => line.split('')).toList();
  foundCoors.clear();

  var count = 0;

  for (var x = 0; x < map.length; x++) {
    for (var y = 0; y < map.length; y++) {
      final found = Direction.values
          .map((e) => find(map: map, sx: x, sy: y, word: 'XMAS', direction: e, searchedCoords: []))
          .where((x) => x)
          .length;
      count += found;
    }
  }

  final red = AnsiPen()..red();
  final green = AnsiPen()..green();
  for (var x = 0; x < map.length; x++) {
    for (var y = 0; y < map.length; y++) {
      final coord = (x, y);

      if (foundCoors.contains(coord)) {
        stdout.write(green(map[x][y]));
      } else {
        stdout.write(red(map[x][y]));
      }
    }

    stdout.writeln();
  }

  print(count);
}

void solvePart2(List<String> lines) {
  List<List<String>> map = lines.map((line) => line.split('')).toList();
  foundCoors.clear();

  var count = 0;

  for (var x = 0; x < map.length; x++) {
    for (var y = 0; y < map.length; y++) {
      // Try MAS or SAM
      var leftPart = false;
      var rightPart = false;
      for (final word in ['MAS', 'SAM']) {
        final found = find(
          map: map,
          sx: x,
          sy: y,
          word: word,
          direction: Direction.downRight,
          searchedCoords: [],
        );

        if (found) {
          // found MAS or SAM
          leftPart = true;
          break;
        }
      }

      for (final word in ['MAS', 'SAM']) {
        final found = find(
          map: map,
          sx: x, // travese down and left to find other MAS or SAM
          sy: y + 2,
          word: word,
          direction: Direction.downLeft,
          searchedCoords: [],
        );

        if (found) {
          // found MAS or SAM
          rightPart = true;
          break;
        }
      }

      if (leftPart && rightPart) {
        count++;
      }
    }
  }

  final red = AnsiPen()..red();
  final green = AnsiPen()..green();
  for (var x = 0; x < map.length; x++) {
    for (var y = 0; y < map.length; y++) {
      final coord = (x, y);

      if (foundCoors.contains(coord)) {
        stdout.write(green(map[x][y]));
      } else {
        stdout.write(red(map[x][y]));
      }
    }

    stdout.writeln();
  }

  print(count);
}

// --- HELPERS -------

bool find(
    {required List<List<String>> map,
    required int sx,
    required int sy,
    required String word,
    required Direction direction,
    required List<Coord> searchedCoords}) {
  if (word.isEmpty) {
    foundCoors.addAll(searchedCoords);
    return true;
  }

  if (sx < 0 || sy < 0 || sx >= map.length || sy >= map.length) {
    return false;
  }

  final char = map[sx][sy];

  if (char != word[0]) {
    return false;
  }

  final next = direction.next(sx, sy);

  return find(
      map: map,
      sx: next.$1,
      sy: next.$2,
      word: word.substring(1),
      direction: direction,
      searchedCoords: [...searchedCoords, (sx, sy)]);
}

enum Direction {
  up,
  down,
  left,
  right,
  upRight,
  upLeft,
  downRight,
  downLeft;

  const Direction();

  Coord next(int x, int y) => switch (this) {
        up => (x - 1, y),
        down => (x + 1, y),
        left => (x, y - 1),
        right => (x, y + 1),
        upRight => (x - 1, y + 1),
        upLeft => (x - 1, y - 1),
        downRight => (x + 1, y + 1),
        downLeft => (x + 1, y - 1),
      };
}
