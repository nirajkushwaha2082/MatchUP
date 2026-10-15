import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainNavigationShell extends StatelessWidget {
  const MainNavigationShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF100D15),
            border: Border(top: BorderSide(color: Colors.white.withValues(alpha: .08))),
          ),
          child: NavigationBar(
            height: 68,
            backgroundColor: const Color(0xFF100D15),
            indicatorColor: const Color(0xFF6C3FC8).withValues(alpha: .30),
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) =>
                navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.explore_outlined),
                selectedIcon: Icon(Icons.explore_rounded, color: Color(0xFFFF4D8D)),
                label: 'Discover',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_border_rounded),
                selectedIcon: Icon(Icons.favorite_rounded, color: Color(0xFFFF4D8D)),
                label: 'Matches',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite_outline_rounded),
                selectedIcon: Icon(Icons.favorite_rounded, color: Color(0xFFFF4D8D)),
                label: 'Likes',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline_rounded),
                selectedIcon: Icon(Icons.person_rounded, color: Color(0xFFFF4D8D)),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
