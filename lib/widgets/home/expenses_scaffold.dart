import 'package:expense_tracker/widgets/home/error_loading.dart';
import 'package:expense_tracker/widgets/home/new_expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/data/expense_data.dart';
import 'package:expense_tracker/widgets/home/expenses.dart';
import 'package:expense_tracker/widgets/home/expenses_loading.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesScaffold extends StatefulWidget {
  const ExpensesScaffold({super.key});

  @override
  State<StatefulWidget> createState() => _ExpensesScaffoldState();
}

class _ExpensesScaffoldState extends State<ExpensesScaffold> {
  bool dataRetrieved = false;
  late Future<List<Expense>> _expensesFuture;
  final List<Expense> _expenses = [];
  AppBar appBar = AppBar(
    title: const Text('Loading Expenses...'),
  );

  @override
  void initState() {
    super.initState();
    _expensesFuture = generateBetterDummyExpenses();
  }

  void _addNewExpense(Expense newExpense) {
    setState(() {
      _expenses.add(newExpense);
    });
  }

  void _removeExpense(Expense expense) {
    final index = _expenses.indexOf(expense);
    setState(() {
      _expenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${expense.title} removed'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddNewExpense: _addNewExpense),
    );
  }

  @override
  Widget build(context) {
    Widget expensesWidget = Expenses(
      expenses: _expenses,
      onRemoveExpense: _removeExpense,
    );
    if (dataRetrieved) {
      return Scaffold(
        appBar: appBar,
        body: expensesWidget,
      );
    }
    return FutureBuilder<List<Expense>>(
      future: _expensesFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Expense>> snapshot) {
        Widget bodyWidget = const ExpensesLoading();
        if (snapshot.hasError) {
          return ErrorLoading(error: snapshot.error.toString());
        }
        if (snapshot.hasData) {
          dataRetrieved = true;
          _expenses.addAll(snapshot.requireData);
          bodyWidget = expensesWidget;
          appBar = AppBar(
            title: const Text('Expense Tracker'),
            actions: [
              IconButton(
                onPressed: _openAddExpenseOverlay,
                icon: const Icon(Icons.add),
              )
            ],
          );
        }
        return Scaffold(
          appBar: appBar,
          body: bodyWidget,
        );
      },
    );
  }
}
