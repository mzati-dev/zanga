import 'package:flutter/material.dart';

class BudgetCategory {
  final String name;
  final IconData icon;
  final Color color;
  double budget;
  double spent;

  BudgetCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.budget,
    required this.spent,
  });
}
