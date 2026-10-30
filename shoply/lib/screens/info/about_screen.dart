import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../../widgets/app_logo.dart';
import 'contact_screen.dart';
import 'legal_screens.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Widget _tile(BuildContext context, IconData icon, String title, Widget page) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.field, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 20),
        title: Text(title, style: const TextStyle(fontSize: 13)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.grey),
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 16),
          const Center(child: AppLogo(size: 72)),
          const SizedBox(height: 8),
          const Center(
            child: Text('Version 1.0.0',
                style: TextStyle(fontSize: 12, color: AppColors.grey)),
          ),
          const SizedBox(height: 6),
          const Center(
            child: Text('Your everyday shopping\ncompanion.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: AppColors.grey)),
          ),
          const SizedBox(height: 32),
          _tile(context, Icons.mail_outline, 'Contact Us', const ContactScreen()),
          _tile(context, Icons.description_outlined, 'Privacy Policy',
              const PrivacyScreen()),
          _tile(context, Icons.info_outline, 'Terms & Conditions',
              const TermsScreen()),
          const SizedBox(height: 24),
          const Center(
            child: Text('Made for better shopping.',
                style: TextStyle(fontSize: 11, color: AppColors.grey)),
          ),
        ],
      ),
    );
  }
}
