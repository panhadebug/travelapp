import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required super.userId,
    required super.destinationId,
    required super.dateStart,
    required super.dateEnd,
    required super.totalPrice,
    required super.status,
    required super.guests,
  });

  factory BookingModel.fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data() as Map<String, dynamic>;
    return BookingModel(
      id: snap.id,
      userId: data['userId'] ?? '',
      destinationId: data['destinationId'] ?? '',
      dateStart: (data['dateStart'] as Timestamp).toDate(),
      dateEnd: (data['dateEnd'] as Timestamp).toDate(),
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == 'BookingStatus.${data['status']}',
        orElse: () => BookingStatus.pending,
      ),
      guests: data['guests'] ?? 1,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'userId': userId,
      'destinationId': destinationId,
      'dateStart': Timestamp.fromDate(dateStart),
      'dateEnd': Timestamp.fromDate(dateEnd),
      'totalPrice': totalPrice,
      'status': status.name,
      'guests': guests,
    };
  }
}
