import 'package:flutter/material.dart';

// You will likely use your existing MarketItem class from ZMarketScreen.
// For this standalone file, I'll define a simple version.
// In your actual project, you would import the existing MarketItem class.
class MarketItem {
  final String name;
  final double price;
  final String image;
  final String location;
  final String postedTime;
  final String category;
  final String condition;
  final String
  status; // Added for listing status (e.g., 'Active', 'Sold', 'Pending')

  MarketItem({
    required this.name,
    required this.price,
    required this.image,
    required this.location,
    required this.postedTime,
    required this.category,
    required this.condition,
    this.status = 'Active', // Default status
  });
}

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreenState();
}

class _MyListingsScreenState extends State<MyListingsScreen> {
  // Sample data for the user's listings
  final List<MarketItem> _myListings = [
    MarketItem(
      name: 'Samsung TV 4K 55 inch',
      price: 120000,
      image: 'assets/tv.jpg', // Make sure you have this asset
      location: 'Zomba',
      postedTime: '1 day ago',
      category: 'Electronics',
      condition: 'Used - Excellent',
      status: 'Active',
    ),
    MarketItem(
      name: 'Car Wash Service',
      price: 5000,
      image: 'assets/car_wash.jpg', // Make sure you have this asset
      location: 'Zomba',
      postedTime: '3 days ago',
      category: 'Services',
      condition: 'N/A', // Not applicable for services
      status: 'Active',
    ),
    MarketItem(
      name: 'Vintage Bicycle',
      price: 15000,
      image: 'assets/bicycle.jpg', // Make sure you have this asset
      location: 'Zomba',
      postedTime: '1 week ago',
      category: 'Sports & Outdoors',
      condition: 'Used - Good',
      status: 'Sold', // Example of a sold item
    ),
    MarketItem(
      name: 'Handmade Leather Wallet',
      price: 4500,
      image: 'assets/wallet.jpg', // Make sure you have this asset
      location: 'Zomba',
      postedTime: '2 weeks ago',
      category: 'Fashion',
      condition: 'New',
      status: 'Pending', // Example of a pending item
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _myListings.isEmpty
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.list_alt, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'You have no active listings yet!',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Tap the "+" button to create a new listing.',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _myListings.length,
                itemBuilder: (context, index) {
                  final item = _myListings[index];
                  return _buildMyListingCard(item);
                },
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to a screen to add a new listing
          print('Add New Listing button pressed!');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigate to Add New Listing Screen')),
          );
        },
        label: const Text('New Listing'),
        icon: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildMyListingCard(MarketItem item) {
    Color statusColor;
    switch (item.status) {
      case 'Active':
        statusColor = Colors.green;
        break;
      case 'Sold':
        statusColor = Colors.red;
        break;
      case 'Pending':
        statusColor = Colors.orange;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to listing details for editing/viewing
          print('Tapped on ${item.name} listing');
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  item.image,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        width: 90,
                        height: 90,
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'MK ${item.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.deepPurple,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.category,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.category,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.location_on,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.location,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.postedTime,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(), // Pushes status to the right
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            item.status,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      // TODO: Handle edit listing
                      print('Edit ${item.name}');
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      // TODO: Handle delete listing
                      print('Delete ${item.name}');
                      // In a real app, you'd show a confirmation dialog
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
