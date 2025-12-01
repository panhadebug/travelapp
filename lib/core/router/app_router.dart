// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/app_constants.dart';
import '../../presentation/providers/providers.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/detail/destination_detail_screen.dart';
import '../../presentation/screens/booking/booking_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppConstants.routeLogin,
    redirect: (context, state) {
      final isLoggedIn = authState.value != null;
      final isLoggingIn = state.uri.toString() == AppConstants.routeLogin;

      if (!isLoggedIn && !isLoggingIn) return AppConstants.routeLogin;
      if (isLoggedIn && isLoggingIn) return AppConstants.routeHome;

      return null;
    },
    routes: [
      GoRoute(
        path: AppConstants.routeLogin,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppConstants.routeHome,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '${AppConstants.routeDetail}/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return DestinationDetailScreen(destinationId: id);
        },
      ),
      GoRoute(
        path: AppConstants.routeBooking,
        builder: (context, state) {
          // Pass extra data if needed, or just use ID
          final extra = state.extra as Map<String, dynamic>?;
          return BookingScreen(destinationId: extra?['destinationId'] ?? '');
        },
      ),
    ],
  );
});
