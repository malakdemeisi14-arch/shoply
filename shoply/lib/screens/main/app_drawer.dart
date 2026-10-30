import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../providers/cart_provider.dart';
import '../../providers/favorites_provider.dart';
import '../../services/auth_service.dart';
import '../../widgets/user_avatar.dart';
import '../account/orders_screen.dart';
import '../account/settings_screen.dart';
import '../auth/login_screen.dart';
import '../info/about_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _open(BuildContext context, Widget page) {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }

  Future<void> _logout(BuildContext context) async {
    final nav = Navigator.of(context);
    final auth = context.read<AuthService>();
    final cart = context.read<CartProvider>();
    final favs = context.read<FavoritesProvider>();
    await auth.signOut();
    cart.clear();
    favs.clear();
    nav.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (r) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<AuthService>().profile;

    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  UserAvatar(url: p?.photoUrl, radius: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p?.fullName ?? 'Guest',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                        Text(p?.email ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.grey)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.receipt_long_outlined),
              title: const Text('My Orders'),
              onTap: () => _open(context, const OrdersScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined),
              title: const Text('Settings'),
              onTap: () => _open(context, const SettingsScreen()),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () => _open(context, const AboutScreen()),
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: AppColors.danger),
              title: const Text('Logout',
                  style: TextStyle(
                      color: AppColors.danger, fontWeight: FontWeight.w600)),
              onTap: () => _logout(context),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
