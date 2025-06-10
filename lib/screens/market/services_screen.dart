import 'package:flutter/material.dart';

// A simple class to represent a service
class ServiceItem {
  final String name;
  final String description;
  final String provider;
  final String location;
  final double rating;
  final String imageUrl;
  final String priceRange;
  final String postedTime; // Added postedTime for consistency

  ServiceItem({
    required this.name,
    required this.description,
    required this.provider,
    required this.location,
    required this.rating,
    required this.imageUrl,
    required this.priceRange,
    required this.postedTime,
  });
}

class ServicesScreen extends StatelessWidget {
  ServicesScreen({super.key});

  final List<ServiceItem> _services = [
    ServiceItem(
      name: 'Home Cleaning Service',
      description: 'Professional home cleaning for a sparkling home.',
      provider: 'Sparkle Cleaners',
      location: 'Blantyre',
      rating: 4.8,
      imageUrl: 'assets/cleaning_service.jpg', // Make sure you have this asset
      priceRange: 'MK 15,000 - 30,000',
      postedTime: '3 hours ago',
    ),
    ServiceItem(
      name: 'IT Support & Repair',
      description: 'Computer repair, network setup, and technical support.',
      provider: 'TechFix Solutions',
      location: 'Lilongwe',
      rating: 4.5,
      imageUrl: 'assets/it_support.jpg', // Make sure you have this asset
      priceRange: 'MK 5,000 - 20,000',
      postedTime: '1 day ago',
    ),
    ServiceItem(
      name: 'Photography Services',
      description:
          'Capturing your special moments (weddings, portraits, events).',
      provider: 'LensCrafters Studio',
      location: 'Zomba',
      rating: 4.9,
      imageUrl:
          'assets/photography_service.jpg', // Make sure you have this asset
      priceRange: 'MK 25,000 - 100,000+',
      postedTime: '2 days ago',
    ),
    ServiceItem(
      name: 'Tutoring Services (Math & Science)',
      description: 'Experienced tutors for primary and secondary education.',
      provider: 'Brilliant Minds Tutors',
      location: 'Mzuzu',
      rating: 4.7,
      imageUrl: 'assets/tutoring_service.jpg', // Make sure you have this asset
      priceRange: 'MK 3,000/hr',
      postedTime: '5 days ago',
    ),
    ServiceItem(
      name: 'Gardening & Landscaping',
      description:
          'Transform your garden with our expert landscaping services.',
      provider: 'Green Thumb Gardens',
      location: 'Kasungu',
      rating: 4.6,
      imageUrl: 'assets/gardening_service.jpg', // Make sure you have this asset
      priceRange: 'MK 10,000 - 50,000',
      postedTime: '1 week ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          _services.isEmpty
              ? const Center(child: Text('No services listed at the moment.'))
              : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  final service = _services[index];
                  return _buildServiceCard(service);
                },
              ),
    );
  }

  Widget _buildServiceCard(ServiceItem service) {
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
                service.imageUrl,
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
                    service.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service.provider,
                    style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${service.rating}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
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
                        service.location,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Price: ${service.priceRange}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service.description,
                    style: const TextStyle(fontSize: 13, color: Colors.black87),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
                        service.postedTime,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
