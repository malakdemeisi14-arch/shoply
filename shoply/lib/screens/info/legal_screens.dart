import 'package:flutter/material.dart';
import '../../core/theme.dart';

class _LegalPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final String heading;
  final List<List<String>> sections;
  final String footer;

  const _LegalPage({
    required this.title,
    required this.icon,
    required this.heading,
    required this.sections,
    required this.footer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(
                  color: AppColors.soft, shape: BoxShape.circle),
              child: Icon(icon, size: 40, color: AppColors.primary),
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Text(heading,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(height: 4),
          const Center(
            child: Text('Last updated: October 16, 2026',
                style: TextStyle(fontSize: 12, color: AppColors.grey)),
          ),
          const SizedBox(height: 20),
          for (int i = 0; i < sections.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${i + 1}. ${sections[i][0]}',
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary)),
                  const SizedBox(height: 4),
                  Text(sections[i][1],
                      style: const TextStyle(
                          fontSize: 13, color: AppColors.grey, height: 1.45)),
                ],
              ),
            ),
          const Divider(),
          Center(
            child: Text(footer,
                style: const TextStyle(fontSize: 11, color: AppColors.grey)),
          ),
        ],
      ),
    );
  }
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LegalPage(
      title: 'Privacy Policy',
      icon: Icons.verified_user_outlined,
      heading: 'Your privacy matters',
      footer: 'Sample policy for UI preview.',
      sections: [
        [
          'Information We Collect',
          'Account details, delivery addresses, and order information help us provide our services.'
        ],
        [
          'How We Use Information',
          'We use information to manage your account, process orders, and respond to support requests.'
        ],
        [
          'Sharing Information',
          'Service providers may receive the information needed to complete your order.'
        ],
        [
          'Your Choices',
          'You can update your profile or contact us about your information.'
        ],
      ],
    );
  }
}

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LegalPage(
      title: 'Terms & Conditions',
      icon: Icons.description_outlined,
      heading: 'Shopping with Shoply',
      footer: 'Sample terms for UI preview.',
      sections: [
        [
          'Using Your Account',
          'Keep your account information accurate and your sign-in details secure.'
        ],
        [
          'Orders & Payments',
          'Review prices, availability, and payment details before placing your order.'
        ],
        [
          'Shipping & Delivery',
          'Delivery estimates and charges are shown during checkout.'
        ],
        [
          'Returns & Refunds',
          'Review the return conditions provided with your order before requesting a return.'
        ],
        [
          'Contact Us',
          'For questions, visit Contact Us in the About section.'
        ],
      ],
    );
  }
}
