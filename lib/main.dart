import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
// import 'firebase_options.dart'; // Uncomment if using real Firebase

final firebaseInitializedProvider = Provider<bool>((ref) => false);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // ); // Uncomment if using real Firebase

  // For demo purposes, we skip real Firebase init if no options file
  // But we need to handle the fact that FirebaseAuth instance usage will crash without init.
  // In a real scenario, the user must run `flutterfire configure`.
  // Here we will wrap in a try-catch or just assume the user will configure it.

  // Since I cannot run flutterfire configure, I will comment out the actual Firebase init
  // and warn the user. However, the code uses FirebaseAuth.instance.
  // I'll add a dummy init for web or just let it crash if not configured?
  // Better: I'll try to init, if it fails, I'll catch it.

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint("Firebase init failed (expected if not configured): $e");
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Wanderlust',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
