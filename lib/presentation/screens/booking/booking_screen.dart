import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../../domain/entities/booking_entity.dart';
import '../../providers/providers.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final String destinationId;

  const BookingScreen({super.key, required this.destinationId});

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  DateTimeRange? _dateRange;
  int _guests = 1;
  bool _isProcessing = false;

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _dateRange = picked);
    }
  }

  Future<void> _confirmBooking(double pricePerNight) async {
    if (_dateRange == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select dates')));
      return;
    }

    setState(() => _isProcessing = true);

    try {
      final user = ref.read(authRepositoryProvider).currentUser;
      if (user == null) throw Exception('User not logged in');

      final nights = _dateRange!.duration.inDays;
      final totalPrice = nights * pricePerNight * _guests;

      final booking = BookingEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: user.uid,
        destinationId: widget.destinationId,
        dateStart: _dateRange!.start,
        dateEnd: _dateRange!.end,
        totalPrice: totalPrice,
        status: BookingStatus.confirmed,
        guests: _guests,
      );

      await ref.read(bookingRepositoryProvider).createBooking(booking);

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: const Text('Booking Confirmed!'),
            content: const Text('Your trip has been booked successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  context.go(AppConstants.routeHome);
                },
                child: const Text('Go Home'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Booking failed: $e')));
      }
    } finally {
      if (mounted) setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final destinationsAsync = ref.watch(destinationsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Book Your Trip')),
      body: destinationsAsync.when(
        data: (destinations) {
          final destination = destinations.firstWhere(
            (e) => e.id == widget.destinationId,
            orElse: () => destinations.first,
          );

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destination.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 32),
                ListTile(
                  title: const Text('Select Dates'),
                  subtitle: Text(
                    _dateRange == null
                        ? 'Tap to select'
                        : '${DateFormat.MMMd().format(_dateRange!.start)} - ${DateFormat.MMMd().format(_dateRange!.end)}',
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: _selectDateRange,
                  tileColor: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Guests'),
                  subtitle: Text('$_guests person(s)'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _guests > 1
                            ? () => setState(() => _guests--)
                            : null,
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => setState(() => _guests++),
                      ),
                    ],
                  ),
                  tileColor: Theme.of(context).cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const Spacer(),
                if (_dateRange != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Price:',
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          '\$${(_dateRange!.duration.inDays * destination.pricePerNight * _guests).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isProcessing
                        ? null
                        : () => _confirmBooking(destination.pricePerNight),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: _isProcessing
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Confirm Booking'),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
