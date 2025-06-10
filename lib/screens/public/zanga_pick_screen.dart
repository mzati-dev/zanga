import 'package:flutter/material.dart';

// Define a class for Zanga Pick items
class ZangaPick {
  final String imageUrl;
  final String title;
  final String description;
  final String actionLabel; // e.g., "View Offer", "Shop Now", "Read More"
  final VoidCallback? onTap; // Optional callback for when the pick is tapped

  ZangaPick({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.actionLabel,
    this.onTap,
  });
}

class ZangaPicksScreen extends StatelessWidget {
  ZangaPicksScreen({super.key});

  // Sample Zanga Picks data (this would ideally come from a data source)
  final List<ZangaPick> _zangaPicks = [
    ZangaPick(
      imageUrl: 'assets/offer_banner.jpg', // You'll need to add this asset
      title: 'Mega Summer Sale!',
      description:
          'Get up to 50% off on all electronics this week. Limited time!',
      actionLabel: 'View Offer',
      onTap:
          null, // Example: () => Navigator.push(context, MaterialPageRoute(builder: (context) => OfferDetailsScreen())),
    ),
    ZangaPick(
      imageUrl:
          'assets/business_spotlight.jpg', // You'll need to add this asset
      title: 'Mama Janet\'s Kitchen',
      description:
          'Authentic local dishes, fresh and delicious every day. Try our special sadza!',
      actionLabel: 'Order Now',
      onTap:
          null, // Example: () => Navigator.push(context, MaterialPageRoute(builder: (context) => BusinessProfileScreen())),
    ),
    ZangaPick(
      imageUrl: 'assets/trending_post.jpg', // You'll need to add this asset
      title: 'Top 5 Tips: Saving Money in 2025',
      description:
          'Expert advice to help you achieve financial independence. Read now!',
      actionLabel: 'Read Post',
      onTap:
          null, // Example: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsScreen())),
    ),
    ZangaPick(
      imageUrl: 'assets/mothers_day.jpg', // You'll need to add this asset
      title: 'Mother\'s Day Special',
      description:
          'Find the perfect thoughtful gift for your mom this Mother\'s Day. Don\'t miss out!',
      actionLabel: 'Explore Gifts',
      onTap:
          null, // Example: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CuratedGiftsScreen())),
    ),
    ZangaPick(
      imageUrl: 'assets/community_event.jpg', // You'll need to add this asset
      title: 'Local Job Fair - Zomba',
      description:
          'Connect with local employers and find your next opportunity. June 15th!',
      actionLabel: 'Register',
      onTap:
          null, // Example: () => Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailsScreen())),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _zangaPicks.length,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        final pick = _zangaPicks[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap:
                pick.onTap, // Pass the onTap callback from the ZangaPick object
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      pick.imageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 150,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.image_not_supported,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    pick.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pick.description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: pick.onTap,
                      child: Text(
                        pick.actionLabel,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
