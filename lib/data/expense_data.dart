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

Future<List<Expense>> generateDummyExpenses() async {

  // Just to make it slower....
  await Future.delayed(const Duration(seconds: 2), () {});
  
  final List<String> words = [];
  final numWords = random.nextInt(20) + 5;
  final lineStream = rootBundle
      .loadString('assets/words.txt')
      .asStream()
      .transform(const LineSplitter())
      .where((word) => random.nextDouble() < .00002);
      
  try {
    await for (var line in lineStream) {
      lineStream.skip(random.nextInt(40000));
      words.add(line);
      if (words.length >= numWords) {
        break;
      }
    }
  } catch (e) {
    print('Error: $e');
  }
  return [
    for (final word in words)
      Expense(
        title: word,
        amount: random.nextDouble() * 20,
        date: randomDate(),
        category: Category.values[random.nextInt(Category.values.length)],
      )
  ];
}
