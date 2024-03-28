// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
// import 'package:provider/provider.dart';
// import '../providers/nav_bar_provider.dart';
// import '../screens/awareness/awareness.dart';
// import '../screens/breastcancer/breastcancer.dart';
// import '../screens/selfcheck/self_check_page.dart';
// import '../utils/utils.dart';
// import 'drawer_widget.dart';

// class PersistentNavBar extends StatelessWidget {
//   const PersistentNavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     //final controller = context.read<NavBarProvider>().controller;

//     return Consumer<NavBarProvider>(builder: (context, navbarprovider, child) {
//       log(navbarprovider.controller.index.toString());

//       return PopScope(
//         canPop: false,
//         onPopInvoked: (bool didPop) {
//           log(navbarprovider.controller.index.toString(),
//               name: "nav bar index");
//           if (navbarprovider.controller.index != 0) {
//             log('Jump to tab', name: "nav bar");
//             return navbarprovider.controller.jumpToTab(0);
//             // Jump to the first tab if not already there
//             // Do not pop the current route
//           } else {
//             log('on will pop', name: "nav bar");
//             return Utils(context)
//                 .onWillPop(); // Allow popping the current route
//           }
//           // controller.index != 0
//           //     ? controller.jumpToTab(0)
//           //     :
//           // Utils(context).onWillPop();
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(
//               AppLocalizations.of(context)!.appname,
//             ),
//           ),
//           drawer: const DrawerWidget(),
//           body: SafeArea(
//             child: PersistentTabView(
//               context,
//               backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//               controller: navbarprovider.controller,
//               screens: const [
//                 Awareness(),
//                 BreastCancerPage(),
//                 SelfCheckPage(),
//               ],
//               onItemSelected: (value) =>
//                   navbarprovider.setControllerIndex = value,
//               items: _navBarsItems(context),
//               itemAnimationProperties: const ItemAnimationProperties(
//                 duration: Duration(
//                   milliseconds: 500,
//                 ),
//                 curve: Curves.easeIn,
//               ),
//               navBarStyle: NavBarStyle.style1,
//             ),
//           ),
//         ),
//       );
//     });
//   }

//   List<PersistentBottomNavBarItem> _navBarsItems(BuildContext context) {
//     return [
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.auto_awesome_outlined),
//         title: AppLocalizations.of(context)!.awareness,
//         activeColorPrimary: Theme.of(context).primaryColor,
//         inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.coronavirus_outlined),
//         title: AppLocalizations.of(context)!.breastcancer,
//         activeColorPrimary: Theme.of(context).primaryColor,
//         inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
//       ),
//       PersistentBottomNavBarItem(
//         icon: const Icon(Icons.medical_information_outlined),
//         title: AppLocalizations.of(context)!.selfcheck,
//         activeColorPrimary: Theme.of(context).primaryColor,
//         inactiveColorPrimary: Theme.of(context).colorScheme.secondary,
//       ),
//     ];
//   }
// }
