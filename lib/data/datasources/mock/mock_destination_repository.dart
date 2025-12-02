import '../../../domain/entities/destination_entity.dart';
import '../../../domain/repositories/destination_repository.dart';

class MockDestinationRepository implements DestinationRepository {
  final List<DestinationEntity> _destinations = [
    const DestinationEntity(
      id: '1',
      name: 'Bali, Indonesia',
      description:
          'Experience the tropical paradise of Bali with its beautiful beaches and vibrant culture.',
      imageUrls: [
        'https://images.unsplash.com/photo-1537996194471-e657df975ab4',
      ],
      rating: 4.8,
      pricePerNight: 120.0,
      location: 'Indonesia',
      amenities: ['Pool', 'WiFi', 'Beach Access'],
    ),
    const DestinationEntity(
      id: '2',
      name: 'Paris, France',
      description:
          'The city of love, art, and gastronomy. Visit the Eiffel Tower and Louvre Museum.',
      imageUrls: [
        'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
      ],
      rating: 4.7,
      pricePerNight: 250.0,
      location: 'France',
      amenities: ['City View', 'WiFi', 'Museum'],
    ),
    const DestinationEntity(
      id: '3',
      name: 'Kyoto, Japan',
      description:
          'Discover ancient temples, traditional tea houses, and beautiful cherry blossoms.',
      imageUrls: [
        'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e',
      ],
      rating: 4.9,
      pricePerNight: 180.0,
      location: 'Japan',
      amenities: ['Garden', 'WiFi', 'Tea Ceremony'],
    ),
    const DestinationEntity(
      id: '4',
      name: 'Santorini, Greece',
      description:
          'Stunning sunsets, white-washed houses, and crystal clear waters.',
      imageUrls: [
        'https://images.unsplash.com/photo-1613395877344-13d4c280d288',
      ],
      rating: 4.8,
      pricePerNight: 300.0,
      location: 'Greece',
      amenities: ['Sea View', 'WiFi', 'Pool'],
    ),
    const DestinationEntity(
      id: '5',
      name: 'New York City, USA',
      description:
          'The city that never sleeps. Times Square, Central Park, and Broadway.',
      imageUrls: [
        'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9',
      ],
      rating: 4.6,
      pricePerNight: 280.0,
      location: 'USA',
      amenities: ['City View', 'WiFi', 'Gym'],
    ),
  ];

  @override
  Future<List<DestinationEntity>> getDestinations() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _destinations;
  }

  @override
  Future<DestinationEntity?> getDestinationById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      return _destinations.firstWhere((e) => e.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<DestinationEntity>> searchDestinations(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final lowerQuery = query.toLowerCase();
    return _destinations
        .where(
          (d) =>
              d.name.toLowerCase().contains(lowerQuery) ||
              d.location.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }
}
