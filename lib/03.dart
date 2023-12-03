import 'package:collection/collection.dart';

typedef Number = ({int number, List<int> indices});
typedef Symbol = ({String symbol, int index, int lineIndex});

void solvePart1(List<String> lines) {
  final result = _parse(lines);
  final numbers = result.$1;
  final allNumbers = numbers.map((x) => x.map((e) => e.number)).flattened.toList();
  final symbols = result.$2;

  final solution = symbols.map((symbol) => _getAdjacentNumbers(numbers, symbol, lines.length)).flattened;
  final solutionNumbers = solution.map((e) => e.number).toList();
  print('Numbers not in solution: ${allNumbers.toSet().difference(solutionNumbers.toSet())} ');

  print(solution.map((x) => x.number).toList());

  print('SUM: ${solutionNumbers.sum}');
}

void solvePart2(List<String> lines) {
  final result = _parse(lines);
  final numbers = result.$1;
  final symbols = result.$2;
  final possibleGears = symbols.where((element) => element.symbol == '*').toList();

  final sum = possibleGears
      .map((gear) => _getAdjacentNumbers(numbers, gear, lines.length))
      // only exactly 2
      .where((x) => x.length == 2)
      // get ratio
      .map((e) => e.fold(1, (previousValue, element) => previousValue * element.number))
      .sum;

  print(sum);
}

(List<List<Number>> numbers, List<Symbol> symbols) _parse(List<String> lines) {
  final numberRegex = RegExp(r'\d+');
  RegExp symbolsRegex = RegExp(r'[^\d.]');
  final numbers = lines
      .map((line) => numberRegex.allMatches(line).map<Number>((match) {
            int number = int.parse(match.group(0)!);
            final indices = List<int>.generate(match.end - match.start, (index) => index + match.start);

            return (number: number, indices: indices);
          }).toList())
      .toList();

  final symbols = lines
      .mapIndexed((lineIndex, line) => symbolsRegex
          .allMatches(line)
          .map<Symbol>((match) => (symbol: match.group(0)!, index: match.start, lineIndex: lineIndex))
          .toList())
      .where((element) => element.isNotEmpty)
      .flattened
      .toList();

  return (numbers, symbols);
}

List<Number> _getAdjacentNumbers(List<List<Number>> numbers, Symbol symbol, int maxIndex) {
  final solution = <Number>[];
  final lineNumbers = numbers[symbol.lineIndex];
  final upperNumbers = symbol.lineIndex > 0 ? numbers[symbol.lineIndex - 1] : null;
  final bottomNumbers = symbol.lineIndex < maxIndex - 1 ? numbers[symbol.lineIndex + 1] : null;

  final partsOnLine = lineNumbers
      .where((number) => number.indices.contains(symbol.index - 1) || number.indices.contains(symbol.index + 1))
      .toList();

  solution.addAll(partsOnLine);

  final partsUpper = upperNumbers?.where((number) =>
      number.indices.contains(symbol.index) || // same
      number.indices.contains(symbol.index - 1) || // diagonal left
      number.indices.contains(symbol.index + 1)); // diagonal right

  if (partsUpper != null) {
    solution.addAll(partsUpper);
  }

  final bottomUpper = bottomNumbers?.where((number) =>
      number.indices.contains(symbol.index) || // same
      number.indices.contains(symbol.index - 1) || // diagonal left
      number.indices.contains(symbol.index + 1)); // diagonal right

  if (bottomUpper != null) {
    solution.addAll(bottomUpper);
  }

  return solution;
}
