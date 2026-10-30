import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme.dart';
import '../../providers/cart_provider.dart';
import 'app_drawer.dart';
import 'cart_tab.dart';
import 'categories_tab.dart';
import 'favorites_tab.dart';
import 'home_tab.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  static const _titles = ['Shoply', 'Categories', 'Favorites', 'My Cart'];

  @override
  Widget build(BuildContext context) {
    final cartCount = context.watch<CartProvider>().count;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: _index == 0
            ? Builder(
                builder: (ctx) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
                ),
              )
            : null,
        title: Text(
          _titles[_index],
          style: _index == 0
              ? const TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w800)
              : null,
        ),
        actions: _index == 0
            ? [
                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  onPressed: () {},
                ),
              ]
            : null,
      ),
      drawer: const AppDrawer(),
      drawerEnableOpenDragGesture: _index == 0,
      body: IndexedStack(
        index: _index,
        children: [
          HomeTab(onSeeCategories: () => setState(() => _index = 1)),
          const CategoriesTab(),
          const FavoritesTab(),
          const CartTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        selectedFontSize: 11,
        unselectedFontSize: 11,
        backgroundColor: Colors.white,
        items: [
          const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view_rounded),
              label: 'Categories'),
          const BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              activeIcon: Icon(Icons.favorite),
              label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Badge(
                label: Text('$cartCount'),
                isLabelVisible: cartCount > 0,
                child: const Icon(Icons.shopping_cart_outlined),
              ),
              activeIcon: Badge(
                label: Text('$cartCount'),
                isLabelVisible: cartCount > 0,
                child: const Icon(Icons.shopping_cart),
              ),
              label: 'Cart'),
        ],
      ),
    );
  }
}
