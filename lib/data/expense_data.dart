import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart' show rootBundle;
import 'package:expense_tracker/models/expense.dart';

final random = Random();

DateTime randomDate() => DateTime(
      DateTime.now().year,
      random.nextInt(12) + 1,
      random.nextInt(27) + 1,
    );

Future<Map<String, dynamic>> loadJsonFromAssets(String filePath) async {
  String jsonString = await rootBundle.loadString(filePath);
  return jsonDecode(jsonString);
}

Future<Map<String, dynamic>> loadJsonFromAssets2(String filePath) async {
  return rootBundle.loadStructuredData(filePath, (String s) async {
    return json.decode(s);
  });
}

Future<String> makePhraseWithOrder(
  List<String> order,
  Map<String, dynamic> categorizedWords,
) async {
  List<String> wordList = [];
  for (final category in order) {
    await Future.delayed(const Duration(milliseconds: 30), () {});
    final categoryWords = categorizedWords[category]!;
    wordList.add(categoryWords[random.nextInt(categoryWords.length)]);
  }
  final phrase = wordList.join(" ");
  return phrase.replaceFirst(phrase[0], phrase[0].toUpperCase());
}

Future<List<Expense>> generateBetterDummyExpenses() async {
  final numWords = random.nextInt(20) + 5;
  final categorizedWords = await loadJsonFromAssets2('assets/categorized_words.json');

  const List<List<String>> orders = [
    ['verb', 'noun'],
    ['noun', 'verb'],
    ['verb', 'adjective', 'noun'],
    ['adverb', 'verb'],
    ['adverb', 'verb', 'noun']
  ];

  return [
    for (var i = 0; i < numWords; i++)
      Expense(
        title: await makePhraseWithOrder(
          orders[random.nextInt(orders.length)],
          categorizedWords,
        ),
        amount: random.nextDouble() * 20,
        date: randomDate(),
        category: Category.values[random.nextInt(Category.values.length)],
      )
  ];
}
