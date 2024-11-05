import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:expense_tracker/models/expense.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<CategoryBucket> get categoryBuckets {
    return [
      for (final category in Category.values)
        CategoryBucket.forCategory(expenses, category)
    ];
  }

  double get maxTotalExpense => categoryBuckets.fold(0,
      (max, bucket) => bucket.totalExpenses > max ? bucket.totalExpenses : max);

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;
    final height = MediaQuery.of(context).size.width > 600 ? double.infinity : 180.0;
    return Container(
      height: height,
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            colorScheme.primary.withOpacity(0.3),
            colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in categoryBuckets)
                  ChartBar(
                      fractionOfMax: bucket.totalExpenses == 0
                          ? 0
                          : bucket.totalExpenses / maxTotalExpense)
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (final bucket in categoryBuckets)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      categoryIcons[bucket.category],
                      color: isDarkMode
                          ? colorScheme.secondary
                          : colorScheme.primary.withOpacity(0.7),
                    ),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }
}
