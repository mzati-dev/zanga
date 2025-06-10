import 'package:flutter/material.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // Use SingleChildScrollView for scrollability
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Track Your Financial Trends & Patterns',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),

            // Summary Cards (Total Spending, Total Income, Net Balance)
            Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: 'Total Spending\nThis month',
                    amount: 'MK 150,000',
                    icon: Icons.keyboard_arrow_down,
                    iconColor: Colors.blue, // As per image
                    borderColor: Colors.blue, // As per image
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: 'Total Income\nThis month',
                    amount: 'MK 200,000',
                    icon: Icons.keyboard_arrow_up,
                    iconColor: Colors.green, // As per image
                    borderColor: Colors.transparent, // No border as per image
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildSummaryCard(
                    context,
                    title: 'Net Balance',
                    amount: 'MK 50,000',
                    icon: Icons.scale, // Scale icon for balance
                    iconColor: Colors.black, // Default color for balance icon
                    borderColor: Colors.transparent, // No border as per image
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Expense Trend Chart
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Expense Trend',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text('Month'),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Year'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Placeholder for the graph
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'Screenshot 2025-06-09 152634.png', // Using the provided image as a placeholder for the graph part
                        fit: BoxFit.cover,
                      ),
                      // You'd replace this with a charting library widget like fl_chart or charts_flutter
                      // For example: LineChart(...)
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // AI Insights
            const Text(
              'AI Insights',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildInsightPoint('You spend 30% more on weekends'),
            _buildInsightPoint(
              'Transport expenses increased by 18% this month',
            ),
            _buildInsightPoint('You\'re on track to hit your savings goal'),
            const SizedBox(height: 20),

            // Spending by Category
            const Text(
              'Spending by Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategoryItem('Food', '35%', Colors.green),
                      _buildCategoryItem('Transport', '20%', Colors.blue),
                      _buildCategoryItem('Entertainment', '15%', Colors.orange),
                      _buildCategoryItem('Bills', '15%', Colors.red),
                      _buildCategoryItem('Other', '15%', Colors.purple),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 120, // Adjust height as needed
                    width: 120, // Adjust width as needed
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                      // Placeholder for pie chart, could be a custom painter or a charting library
                      image: const DecorationImage(
                        image: AssetImage(
                          'Screenshot 2025-06-09 152634.png',
                        ), // Using the image as a pie chart placeholder
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Group Wallet Summary
            const Text(
              'Group Wallet Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Top contributing group: Family Vault',
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                    Text(
                      'Most active group: School Fund',
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle download report
                    print('Download Report button pressed!');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Button color
                    foregroundColor: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Download Report'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String amount,
    required IconData icon,
    required Color iconColor,
    Color? borderColor,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: borderColor ?? Colors.transparent,
          width: borderColor != null ? 2.0 : 0.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(icon, color: iconColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.circle, size: 8, color: Colors.black),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String category, String percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(Icons.circle, size: 12, color: color),
          const SizedBox(width: 8),
          Text(category, style: const TextStyle(fontSize: 15)),
          const Spacer(),
          Text(percentage, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}
