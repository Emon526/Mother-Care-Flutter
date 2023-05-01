import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../providers/themeprovider.dart';
import '../../widget/selectionbuttonwidget.dart';
import 'introduction.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return SafeArea(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Opacity(
                  opacity: 0.2,
                  child: SvgPicture.asset(
                    'assets/images/family.svg',
                    width: boxConstraints.maxWidth,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _logo(
                        context: context,
                        size: size,
                      ),
                      SizedBox(
                        height: size.height * 0.1,
                      ),
                      Text(
                        'Select Language',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _languagetileWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        child: InkWell(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const IntroductionPage(),
                              withNavBar:
                                  false, // OPTIONAL VALUE. True by default.
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                            // PersistentNavBarNavigator.pushDynamicScreen(context,
                            //     screen: CupertinoPageRoute(
                            //       builder: (context) => const PersistentNavBar(),
                            //     ),
                            //     withNavBar: true);
                            // PersistentNavBarNavigator
                            //     .pushNewScreenWithRouteSettings(
                            //   context,
                            //   screen: const PersistentNavBar(),
                            //   settings: const RouteSettings(),
                            // );
                          },
                          borderRadius:
                              BorderRadius.circular(Consts.DefaultBorderRadius),
                          child: const ListTile(
                            title: Text(
                              'Next',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'You can change the language later from the settings',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.black45,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  _logo({
    required BuildContext context,
    required Size size,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: size.height * 0.4,
          // color: Theme.of(context).primaryColor,
          child: Image.asset(
            // color: Theme.of(context).primaryColor,
            'assets/logo.png',
          ),
        ),
        Positioned(
          // bottom: 20,
          child: Text(
            Consts.APP_NAME,
            style: TextStyle(
              fontSize: 24.0,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  _languagetileWidget() {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SelectionButtonWidget(
              buttontitle: 'English',
              // iconCondition: provider.themeMode == ThemeMode.system,
              iconCondition: true,
              ontap: () {
                // provider.themeMode = ThemeMode.system;
              },
            ),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            SelectionButtonWidget(
              // iconCondition: provider.themeMode == ThemeMode.light,
              iconCondition: false,
              buttontitle: 'বাংলা',
              ontap: () {
                // provider.themeMode = ThemeMode.light;
              },
            ),
          ],
        ),
      );
    });
  }
}
