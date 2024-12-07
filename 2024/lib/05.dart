import 'package:collection/collection.dart';

void solvePart1(List<String> lines) {
  final rules = lines
      .where((x) => RegExp(r'\d+\|\d+').hasMatch(x))
      .map((x) => x.split('|').map((e) => int.parse(e)).toList())
      .toList();

  final numbers = lines
      .where((x) => RegExp(r'(\d+,)+').hasMatch(x))
      .map((x) => x.split(',').map((e) => int.parse(e)).toList())
      .toList();

  var sum = 0;
  for (final x in numbers.indexed) {
    final index = x.$1;
    final nums = x.$2;
    final correct = isCorrect(nums, rules);

    print('${index + 1}.numbers are correct?: $correct');

    if (correct.$1) {
      final middle = nums[nums.length ~/ 2];
      sum += middle;

      print('Middle: $middle');
    }

    print('========\n');
  }

  print('ANSWER: $sum');
}

void solvePart2(List<String> lines) {
  final rules = lines
      .where((x) => RegExp(r'\d+\|\d+').hasMatch(x))
      .map((x) => x.split('|').map((e) => int.parse(e)).toList())
      .toList();

  final numbers = lines
      .where((x) => RegExp(r'(\d+,)+').hasMatch(x))
      .map((x) => x.split(',').map((e) => int.parse(e)).toList())
      .toList();

  var sum = 0;
  for (final x in numbers.indexed) {
    final index = x.$1;
    final nums = x.$2;

    print('Processing ${index + 1}: $nums\n');

    final correct = isCorrect(nums, rules);

    //97,13,75,29,47 becomes 97,75,47,29,13

    print('OK?: ${correct.$1}');

    if (!correct.$1) {
      final reverseMap = Map.fromEntries(correct.$2.entries.map((e) => MapEntry(e.value, e.key)));

      print('${correct.$2}');
      final list = List.generate(nums.length, (i) => reverseMap[i]!);

      print('Corrected: $list');

      final middle = list[list.length ~/ 2];
      sum += middle;

      print('Middle: $middle');
    }

    print('========\n');
  }

  print('ANSWER: $sum');
}

(bool, Map<int, int>) isCorrect(List<int> numbers, List<List<int>> rules) {
  final indexMap = <int, int>{};
  var correct = true;

  final sb = StringBuffer();

  for (int i = 0; i < numbers.length; i++) {
    final number = numbers[i];

    final after = numbers.skip(i + 1).take(numbers.length - 1).toList();
    final before = i > 0 ? numbers.take(i).toList() : [];
    final numberRules = getNumberRules(number: number, rules: rules, allNumbers: numbers);

    sb.writeln('Processing number: $number, after: $after, before: $before');
    sb.writeln('Rules - before: ${numberRules.numbersBefore}, after: ${numberRules.numbersAfter}');

    final rulesBefore = numberRules.numbersBefore;
    final rulesAfter = numberRules.numbersAfter;

    final violatedBeforeRule = rulesBefore.firstWhereOrNull((x) => !before.contains(x));
    final violatedAfterRule = after.firstWhereOrNull((x) => !rulesAfter.contains(x));

    if (violatedBeforeRule != null) {
      sb.writeln('Number $number violates before rule: $violatedBeforeRule');
      correct = false;
      // final violatedIndex = numbers.indexOf(violatedBeforeRule);
      // final index = rulesAfter.length - rulesBefore.length;

      // indexMap[number] = index;
      // indexMap[violatedBeforeRule] = i;
      // final beforeIndex = indexMap[violatedBeforeRule] ?? i + 1;
      // indexMap[violatedBeforeRule] = i;
      // indexMap[number] = beforeIndex;

      //  sb.writeln('Swapping $number to $violatedIndex. $violatedBeforeRule to $i');
    } else if (violatedAfterRule != null) {
      sb.writeln('Number $number violates after rule: $violatedAfterRule');
      correct = false;
      final violatedIndex = numbers.indexOf(violatedAfterRule);

      indexMap[number] = violatedIndex;
      indexMap[violatedAfterRule] = i;
      //indexMap[number] = rulesAfter.length - 1;

      // final afterIndex = indexMap[violatedAfterRule] ?? i - 1;
      // indexMap[violatedAfterRule] = i;
      // indexMap[number] = afterIndex;

      //  sb.writeln('Swapping $number to $violatedIndex. $violatedAfterRule to $i');
    }

    if (!indexMap.containsKey(number)) {
      if (correct) {
        indexMap[number] = i;
        sb.writeln('Number $number is correct - index: $i');
      } else {
        final index = numbers.length - rulesAfter.length + rulesBefore.length - 1;
        sb.writeln('Number $number is wrong - index: $index');
        indexMap[number] = index;
      }
    }

    sb.writeln('----');
  }

  if (!correct) {
    print(sb.toString());
  }
  return (correct, indexMap);
}

({List<int> numbersBefore, List<int> numbersAfter}) getNumberRules(
    {required int number, required List<List<int>> rules, required List<int> allNumbers}) {
//  print('RULES: $allNumbers');

  final rulestBefore = rules
      .where((x) {
        final ok = x[1] == number && allNumbers.contains(x[1]) && allNumbers.contains(x[0]);
        // print('Parsing before rule: $x -> $ok');

        return ok;
      })
      .map((x) => x[0])
      .toList();
  final rulesAfter = rules
      .where((x) {
        final ok = x[0] == number && allNumbers.contains(x[0]) && allNumbers.contains(x[1]);

        //  print('Parsing after rule: $x -> $ok');

        return ok;
      })
      .map((x) => x[1])
      .toList();

  return (numbersBefore: rulestBefore, numbersAfter: rulesAfter);
}
