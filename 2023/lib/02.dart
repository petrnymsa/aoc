import 'package:collection/collection.dart';

typedef Cube = ({int count, String color});

void solvePart1(List<String> lines) {
  final ids = <int>[];

  // only 12 red cubes, 13 green cubes, and 14 blue cubes
  final limits = <String, int>{
    'red': 12,
    'green': 13,
    'blue': 14,
  };

  for (final line in lines) {
    final gameParts = line.split(':');
    final gameId = int.parse(gameParts[0].split(' ').last);

    final bags = gameParts[1].trim().split(';').toList();

    var possible = true;

    print('Game: $gameId');

    for (final bag in bags) {
      final cubes = bag.split(',').map<Cube>((e) {
        final parts = e.trim().split(' ');
        return (count: int.parse(parts.first), color: parts.last);
      });

      print(cubes);

      possible = cubes.every((x) => x.count <= limits[x.color]!);

      if (!possible) break;
    }

    if (possible) ids.add(gameId);

    print('----');
  }

  print('Possible games: ');
  for (final game in ids) {
    print(game);
  }

  print('Solution: ${ids.sum}');
}

void solvePart2(List<String> lines) {
  final powers = <int>[];

  for (final line in lines) {
    final gameParts = line.split(':');
    final gameId = int.parse(gameParts[0].split(' ').last);

    final bags = gameParts[1].trim().split(';').toList();

    print('Game: $gameId');
    final maxCubes = <String, int>{};

    for (var bag in bags) {
      final cubes = bag.split(',').map<Cube>((e) {
        final parts = e.trim().split(' ');
        final count = int.parse(parts.first);
        final color = parts.last;

        maxCubes[color] = (maxCubes[color] ?? 0) < count ? count : maxCubes[color]!;

        return (count: count, color: color);
      });
      print(cubes);
      print(maxCubes);
    }

    final power = maxCubes.values.fold(1, (previousValue, x) => previousValue * x);
    powers.add(power);
    print('----');
  }

  print('Solution: ${powers.sum}');
}
