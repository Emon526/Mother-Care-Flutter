import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

import 'const/consts.dart';
import 'screens/awareness/awareness.dart';
import 'screens/news/newspage.dart';
import 'screens/prediction/scan_page.dart';
import 'screens/settings/settings_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  List<Widget> tabItems = [
    const NewsPage(),
    const Awareness(),
    const ScanScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Consts.APP_NAME,
        ),
      ),
      drawer: const Drawer(),
      body: Center(
        child: tabItems[_selectedIndex],
      ),
      bottomNavigationBar: FlashyTabBar(
        animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        iconSize: 30,
        showElevation: false, // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: const Icon(Icons.newspaper_outlined),
            title: const Text('News'),
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).colorScheme.secondary,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.auto_awesome_outlined),
            title: const Text('Awareness'),
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).colorScheme.secondary,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.analytics_outlined),
            title: const Text('Scan'),
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).colorScheme.secondary,
          ),
          FlashyTabBarItem(
            icon: const Icon(Icons.settings_outlined),
            title: const Text('Settings'),
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Theme.of(context).colorScheme.secondary,
          ),
        ],
      ),
    );
  }
}
