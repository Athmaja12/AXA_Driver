import 'package:axa_driver/core/services/location_service.dart';
import 'package:axa_driver/core/theme/apptheme.dart';
import 'package:axa_driver/core/services/routers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'core/services/update_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // ── Firebase init ──────────────────────────────────────────────────────────
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('[Main] Firebase init failed: $e');
  }

  // ── FCM init ───────────────────────────────────────────────────────────────
  // try {
  //   await FcmService.instance.init();
  // } catch (e) {
  //   print('[Main] FCM init failed: $e');
  // }

  // ── Location service init ──────────────────────────────────────────────────
  try {
    await initLocationService();
  } catch (e) {
    print('[Main] Location service init failed: $e');
  }

  runApp(const MyApp());

  WidgetsBinding.instance.addPostFrameCallback((_) {
    // Check for app updates after the first frame is rendered
    UpdateService.checkForUpdate();
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-check update when user comes back to the app
    if (state == AppLifecycleState.resumed) {
      UpdateService.checkForUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AXA Driver',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
