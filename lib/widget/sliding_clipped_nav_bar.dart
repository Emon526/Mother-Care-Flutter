import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

import '../providers/nav_bar_provider.dart';
import '../providers/themeprovider.dart';
import '../screens/awareness/awareness.dart';
import '../screens/breastcancer/breastcancer.dart';
import '../screens/selfcheck/self_check_page.dart';
import '../utils/utils.dart';
import 'drawer_widget.dart';

class SlidingClippedNavBarWidget extends StatefulWidget {
  const SlidingClippedNavBarWidget({super.key});

  @override
  SlidingClippedNavBarWidgetState createState() =>
      SlidingClippedNavBarWidgetState();
}

class SlidingClippedNavBarWidgetState
    extends State<SlidingClippedNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarProvider>(builder: (context, navbarprovider, child) {
      return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          if (navbarprovider.selectedIndex != 0) {
            navbarprovider.selectedIndex = 0;
            return navbarprovider.changePage(selectedIndex: 0);
          } else {
            return Utils(context).onWillPop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.appname,
            ),
          ),
          drawer: const DrawerWidget(),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: navbarprovider.pageController,
            children: const [
              Awareness(),
              BreastCancerPage(),
              SelfCheckPage(),
            ],
          ),
          bottomNavigationBar:
              Consumer<ThemeProvider>(builder: (context, themeprovider, child) {
            return SlidingClippedNavBar(
              onButtonPressed: (index) {
                navbarprovider.selectedIndex = index;
              },
              activeColor: Theme.of(context).primaryColor,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              selectedIndex: navbarprovider.selectedIndex,
              barItems: <BarItem>[
                BarItem(
                  icon: Icons.auto_awesome_outlined,
                  title: AppLocalizations.of(context)!.awareness,
                ),
                BarItem(
                  icon: Icons.coronavirus_outlined,
                  title: AppLocalizations.of(context)!.breastcancer,
                ),
                BarItem(
                  icon: Icons.medical_information_outlined,
                  title: AppLocalizations.of(context)!.selfcheck,
                ),
              ],
            );
          }),
        ),
      );
    });
  }
}
