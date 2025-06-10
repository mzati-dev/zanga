import 'package:flutter/material.dart';

// New, independent GroupWalletScreen
class GroupWalletScreen extends StatelessWidget {
  const GroupWalletScreen({super.key});

  // List of group wallets (moved here as it's specific to this screen)
  final List<GroupWallet> _groupWallets = const [
    GroupWallet(
      icon:
          Icons
              .account_balance_wallet, // Represents a stack of coins for Village Bank
      name: 'Village Bank',
      type: 'Group',
      amount: 5000.0,
    ),
    GroupWallet(
      icon: Icons.people, // Represents people for Family Fund
      name: 'Family Fund',
      type: 'Fund',
      amount: 12300.0,
    ),
    GroupWallet(
      icon:
          Icons
              .school, // Represents a house for School Mates (using school icon as per image interpretation)
      name: 'School Mates',
      type: 'Group',
      amount: 7600.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image at the top
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            child: Container(
              // The image from your provided UI
              // You'll need to add 'image_61a48b.png' to your pubspec.yaml assets
              // For example:
              // assets:
              //   - assets/images/image_61a48b.png
              child: Image.asset(
                'image_61a48b.png', // Corrected path (assuming it's directly in assets)
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Group Wallet',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Saving together with your community',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _groupWallets.length,
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ), // Padding for the list items
              itemBuilder: (context, index) {
                return _buildGroupWalletItem(_groupWallets[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Action for creating a new group
          print('Create Group Wallet button pressed!');
        },
        label: const Text('Create Group'),
        icon: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30.0,
          ), // Rounded corners for the FAB
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildGroupWalletItem(GroupWallet groupWallet) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: const Color(
                0xFFE0E6D8,
              ), // Light green background from image
              child: Icon(
                groupWallet.icon,
                color: Colors.green[700],
              ), // Darker green icon
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    groupWallet.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    groupWallet.type,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Text(
              '₦${groupWallet.amount.toStringAsFixed(2)}', // Using Naira symbol as in the image
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Data model for Group Wallet (kept separate for clarity)
class GroupWallet {
  final IconData icon;
  final String name;
  final String type; // e.g., "Group", "Fund"
  final double amount;

  const GroupWallet({
    required this.icon,
    required this.name,
    required this.type,
    required this.amount,
  });
}
