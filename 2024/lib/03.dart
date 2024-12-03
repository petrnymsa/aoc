void solvePart1(List<String> lines) {
  var sum = 0;

  for (final line in lines) {
    var word = '';

    for (var i = 0; i < line.length; i++) {
      final c = line[i];

      word += c;
      if (word.endsWith('mul') && i != line.length - 1) {
        print('Found mul: $i');

        final sub = line.substring(i + 1);

        print('SUb: $sub');
        final reg = RegExp(r'\((\d+),(\d+)\)');
        final match = reg.matchAsPrefix(sub);

        final currentI = i;

        print('Match: $match, start: ${match?.start}, end: ${match?.end}');

        if (match != null) {
          final a = int.parse(match.group(1)!);
          final b = int.parse(match.group(2)!);

          sum += a * b;
          print('A: $a, B: $b, SUM: $sum');
          i += match.end;
        }

        word = '';

        print('I moved from: $currentI to: $i (${line.substring(i)})');

        print('\n');
      }
    }
  }

  print(sum);
}

void solvePart2(List<String> lines) {
  var sum = 0;
  var doCompute = true;

  for (final line in lines) {
    var word = '';

    for (var i = 0; i < line.length; i++) {
      final c = line[i];

      word += c;

      if (word.endsWith('do()')) {
        print('Enable do() at $i');
        word = '';
        doCompute = true;
      }

      if (word.endsWith('don\'t()')) {
        print('Disable dont() at $i');
        word = '';
        doCompute = false;
      }

      if (word.endsWith('mul') && i != line.length - 1 && doCompute) {
        final sub = line.substring(i + 1);

        print('Mul at: $i, sub: $sub');
        final reg = RegExp(r'\((\d+),(\d+)\)');
        final match = reg.matchAsPrefix(sub);

        final currentI = i;

        if (match != null) {
          print('Match start: ${match.start}, end: ${match.end}');

          final a = int.parse(match.group(1)!);
          final b = int.parse(match.group(2)!);

          sum += a * b;
          print('A: $a, B: $b, SUM: $sum');
          i += match.end;
        }

        word = '';

        print('I moved from: $currentI to: $i (${line.substring(i)})');

        print('\n');
      }
    }
  }

  print(sum);
}
