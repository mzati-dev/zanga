import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String? _selectedCategory; // Holds the currently selected category

  final List<String> _categories = const [
    'Jobs',
    'Education',
    'Religion',
    'Business',
    'Agriculture',
    'Health',
    'Sports',
    'Entertainment',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Select a Category',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            value: _selectedCategory,
            hint: const Text('Choose a category'),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
                // Here, you would typically filter content or navigate
                // based on the selected category.
                print('Selected category: $_selectedCategory');
              });
            },
            items:
                _categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
          ),
        ),
        const Divider(),
        Expanded(
          child:
              _selectedCategory == null
                  ? const Center(
                    child: Text(
                      'Please select a category to see relevant content.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                  : _buildCategoryContent(_selectedCategory!),
        ),
      ],
    );
  }

  // A placeholder method to build content based on the selected category
  Widget _buildCategoryContent(String category) {
    // In a real app, this would dynamically load content (e.g., posts, businesses)
    // related to the selected category.
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.category, size: 60, color: Colors.blueAccent),
            const SizedBox(height: 16),
            Text(
              'Displaying content for "$category"',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Here you would show posts, businesses, or information related to $category in Zomba, Malawi.',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                // Example action: Navigate to a dedicated search page for the category
                print('Search more in $category');
              },
              icon: const Icon(Icons.search),
              label: const Text('Explore More'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
