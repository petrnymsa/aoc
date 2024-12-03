void solvePart1(List<String> lines) {
  final numbersList = lines.map((e) => e.split(RegExp(r'\s+')).map((e) => int.parse(e)).toList()).toList();

  int safeCount = 0;

  for (final numbers in numbersList) {
    bool isSafe = _isSafe(numbers);
    print('${numbers.join(' ')}: $isSafe');
    if (isSafe) {
      safeCount++;
    }
  }

  print(safeCount);
}

bool _isSafe(List<int> numbers) {
  bool isSafe = true;
  bool? isIncreasing;

  for (var i = 0; i < numbers.length - 1; i++) {
    final diff = (numbers[i + 1] - numbers[i]).abs();

    if (diff == 0 || diff > 3) {
      isSafe = false;
      break;
    }

    if (numbers[i] > numbers[i + 1]) {
      if (isIncreasing != null && isIncreasing) {
        isSafe = false;
        break;
      }
      isIncreasing = false;
    } else if (numbers[i] < numbers[i + 1]) {
      if (isIncreasing != null && !isIncreasing) {
        isSafe = false;
        break;
      }

      isIncreasing = true;
    }
  }

  return isSafe;
}

void solvePart2(List<String> lines) {
  final numbersList = lines.map((e) => e.split(RegExp(r'\s+')).map((e) => int.parse(e)).toList()).toList();

  int safeCount = 0;

  for (final numbers in numbersList) {
    bool isSafe = false;

    isSafe = _isSafe(numbers);

    if (!isSafe) {
      for (var i = 0; i < numbers.length; i++) {
        final permutation = numbers.toList()..removeAt(i);
        isSafe = _isSafe(permutation);
        if (isSafe) {
          break;
        }
      }
    }

    print('${numbers.join(' ')}: $isSafe');
    if (isSafe) {
      safeCount++;
    }
  }

  print(safeCount);
}
