import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/destination_entity.dart';
import '../../domain/repositories/destination_repository.dart';
import '../models/destination_model.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final FirebaseFirestore _firestore;

  DestinationRepositoryImpl(this._firestore);

  @override
  Future<List<DestinationEntity>> getDestinations() async {
    try {
      final snapshot = await _firestore
          .collection('destinations')
          .limit(10)
          .get();
      if (snapshot.docs.isEmpty) {
        return _getMockDestinations();
      }
      return snapshot.docs
          .map((doc) => DestinationModel.fromSnapshot(doc))
          .toList();
    } catch (e) {
      return _getMockDestinations();
    }
  }

  @override
  Future<DestinationEntity?> getDestinationById(String id) async {
    try {
      final doc = await _firestore.collection('destinations').doc(id).get();
      if (doc.exists) {
        return DestinationModel.fromSnapshot(doc);
      }
      return _getMockDestinations().firstWhere((e) => e.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<DestinationEntity>> searchDestinations(String query) async {
    // Simple client-side search for demo (Firestore doesn't support full text search natively)
    final all = await getDestinations();
    return all
        .where(
          (e) =>
              e.name.toLowerCase().contains(query.toLowerCase()) ||
              e.location.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  List<DestinationEntity> _getMockDestinations() {
    return [
      const DestinationEntity(
        id: '1',
        name: 'Bali, Indonesia',
        location: 'Indonesia',
        description:
            'Experience the tropical paradise of Bali with its stunning beaches, vibrant culture, and lush landscapes.',
        pricePerNight: 120.0,
        rating: 4.8,
        imageUrls: [
          'https://images.unsplash.com/photo-1537996194471-e657df975ab4',
          'https://images.unsplash.com/photo-1552733407-5d5c46c3bb3b',
        ],
        amenities: ['Pool', 'WiFi', 'Breakfast', 'Beach Access'],
      ),
      const DestinationEntity(
        id: '2',
        name: 'Paris, France',
        location: 'France',
        description:
            'The City of Light awaits. Visit the Eiffel Tower, Louvre Museum, and enjoy exquisite French cuisine.',
        pricePerNight: 250.0,
        rating: 4.7,
        imageUrls: [
          'https://images.unsplash.com/photo-1502602898657-3e91760cbb34',
          'https://images.unsplash.com/photo-1499856871940-a09627c6d7db',
        ],
        amenities: ['City View', 'WiFi', 'Near Metro', 'Restaurant'],
      ),
      const DestinationEntity(
        id: '3',
        name: 'Kyoto, Japan',
        location: 'Japan',
        description:
            'Discover the ancient temples, traditional tea houses, and beautiful cherry blossoms of Kyoto.',
        pricePerNight: 180.0,
        rating: 4.9,
        imageUrls: [
          'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e',
          'https://images.unsplash.com/photo-1624253321171-1be53e12f5f4',
        ],
        amenities: ['Garden', 'WiFi', 'Onsen', 'Tea Ceremony'],
      ),
    ];
  }
}
