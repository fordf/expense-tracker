import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatelessWidget {
  const Expenses({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).size.width > 600;
    final children = [
      isLandscape
          ? Expanded(child: Chart(expenses: expenses))
          : Chart(expenses: expenses),
      Expanded(
        child: expenses.isEmpty
            ? const Center(
                child: Text('No expenses yet! Start spending!'),
              )
            : ExpensesList(
                expenses: expenses,
                onRemoveExpense: onRemoveExpense,
              ),
      ),
    ];
    return isLandscape ? Row(children: children) : Column(children: children);
  }
}
