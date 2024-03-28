import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../const/consts.dart';
import 'self_check_steps.dart';

class SelfCheckPage extends StatefulWidget {
  const SelfCheckPage({super.key});

  @override
  State<SelfCheckPage> createState() => _SelfCheckPageState();
}

class _SelfCheckPageState extends State<SelfCheckPage> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<Widget> items = [
      _buildDataCard(
        size: size,
        imagepath: 'assets/images/change_1.jpeg',
        title: AppLocalizations.of(context)!.selfCheckInstruction1Title,
        subtitle: AppLocalizations.of(context)!.selfCheckInstruction1Subtitle,
      ),
      _buildDataCard(
        size: size,
        imagepath: 'assets/images/change_2.jpeg',
        title: AppLocalizations.of(context)!.selfCheckInstruction2Title,
        subtitle: AppLocalizations.of(context)!.selfCheckInstruction2Subtitle,
      ),
      _buildDataCard(
        size: size,
        imagepath: 'assets/images/change_3.jpeg',
        title: AppLocalizations.of(context)!.selfCheckInstruction3Title,
        subtitle: AppLocalizations.of(context)!.selfCheckInstruction3Subtitle,
      ),
      _buildDataCard(
        size: size,
        imagepath: 'assets/images/change_4.jpeg',
        title: AppLocalizations.of(context)!.selfCheckInstruction4Title,
        subtitle: AppLocalizations.of(context)!.selfCheckInstruction4Subtitle,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              AppLocalizations.of(context)!.selfCheckInstructionTitle,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Theme.of(context).primaryColor),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CarouselSlider(
                  items: items,
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                    viewportFraction: 0.9,
                    aspectRatio: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < items.length; i++)
                      if (i == _current)
                        Row(
                          children: [
                            Container(
                              width: size.width * 0.07,
                              height: size.width * 0.03,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(
                                    Consts.DefaultBorderRadius),
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                          ],
                        )
                      else
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 5.0,
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                            ),
                            SizedBox(
                              width: size.width * 0.015,
                            ),
                          ],
                        ),
                  ],
                ),
              ],
            ),
            //TODO:: Navvigation animation fix
            ElevatedButton(
              onPressed: () {
                // PersistentNavBarNavigator.pushNewScreen(
                //   context,
                //   screen: const SelfCheckSteps(),
                //   withNavBar: true, // OPTIONAL VALUE. True by default.
                //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
                // );
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelfCheckSteps()));
              },
              child: Text(AppLocalizations.of(context)!.checkyourselfbutton),
            ),
          ],
        ),
      ),
    );
  }

  _buildDataCard({
    required Size size,
    required String imagepath,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
            child: Image.asset(
              imagepath,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Expanded(
            child: Text(
              subtitle,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
