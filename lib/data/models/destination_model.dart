import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/destination_entity.dart';

class DestinationModel extends DestinationEntity {
  const DestinationModel({
    required super.id,
    required super.name,
    required super.location,
    required super.description,
    required super.pricePerNight,
    required super.rating,
    required super.imageUrls,
    required super.amenities,
  });

  factory DestinationModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return DestinationModel(
      id: snap.id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      description: data['description'] ?? '',
      pricePerNight: (data['pricePerNight'] ?? 0).toDouble(),
      rating: (data['rating'] ?? 0).toDouble(),
      imageUrls: List<String>.from(data['imageUrls'] ?? []),
      amenities: List<String>.from(data['amenities'] ?? []),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': name,
      'location': location,
      'description': description,
      'pricePerNight': pricePerNight,
      'rating': rating,
      'imageUrls': imageUrls,
      'amenities': amenities,
    };
  }
}
