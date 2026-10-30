import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/app_logo.dart';
import 'auth/login_screen.dart';
import 'auth/onboarding_screen.dart';
import 'main/main_shell.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _go();
  }

  Future<void> _go() async {
    await Future.delayed(const Duration(seconds: 2));
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('onboarding_seen') ?? false;
    final loggedIn = FirebaseAuth.instance.currentUser != null;
    if (!mounted) return;
    final Widget next = loggedIn
        ? const MainShell()
        : (seen ? const LoginScreen() : const OnboardingScreen());
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => next));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: AppLogo(size: 72)));
  }
}
