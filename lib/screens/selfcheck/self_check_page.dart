import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../const/consts.dart';
import '../../providers/selfcheckprovider.dart';
import '../../utils/utils.dart';
import '../../widget/selfcheckdatawidget.dart';
import 'self_check_steps.dart';

class SelfCheckPage extends StatelessWidget {
  const SelfCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    List<Widget> items = [
      SelfCheckDataWidget(
        imagePath: 'assets/images/change_1.jpeg',
        title: AppLocalizations.of(context)!.selfCheckInstruction1Title,
        subTitle: AppLocalizations.of(context)!.selfCheckInstruction1Subtitle,
      ),
      SelfCheckDataWidget(
        imagePath: 'assets/images/change_2.jpeg',
        title: AppLocalizations.of(context)!.selfCheckInstruction2Title,
        subTitle: AppLocalizations.of(context)!.selfCheckInstruction2Subtitle,
      ),
      SelfCheckDataWidget(
        imagePath: 'assets/images/change_3.jpeg',
        title: AppLocalizations.of(context)!.selfCheckInstruction3Title,
        subTitle: AppLocalizations.of(context)!.selfCheckInstruction3Subtitle,
      ),
      SelfCheckDataWidget(
        imagePath: 'assets/images/change_4.jpeg',
        title: AppLocalizations.of(context)!.selfCheckInstruction4Title,
        subTitle: AppLocalizations.of(context)!.selfCheckInstruction4Subtitle,
      ),
    ];
    Widget buildDots({
      required int length,
    }) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < length; i++)
            if (i == context.watch<SelfCheckProvider>().currentSlider)
              Row(
                children: [
                  Container(
                    // width: size.width * 0.07,
                    // height: size.width * 0.03,
                    width: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? size.width * 0.07
                        : size.width * 0.03,
                    height: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? size.width * 0.03
                        : size.width * 0.01,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius:
                          BorderRadius.circular(Consts.DefaultBorderRadius),
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
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                  SizedBox(
                    width: size.width * 0.015,
                  ),
                ],
              ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            AppLocalizations.of(context)!.selfCheckInstructionTitle,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 18
                        : 22,
                color: Theme.of(context).primaryColor),
          ),
          Column(
            children: [
              CarouselSlider(
                items: items,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    context.read<SelfCheckProvider>().currentSlider = index;
                  },
                  viewportFraction: 0.9,
                  //height: size.height * 0.35,
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? size.height * 0.5
                          : size.height * 0.3,
                  // aspectRatio:
                  //     MediaQuery.of(context).orientation == Orientation.portrait
                  //         ? 1
                  //         : 5,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              buildDots(length: items.length),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              context.read<SelfCheckProvider>().currentStep = 0;
              Utils(context).push(widget: const SelfCheckSteps());
            },
            child: Text(AppLocalizations.of(context)!.checkyourselfbutton),
          ),
        ],
      )),
    );
  }
}
