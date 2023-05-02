import 'package:flutter/material.dart';
import 'package:mothercare/utils/utils.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../const/consts.dart';
import '../providers/nav_bar_provider.dart';
import '../screens/awareness/awareness.dart';
import '../screens/breastcancer/breastcancer.dart';
import '../screens/selfcheck/self_check_page.dart';
import 'drawer_widget.dart';

class PersistentNavBar extends StatelessWidget {
  const PersistentNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Consts.APP_NAME,
        ),
      ),
      drawer: const DrawerWidget(),
      body: SafeArea(
        child: PersistentTabView(
          context,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          controller: context.watch<NavBarProvider>().controller,
          screens: const [
            Awareness(),
            BreastCancerPage(),
            SelfCheckPage(),
          ],
          items: _navBarsItems(context),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(
              milliseconds: 500,
            ),
            curve: Curves.easeIn,
          ),
          navBarStyle: NavBarStyle.style1,
        ),
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.auto_awesome_outlined),
        title: "Awareness",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.coronavirus_outlined),
        title: "Breast Cancer",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.medical_information_outlined),
        title: "Self Check",
        activeColorPrimary: Theme.of(context).primaryColor,
        inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
      ),
    ];
  }
}
