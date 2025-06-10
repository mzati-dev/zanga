import 'package:flutter/material.dart';
import 'package:zanga/models/linked_account.dart';

class LinkedAccountsScreen extends StatefulWidget {
  const LinkedAccountsScreen({super.key});

  @override
  State<LinkedAccountsScreen> createState() => _LinkedAccountsScreenState();
}

class _LinkedAccountsScreenState extends State<LinkedAccountsScreen> {
  final List<LinkedAccount> _linkedAccounts = [
    LinkedAccount(
      name: 'Airtel Money',
      accountNumber: '0881234567',
      balance: 1250.00,
      icon: Icons.phone_android,
      color: Colors.blue,
      isConnected: true,
    ),
    LinkedAccount(
      name: 'Mpamba',
      accountNumber: '0997654321',
      balance: 3500.00,
      icon: Icons.phone_iphone,
      color: Colors.green,
      isConnected: true,
    ),
    LinkedAccount(
      name: 'National Bank',
      accountNumber: '100200300400',
      balance: 12000.00,
      icon: Icons.account_balance,
      color: Colors.teal,
      isConnected: false,
    ),
    LinkedAccount(
      name: 'Standard Bank',
      accountNumber: '500600700800',
      balance: 0.00,
      icon: Icons.account_balance,
      color: Colors.orange,
      isConnected: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Linked Accounts'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _addNewAccount),
        ],
      ),
      body: ListView.builder(
        itemCount: _linkedAccounts.length,
        itemBuilder: (context, index) {
          return _buildAccountCard(_linkedAccounts[index]);
        },
      ),
    );
  }

  Widget _buildAccountCard(LinkedAccount account) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: account.color.withOpacity(0.2),
          child: Icon(account.icon, color: account.color),
        ),
        title: Text(account.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(account.accountNumber),
            if (account.isConnected)
              Text(
                'MK ${account.balance.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
          ],
        ),
        trailing:
            account.isConnected
                ? IconButton(
                  icon: const Icon(Icons.sync, color: Colors.blue),
                  onPressed: () => _refreshAccount(account),
                )
                : ElevatedButton(
                  onPressed: () => _connectAccount(account),
                  child: const Text('Connect'),
                ),
      ),
    );
  }

  void _refreshAccount(LinkedAccount account) {
    // Implement account balance refresh
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Refreshing ${account.name} balance...')),
    );
  }

  void _connectAccount(LinkedAccount account) {
    setState(() {
      account.isConnected = true;
      account.balance = 0.00; // Initial balance after connection
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Connecting to ${account.name}...')));
    // Here you would implement the actual connection logic
    // This might involve API calls, OAuth authentication, etc.
  }

  void _addNewAccount() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Account',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildAccountOption(
                'Mobile Money',
                Icons.phone_android,
                Colors.blue,
                ['Airtel Money', 'Mpamba', 'TNM Mpamba'],
              ),
              _buildAccountOption('Banks', Icons.account_balance, Colors.teal, [
                'National Bank',
                'Standard Bank',
                'FDH Bank',
                'NBS Bank',
              ]),
              _buildAccountOption(
                'Other Services',
                Icons.more_horiz,
                Colors.grey,
                ['PayPal', 'M-Pesa', 'Zoona'],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAccountOption(
    String title,
    IconData icon,
    Color color,
    List<String> services,
  ) {
    return ExpansionTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      children:
          services
              .map(
                (service) => ListTile(
                  leading: const Icon(Icons.arrow_right),
                  title: Text(service),
                  onTap: () {
                    Navigator.pop(context);
                    _showConnectionDialog(service);
                  },
                ),
              )
              .toList(),
    );
  }

  void _showConnectionDialog(String serviceName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Connect to $serviceName'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: '$serviceName Number',
                  hintText: 'Enter your account number',
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'PIN/Password',
                  hintText: 'Enter your secure PIN',
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Here you would implement the actual connection logic
                setState(() {
                  _linkedAccounts.add(
                    LinkedAccount(
                      name: serviceName,
                      accountNumber: 'New Account',
                      balance: 0.00,
                      icon:
                          serviceName.contains('Bank')
                              ? Icons.account_balance
                              : Icons.phone_android,
                      color: Colors.blue,
                      isConnected: true,
                    ),
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$serviceName connected successfully!'),
                  ),
                );
              },
              child: const Text('Connect'),
            ),
          ],
        );
      },
    );
  }
}
