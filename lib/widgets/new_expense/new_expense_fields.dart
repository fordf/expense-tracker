import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  const DatePicker({super.key, required this.onPressed, required this.selectedDate});

  final DateTime? selectedDate;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton.icon(
        iconAlignment: IconAlignment.end,
        label: Text(selectedDate == null
            ? 'Select a date'
            : dateFormatter.format(selectedDate!)),
        onPressed: onPressed,
        icon: const Icon(Icons.calendar_month),
      ),
    );
  }
}

class CategoryField extends StatelessWidget {
  const CategoryField(
      {super.key,
      required this.selectedCategory,
      required this.onCategorySelected});

  final Category selectedCategory;
  final void Function(Category) onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCategory,
      items: Category.values
          .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category.name.toUpperCase()),
              ))
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        onCategorySelected(value);
      },
    );
  }
}

class TitleField extends StatelessWidget {
  const TitleField({super.key, required this.titleController});

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: titleController,
        maxLength: 50,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          label: Text('Title'),
        ),
    );
  }
}

class AmountField extends StatelessWidget {
  const AmountField({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: amountController,
        keyboardType: const TextInputType.numberWithOptions(
          decimal: true,
        ),
        decoration: const InputDecoration(
          prefix: Text('\$ '),
          label: Text('Amount'),
        ),
      ),
    );
  }
}
