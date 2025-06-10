import 'package:flutter/material.dart';
import 'package:zanga/screens/market/category_screen.dart';
import 'package:zanga/screens/market/top_deals_screen.dart';
import 'package:zanga/screens/market/services_screen.dart';
import 'package:zanga/screens/market/my_listings_screen.dart'; // <--- NEW: Import your independent MyListingsScreen

// Define the enum for market content types
enum MarketContentType { all, categories, topDeals, services, myListings }

class ZMarketScreen extends StatefulWidget {
  // Add a required parameter to specify the content type
  final MarketContentType contentType;

  const ZMarketScreen({super.key, required this.contentType});

  @override
  State<ZMarketScreen> createState() => _ZMarketScreenState();
}

class _ZMarketScreenState extends State<ZMarketScreen> {
  // Your existing list of market items (will be used for 'All' tab)
  final List<MarketItem> _items = [
    MarketItem(
      name: 'iPhone 13 Pro',
      price: 85000,
      image: 'assets/iphone.jpg',
      location: 'Nairobi',
      postedTime: '2 hours ago',
      category: 'Electronics',
      condition: 'Like New',
    ),
    MarketItem(
      name: 'Sofa Set',
      price: 25000,
      image: 'assets/sofa.jpg',
      location: 'Mombasa',
      postedTime: '1 day ago',
      category: 'Furniture',
      condition: 'Used - Good',
    ),
    MarketItem(
      name: 'Canon DSLR Camera',
      price: 45000,
      image: 'assets/camera.jpg',
      location: 'Kisumu',
      postedTime: '3 days ago',
      category: 'Electronics',
      condition: 'Used - Excellent',
    ),
    MarketItem(
      name: 'Men\'s Leather Jacket',
      price: 3500,
      image: 'assets/jacket.jpg',
      location: 'Nakuru',
      postedTime: '1 week ago',
      category: 'Clothing',
      condition: 'New with Tags',
    ),
    MarketItem(
      name: 'Toyota RAV4 2018',
      price: 2800000,
      image: 'assets/car.jpg',
      location: 'Eldoret',
      postedTime: '2 weeks ago',
      category: 'Vehicles',
      condition: 'Used - Excellent',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Determine which content to display based on the contentType passed
    Widget currentContent;
    switch (widget.contentType) {
      case MarketContentType.all:
        currentContent = _buildAllContent();
        break;
      case MarketContentType.categories:
        currentContent =
            const CategoryScreen(); // UPDATED: Return CategoryScreen
        break;
      case MarketContentType.topDeals:
        currentContent = TopDealsScreen(); // UPDATED: Return TopDealsScreen
        break;
      case MarketContentType.services:
        currentContent = ServicesScreen(); // UPDATED: Return ServicesScreen
        break;
      case MarketContentType.myListings:
        currentContent =
            const MyListingsScreen(); // <--- UPDATED: Return MyListingsScreen
        break;
    }

    return currentContent; // Return the specific content for this tab
  }

  // --- Content building methods for each market "endpoint" ---

  Widget _buildAllContent() {
    // This is your original ZMarketScreen content
    return Column(
      children: [
        // Search bar
        // Padding(
        //   padding: const EdgeInsets.all(12),
        //   child: TextField(
        //     decoration: InputDecoration(
        //       hintText: 'Search in Z-Market...',
        //       prefixIcon: const Icon(Icons.search),
        //       border: OutlineInputBorder(
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       contentPadding: const EdgeInsets.symmetric(vertical: 12),
        //     ),
        //   ),
        // ),

        // Filter chips
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 8),
              _buildFilterChip('Near Me'),
              _buildFilterChip('Cheapest'),
              _buildFilterChip('Newest'),
              _buildFilterChip('Verified Sellers'),
              _buildFilterChip('Discounts'),
              const SizedBox(width: 8),
            ],
          ),
        ),

        // Items grid
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _items.length,
            itemBuilder: (context, index) {
              return _buildItemCard(_items[index]);
            },
          ),
        ),
      ],
    );
  }

  // This method now returns the independent CategoryScreen widget
  Widget _buildCategoriesContent() {
    return const CategoryScreen();
  }

  // This method now returns the independent TopDealsScreen widget
  Widget _buildTopDealsContent() {
    return TopDealsScreen();
  }

  // This method now returns the independent ServicesScreen widget
  Widget _buildServicesContent() {
    return ServicesScreen();
  }

  // This method now returns the independent MyListingsScreen widget
  Widget _buildMyListingsContent() {
    return const MyListingsScreen();
  }

  // --- Your existing helper methods (unchanged) ---

  Widget _buildFilterChip(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(label: Text(label), onSelected: (bool value) {}),
    );
  }

  Widget _buildItemCard(MarketItem item) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Item image
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: Image.asset(
                item.image,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
                    ),
              ),
            ),
          ),

          // Item details
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MK ${item.price.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      item.location,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      item.postedTime,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Your MarketItem class remains the same
class MarketItem {
  final String name;
  final double price;
  final String image;
  final String location;
  final String postedTime;
  final String category;
  final String condition;

  MarketItem({
    required this.name,
    required this.price,
    required this.image,
    required this.location,
    required this.postedTime,
    required this.category,
    required this.condition,
  });
}
