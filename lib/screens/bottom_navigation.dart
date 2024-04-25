import 'package:flutter/material.dart';
import 'package:recipes/screens/favorites_screen.dart';
import 'package:recipes/screens/home_screen.dart';
import 'package:recipes/screens/profile_screen.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _selectedPage = 0;

  void _selectedIndex(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const HomeScreen();

    if (_selectedPage == 1) {
      mainContent = const FavoritesScreen();
    }

    if (_selectedPage == 2) {
      mainContent = const ProfileScreen();
    }

    return Scaffold(
      body: mainContent,
      bottomNavigationBar: NavigationBar(
        indicatorColor: const Color(0xfffe8d15),
        surfaceTintColor: Colors.white,
        animationDuration: const Duration(milliseconds: 30),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.favorite_border_outlined),
              selectedIcon: Icon(Icons.favorite),
              label: 'Favorites'),
          NavigationDestination(
              icon: Icon(Icons.person_outlined),
              selectedIcon: Icon(Icons.person),
              label: 'Profile'),
        ],
        selectedIndex: _selectedPage,
        onDestinationSelected: _selectedIndex,
      ),
    );
  }
}
