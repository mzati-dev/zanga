import 'package:flutter/material.dart';

// Assuming you have a MarketItem class defined elsewhere,
// for this standalone screen, I'll define a simple one here.
// In your actual project, you would import the existing MarketItem class.
class MarketItem {
  final String name;
  final double originalPrice;
  final double discountedPrice;
  final String image;
  final String location;
  final String postedTime;
  final String category;
  final String condition;

  MarketItem({
    required this.name,
    required this.originalPrice,
    required this.discountedPrice,
    required this.image,
    required this.location,
    required this.postedTime,
    required this.category,
    required this.condition,
  });
}

class TopDealsScreen extends StatelessWidget {
  TopDealsScreen({super.key});

  final List<MarketItem> _topDealsItems = [
    MarketItem(
      name: 'Samsung Galaxy S22',
      originalPrice: 90000,
      discountedPrice: 75000,
      image: 'assets/samsung_s22.jpg', // Make sure you have this asset
      location: 'Blantyre',
      postedTime: '5 hours ago',
      category: 'Electronics',
      condition: 'New',
    ),
    MarketItem(
      name: 'Modern Dining Table',
      originalPrice: 40000,
      discountedPrice: 32000,
      image: 'assets/dining_table.jpg', // Make sure you have this asset
      location: 'Lilongwe',
      postedTime: '1 day ago',
      category: 'Furniture',
      condition: 'Used - Good',
    ),
    MarketItem(
      name: 'Gaming Laptop RTX 3060',
      originalPrice: 150000,
      discountedPrice: 120000,
      image: 'assets/gaming_laptop.jpg', // Make sure you have this asset
      location: 'Mzuzu',
      postedTime: '2 days ago',
      category: 'Electronics',
      condition: 'Like New',
    ),
    MarketItem(
      name: 'Designer Dress',
      originalPrice: 8000,
      discountedPrice: 5000,
      image: 'assets/dress.jpg', // Make sure you have this asset
      location: 'Zomba',
      postedTime: '3 days ago',
      category: 'Fashion',
      condition: 'New with Tags',
    ),
    MarketItem(
      name: 'Mountain Bike',
      originalPrice: 20000,
      discountedPrice: 16000,
      image: 'assets/mountain_bike.jpg', // Make sure you have this asset
      location: 'Salima',
      postedTime: '4 days ago',
      category: 'Sports & Outdoors',
      condition: 'Used - Fair',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _topDealsItems.isEmpty
              ? const Center(child: Text('No top deals available right now.'))
              : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _topDealsItems.length,
                itemBuilder: (context, index) {
                  final item = _topDealsItems[index];
                  return _buildDealItemCard(item);
                },
              ),
    );
  }

  Widget _buildDealItemCard(MarketItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                item.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image, color: Colors.grey),
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
                      fontSize: 18,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'MK ${item.discountedPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.green, // Highlight discounted price
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'MK ${item.originalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          decoration:
                              TextDecoration
                                  .lineThrough, // Strikethrough original price
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
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
                  Text(
                    'Condition: ${item.condition}',
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                ],
              ),
            ),
            // You can add an "Add to Cart" or "View Deal" button here
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.favorite_border,
                    color: Colors.redAccent,
                  ),
                  onPressed: () {
                    print('Favorite ${item.name}');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
