import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoply/exports.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Supabase.initialize(
    url: 'https://bidznsgxncubigikjzdk.supabase.co',
    anonKey: 'sb_publishable_so49GKA_pKKMxg_KqpRAAg_1hoJFGyJ',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoritesProvider()),
      ],
      child: const ShoplyApp(),
    ),
  );
}

class ShoplyApp extends StatelessWidget {
  const ShoplyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoply',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: const SplashScreen(),
    );
  }
}
