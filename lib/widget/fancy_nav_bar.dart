// // import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
// import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
// import 'package:flutter/material.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:provider/provider.dart';

// import 'const/consts.dart';
// import 'providers/modelprovider.dart';
// import 'providers/nav_bar_provider.dart';
// import 'providers/themeprovider.dart';
// import 'screens/awareness/awareness.dart';
// import 'screens/breastcancer/breastcancer.dart';
// import 'screens/screening/memmography.dart';
// import 'screens/selfcheck/self_check_page.dart';
// import 'widget/themetile.dart';

// class NavBar extends StatelessWidget {
//   const NavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> tabItems = [
//       const Awareness(),
//       const BreastCancerPage(),
//       const SelfCheckPage(),
//     ];
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           Consts.APP_NAME,
//         ),
//       ),
//       drawer: _buildDrawer(
//         context: context,
//       ),
//       body: Center(
//         child: tabItems[context.watch<NavBarProvider>().selectedIndex],
//       ),
//       bottomNavigationBar: FlashyTabBar(
//         animationCurve: Curves.linear,
//         selectedIndex: context.watch<NavBarProvider>().selectedIndex,
//         iconSize: 30,
//         showElevation: false, // use this to remove appBar's elevation
//         onItemSelected: (index) {
//           context.read<NavBarProvider>().selectedIndex = index;
//         },
//         items: [
//           FlashyTabBarItem(
//             icon: const Icon(Icons.auto_awesome_outlined),
//             title: const Text('Awareness'),
//             activeColor: Theme.of(context).primaryColor,
//             inactiveColor: Theme.of(context).colorScheme.secondary,
//           ),
//           FlashyTabBarItem(
//             icon: const Icon(Icons.coronavirus_outlined),
//             title: const Text('Breast Cancer'),
//             activeColor: Theme.of(context).primaryColor,
//             inactiveColor: Theme.of(context).colorScheme.secondary,
//           ),
//           FlashyTabBarItem(
//             icon: const Icon(Icons.medical_information_outlined),
//             title: const Text('Self Check'),
//             activeColor: Theme.of(context).primaryColor,
//             inactiveColor: Theme.of(context).colorScheme.secondary,
//           ),
//         ],
//       ),
//     );
//   }

//   _buildDrawer({
//     required BuildContext context,
//   }) {
//     return Drawer(
//       width: 250,
//       child: SafeArea(
//         child: Column(
//           children: [
//             Container(
//               color: Theme.of(context).primaryColor,
//               height: 200,
//               width: double.infinity,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'Mr. Asraful Islam',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       'Emonats526@gmai.com',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       'Dhaka, Bangladesh',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             _buildListtile(
//               iconData: LineIcons.calendarAlt,
//               tiletitle: 'Reminder',
//               onTap: () {},
//             ),
//             _buildListtile(
//               iconData: Icons.insights_outlined,
//               tiletitle: 'Memmography Screening',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const MemmographyPrediction(),
//                   ),
//                 );
//               },
//             ),
//             _buildListtile(
//               iconData: LineIcons.stethoscope,
//               tiletitle: 'Doctors',
//               onTap: () {},
//             ),
//             _buildListtile(
//               iconData: Icons.mobile_friendly,
//               tiletitle: 'Delete Model',
//               onTap: () {
//                 context.read<ModelProvider>().deleteModel();
//               },
//             ),
//             _buildListtile(
//               tiletitle: 'Theme',
//               iconData: context.watch<ThemeProvider>().themeMode ==
//                       ThemeMode.system
//                   ? Icons.phonelink_setup_outlined
//                   : context.watch<ThemeProvider>().themeMode == ThemeMode.light
//                       ? Icons.light_mode_outlined
//                       : Icons.dark_mode_outlined,
//               onTap: () => showDialog<void>(
//                 context: context,
//                 barrierDismissible: false,
//                 builder: (BuildContext context) {
//                   return const ThemeTile();
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   _buildListtile({
//     required IconData iconData,
//     required String tiletitle,
//     required Function onTap,
//   }) {
//     return Card(
//       child: InkWell(
//         onTap: () {
//           onTap();
//         },
//         child: ListTile(
//           title: Text(tiletitle),
//           trailing: Icon(iconData),
//         ),
//       ),
//     );
//   }
// }
