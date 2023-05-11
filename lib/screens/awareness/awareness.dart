import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../providers/nav_bar_provider.dart';

class Awareness extends StatelessWidget {
  const Awareness({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      _buildHeader(
          context: context,
          headerTitle: AppLocalizations.of(context)!.awarenessHeader1Title,
          headerSubtitle:
              AppLocalizations.of(context)!.awarenessHeader1Subtitle,
          imagePath: 'assets/images/body.png'),
      _buildHeader(
          context: context,
          headerTitle: AppLocalizations.of(context)!.awarenessHeader2Title,
          headerSubtitle:
              AppLocalizations.of(context)!.awarenessHeader2Subtitle,
          imagePath: 'assets/images/bca_darkskintype.jpg'),
      _buildHeader(
        context: context,
        headerTitle: AppLocalizations.of(context)!.awarenessHeader3Title,
        headerSubtitle: AppLocalizations.of(context)!.awarenessHeader3Subtitle,
        imagePath: 'assets/images/shutterstock_1797240619.jpg',
      ),
    ];
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                items: items,
                options: CarouselOptions(
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  // enlargeFactor: 0.3,
                  // onPageChanged: callbackFunction,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                // height: 20,
                height: size.height * 0.03,
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.awarenessTitle1,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(
                // height: 10,
                height: size.height * 0.015,
              ),
              Text(
                AppLocalizations.of(context)!.awarenessBody1,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                // height: 10,
                height: size.height * 0.015,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<NavBarProvider>().setControllerIndex = 1;
                },
                child: Text(
                  AppLocalizations.of(context)!.learnmorebutton,
                ),
              ),
              SizedBox(
                // height: 20,
                height: size.height * 0.03,
              ),
              Center(
                child: Text(
                  AppLocalizations.of(context)!.awarenessTitle2,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              SizedBox(
                // height: 10,
                height: size.height * 0.015,
              ),
              Text(
                AppLocalizations.of(context)!.awarenessNote2,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                // height: 10,
                height: size.height * 0.015,
              ),
              Text(
                AppLocalizations.of(context)!.awarenessBody2,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                // height: 20,
                height: size.height * 0.03,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<NavBarProvider>().setControllerIndex = 2;
                },
                child: Text(
                  AppLocalizations.of(context)!.howtoselfcheckbutton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildHeader({
    required String headerTitle,
    required String headerSubtitle,
    required String imagePath,
    required BuildContext context,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage(imagePath),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            headerTitle,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            headerSubtitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
