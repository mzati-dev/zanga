import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  // Define your market categories
  final List<Map<String, dynamic>> categories = const [
    {'name': 'Electronics', 'icon': Icons.electrical_services},
    {'name': 'Vehicles', 'icon': Icons.directions_car},
    {'name': 'Home & Garden', 'icon': Icons.home},
    {'name': 'Fashion', 'icon': Icons.checkroom},
    {'name': 'Sports & Outdoors', 'icon': Icons.sports_baseball},
    {'name': 'Books, Movies & Music', 'icon': Icons.library_books},
    {'name': 'Collectibles & Art', 'icon': Icons.palette},
    {'name': 'Business & Industrial', 'icon': Icons.business},
    {'name': 'Health & Beauty', 'icon': Icons.spa},
    {'name': 'Toys & Hobbies', 'icon': Icons.toys},
    {'name': 'Pet Supplies', 'icon': Icons.pets},
    {'name': 'Services', 'icon': Icons.room_service},
    {'name': 'Real Estate', 'icon': Icons.apartment},
    {'name': 'Other', 'icon': Icons.category},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 3 columns for categories
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8, // Adjust as needed for better icon/text fit
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(
              icon: category['icon'] as IconData,
              name: category['name'] as String,
              onTap: () {
                // Handle category tap, e.g., navigate to a screen displaying items for this category
                print('Tapped on ${category['name']}');
                // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryItemsScreen(category: category['name'])));
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String name,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              //color: Theme.of(context).primaryColor, // Use theme primary color
            ),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
