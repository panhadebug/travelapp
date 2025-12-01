import 'package:equatable/equatable.dart';

class DestinationEntity extends Equatable {
  final String id;
  final String name;
  final String location;
  final String description;
  final double pricePerNight;
  final double rating;
  final List<String> imageUrls;
  final List<String> amenities;

  const DestinationEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.pricePerNight,
    required this.rating,
    required this.imageUrls,
    required this.amenities, required String imageUrl,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    location,
    description,
    pricePerNight,
    rating,
    imageUrls,
    amenities,
  ];
}
