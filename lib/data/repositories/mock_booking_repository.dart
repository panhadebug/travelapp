import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';

class MockBookingRepository implements BookingRepository {
  final List<BookingEntity> _bookings = [];

  @override
  Future<void> createBooking(BookingEntity booking) async {
    await Future.delayed(const Duration(seconds: 1));
    _bookings.add(booking);
  }

  @override
  Future<List<BookingEntity>> getUserBookings(String userId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _bookings.where((b) => b.userId == userId).toList();
  }
}
