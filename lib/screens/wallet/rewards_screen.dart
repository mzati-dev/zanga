import 'package:flutter/material.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // Background color of the Rewards screen from the image
        color: const Color(
          0xFFE8F5E9,
        ).withOpacity(0.4), // A light cream/green tint
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Zanga Rewards Header
            const Text(
              'Zanga Rewards',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            // Reward Points
            const Text(
              'Reward Points',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            const Text(
              '3,750',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),

            // Earn/Redeem Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print('Earn button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // White background
                      foregroundColor: Colors.black, // Black text
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Rounded corners
                        side: BorderSide(
                          color: Colors.grey.shade300,
                        ), // Light grey border
                      ),
                      elevation: 0, // No shadow
                    ),
                    child: const Text('Earn', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print('Redeem button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // White background
                      foregroundColor: Colors.black, // Black text
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          10,
                        ), // Rounded corners
                        side: BorderSide(
                          color: Colors.grey.shade300,
                        ), // Light grey border
                      ),
                      elevation: 0, // No shadow
                    ),
                    child: const Text('Redeem', style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Ways to earn points header
            const Text(
              'Ways to earn points',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),

            // List of earning methods
            _buildEarnPointItem(
              icon: Icons.public, // Globe icon for 'Create a reel'
              title: 'Create a reel',
              points: '+1,000',
            ),
            _buildEarnPointItem(
              icon: Icons.people, // People icon for 'Join a group'
              title: 'Join a group',
              points: '+500',
            ),
            _buildEarnPointItem(
              icon: Icons.bar_chart, // Bar chart icon for 'Refer a friend'
              title: 'Refer a friend',
              points: '+200',
            ),
            _buildEarnPointItem(
              icon:
                  Icons.trending_up, // Trending up icon for 'Engage in groups'
              title: 'Engage in groups',
              points: '+75',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarnPointItem({
    required IconData icon,
    required String title,
    required String points,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 0, // No shadow as per image
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      color: Colors.white, // White card background
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(
                0xFFE8F5E9,
              ), // Light background for icon
              child: Icon(icon, color: Colors.green[700]), // Green icon color
            ),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Text(
              points,
              style: const TextStyle(
                fontSize: 16,
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
