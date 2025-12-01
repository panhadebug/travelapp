import 'package:equatable/equatable.dart';

enum BookingStatus { confirmed, pending, cancelled }

class BookingEntity extends Equatable {
  final String id;
  final String userId;
  final String destinationId;
  final DateTime dateStart;
  final DateTime dateEnd;
  final double totalPrice;
  final BookingStatus status;
  final int guests;

  const BookingEntity({
    required this.id,
    required this.userId,
    required this.destinationId,
    required this.dateStart,
    required this.dateEnd,
    required this.totalPrice,
    required this.status,
    required this.guests,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    destinationId,
    dateStart,
    dateEnd,
    totalPrice,
    status,
    guests,
  ];
}
