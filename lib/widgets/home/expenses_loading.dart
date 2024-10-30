import 'package:flutter/material.dart';

class ExpensesLoading extends StatelessWidget {
  const ExpensesLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
