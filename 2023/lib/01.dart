void solvePart1(List<String> lines) {
  int sum = 0;

  final wordNumbers = [
    ('one', 'o1e'),
    ('two', 't2o'),
    ('three', 't3e'),
    ('four', 'f4r'),
    ('five', 'f5e'),
    ('six', 's6x'),
    ('seven', 's7n'),
    ('eight', 'e8t'),
    ('nine', 'n9e')
  ];

  for (final input in lines) {
    final numbers = <int>[];

    var line = input;

    for (var element in wordNumbers) {
      line = line.replaceAll(element.$1, element.$2);
    }

    print('$input : $line');

    for (var i = 0; i < line.length; i++) {
      final c = line.codeUnitAt(i);
      final intValue = _isNumber(c);

      if (intValue != null) {
        numbers.add(intValue);
      }
    }

    int? value;
    if (numbers.isNotEmpty) {
      final a = numbers.first;
      final b = numbers.last;

      value = int.parse('$a$b');
      sum += value;
    }
    print('$line : $value');
  }

  print(sum);
}

int? _isNumber(int codeValue) {
  final intValue = codeValue - 48;

  if (intValue >= 0 && intValue <= 9) return intValue;

  return null;
}
