import 'package:expense_tracker/widgets/new_expense/new_expense_fields.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddNewExpense});

  final void Function(Expense) onAddNewExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _onCategorySelected(category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
      initialDate: now,
    );
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void _submitExpenseData() {
    final submittedTitle = _titleController.text.trim();
    final submittedAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = submittedAmount == null || submittedAmount <= 0;
    if (submittedTitle.isEmpty || amountIsInvalid || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }

    widget.onAddNewExpense(Expense(
      title: submittedTitle,
      amount: submittedAmount,
      date: _selectedDate!,
      category: _selectedCategory,
    ));

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardHeight + 16),
              child: Column(
                children: [
                  if (width > 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TitleField(titleController: _titleController),
                        ),
                        const SizedBox(width: 24),
                        AmountField(amountController: _amountController),
                      ],
                    )
                  else
                    TitleField(titleController: _titleController),
                  if (width > 600)
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CategoryField(
                          selectedCategory: _selectedCategory,
                          onCategorySelected: _onCategorySelected,
                        ),
                        // const SizedBox(width: 24),
                        const Spacer(),
                        DatePicker(onPressed: _presentDatePicker),
                      ],
                    )
                  else
                    Row(
                      children: [
                        AmountField(amountController: _amountController),
                        const SizedBox(width: 24),
                        DatePicker(onPressed: _presentDatePicker),
                      ],
                    ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      if (width <= 600)
                        CategoryField(
                          selectedCategory: _selectedCategory,
                          onCategorySelected: _onCategorySelected,
                        ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
