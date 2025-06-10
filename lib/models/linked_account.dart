import 'package:flutter/material.dart';

class LinkedAccount {
  final String name;
  final String accountNumber;
  double balance;
  final IconData icon;
  final Color color;
  bool isConnected;

  LinkedAccount({
    required this.name,
    required this.accountNumber,
    required this.balance,
    required this.icon,
    required this.color,
    required this.isConnected,
  });
}
