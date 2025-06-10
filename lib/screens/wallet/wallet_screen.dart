import 'package:flutter/material.dart';
import 'package:zanga/screens/wallet/group_wallet_screen.dart';
import 'package:zanga/screens/wallet/insight_screen.dart';
import 'package:zanga/screens/wallet/rewards_screen.dart';
import 'package:zanga/screens/wallet/linked_accounts_screen.dart';
import 'package:zanga/screens/wallet/budget_screen.dart';

enum WalletContentType {
  myWallet,
  groupWallet,
  insights,
  rewards,
  linkedAccounts,
  budgets,
}

class ZWalletScreen extends StatefulWidget {
  final WalletContentType contentType;

  const ZWalletScreen({super.key, required this.contentType});

  @override
  State<ZWalletScreen> createState() => _ZWalletScreenState();
}

class _ZWalletScreenState extends State<ZWalletScreen> {
  final List<Transaction> _transactions = [
    Transaction(
      type: 'Sent',
      amount: -500.0,
      recipient: 'John Mwangi',
      time: '10:30 AM',
      category: 'Personal',
    ),
    Transaction(
      type: 'Received',
      amount: 1200.0,
      sender: 'Sarah Wambui',
      time: 'Yesterday',
      category: 'Salary',
    ),
    Transaction(
      type: 'Bill Payment',
      amount: -350.0,
      description: 'KPLC Electricity',
      time: 'Yesterday',
      category: 'Utilities',
    ),
    Transaction(
      type: 'Received',
      amount: 800.0,
      sender: 'Mike Otieno',
      time: 'Monday',
      category: 'Business',
    ),
    Transaction(
      type: 'Sent',
      amount: -200.0,
      recipient: 'Jane Kamau',
      time: 'Monday',
      category: 'Shopping',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Widget currentContent;
    switch (widget.contentType) {
      case WalletContentType.myWallet:
        currentContent = _buildMyWalletContent();
        break;
      case WalletContentType.groupWallet:
        currentContent = const GroupWalletScreen();
        break;
      case WalletContentType.insights:
        currentContent = const InsightsScreen();
        break;
      case WalletContentType.rewards:
        currentContent = const RewardsScreen();
        break;
      case WalletContentType.linkedAccounts:
        currentContent = const LinkedAccountsScreen();
        break;
      case WalletContentType.budgets:
        currentContent = const BudgetScreen();
        break;
      default:
        currentContent = _buildMyWalletContent();
    }

    return Column(children: [Expanded(child: currentContent)]);
  }

  Widget _buildMyWalletContent() {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.all(12),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Available Balance',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  'MK 12,450.00',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton(
                      Icons.send,
                      'Send',
                      Colors.blue,
                      onTap: () {
                        // Implement send money functionality
                      },
                    ),
                    _buildActionButton(
                      Icons.call_received,
                      'Receive',
                      Colors.green,
                      onTap: () {
                        // Implement receive money functionality
                      },
                    ),
                    _buildActionButton(
                      Icons.receipt,
                      'Pay Bills',
                      Colors.orange,
                      onTap: () {
                        // Implement bill payment functionality
                      },
                    ),
                    _buildActionButton(
                      Icons.qr_code,
                      'Scan QR',
                      Colors.purple,
                      onTap: () {
                        // Implement QR code scanning
                      },
                    ),
                    _buildActionButton(
                      Icons.account_balance,
                      'Accounts',
                      Colors.teal,
                      onTap: () {
                        // Navigate to linked accounts
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LinkedAccountsScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildActionButton(
                      Icons.savings,
                      'Savings',
                      Colors.indigo,
                      onTap: () {
                        // Implement savings functionality
                      },
                    ),
                    _buildActionButton(
                      Icons.attach_money,
                      'Budget',
                      Colors.amber,
                      onTap: () {
                        // Navigate to budget screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BudgetScreen(),
                          ),
                        );
                      },
                    ),
                    _buildActionButton(
                      Icons.history,
                      'History',
                      Colors.grey,
                      onTap: () {
                        // Show transaction history
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recent Activities',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // Show all transactions
                },
                child: const Text('View All'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _transactions.length,
            itemBuilder: (context, index) {
              return _buildTransactionItem(_transactions[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    Color color, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      elevation: 1,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              transaction.amount > 0
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
          child: Icon(
            transaction.amount > 0 ? Icons.call_received : Icons.call_made,
            color: transaction.amount > 0 ? Colors.green : Colors.red,
          ),
        ),
        title: Text(
          transaction.type,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.amount > 0
                  ? 'From: ${transaction.sender ?? 'N/A'}'
                  : transaction.type == 'Bill Payment'
                  ? transaction.description ?? 'N/A'
                  : 'To: ${transaction.recipient ?? 'N/A'}',
            ),
            if (transaction.category != null)
              Chip(
                label: Text(transaction.category!),
                backgroundColor: Colors.grey[200],
                labelStyle: const TextStyle(fontSize: 12),
              ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'MK ${transaction.amount.abs().toStringAsFixed(2)}',
              style: TextStyle(
                color: transaction.amount > 0 ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              transaction.time,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final String type;
  final double amount;
  final String? recipient;
  final String? sender;
  final String? description;
  final String time;
  final String? category;

  Transaction({
    required this.type,
    required this.amount,
    this.recipient,
    this.sender,
    this.description,
    required this.time,
    this.category,
  });
}
