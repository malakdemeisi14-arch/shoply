import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme.dart';
import '../../widgets/primary_button.dart';
import 'login_screen.dart';

class _Info {
  final String image;
  final String title;
  final String sub;
  const _Info(this.image, this.title, this.sub);
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _pages = [
    _Info('assets/images/onboard_1.png', 'Discover\nAmazing Products',
        'Find everything you need in one place.'),
    _Info('assets/images/onboard_2.png', 'Shop Your Style',
        'Top brands, great prices and the latest trends.'),
    _Info('assets/images/onboard_3.png', 'Fast & Safe Delivery',
        'Get your orders delivered right to your doorstep.'),
  ];

  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
    if (!mounted) return;
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  void _next() {
    if (_page == _pages.length - 1) {
      _finish();
    } else {
      _controller.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final last = _page == _pages.length - 1;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) {
                  final p = _pages[i];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(p.image, fit: BoxFit.contain),
                        ),
                        const SizedBox(height: 24),
                        Text(p.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 10),
                        Text(p.sub,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 14, color: AppColors.grey)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _page ? 18 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: i == _page ? AppColors.primary : const Color(0xFFD5D9D6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: PrimaryButton(
                  label: last ? 'Get Started' : 'Next', onPressed: _next),
            ),
            SizedBox(
              height: 44,
              child: last
                  ? null
                  : TextButton(
                      onPressed: _finish,
                      child: const Text('Skip',
                          style: TextStyle(color: AppColors.grey)),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
