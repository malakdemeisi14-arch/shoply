import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../info/about_screen.dart';
import 'change_password_screen.dart';
import 'update_profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Widget _tile(BuildContext context, IconData icon, String title, Widget page) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.field, borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, size: 22),
        title: Text(title, style: const TextStyle(fontSize: 14)),
        trailing: const Icon(Icons.chevron_right, color: AppColors.grey),
        onTap: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _tile(context, Icons.person_outline, 'Update Profile',
              const UpdateProfileScreen()),
          _tile(context, Icons.lock_outline, 'Update Password',
              const ChangePasswordScreen()),
          _tile(context, Icons.info_outline, 'About', const AboutScreen()),
        ],
      ),
    );
  }
}
