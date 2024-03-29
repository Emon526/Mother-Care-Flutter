import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../../const/consts.dart';
import '../../providers/selfcheckprovider.dart';
import '../../utils/utils.dart';
import 'self_check_finish.dart';

class SelfCheckSteps extends StatefulWidget {
  const SelfCheckSteps({super.key});

  @override
  State<SelfCheckSteps> createState() => _SelfCheckStepsState();
}

CarouselController stepcontroller = CarouselController();

class _SelfCheckStepsState extends State<SelfCheckSteps> {
  @override
  void initState() {
    super.initState();
    _showHintDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.selfcheck,
        ),
      ),
      body: SafeArea(
        child: _easyStepper(
          size: size,
          easysteppersteps: easysteppersteps(
            context: context,
            size: size,
          ),
        ),
      ),
    );
  }

  _easyStepper({
    required List<Widget> easysteppersteps,
    required Size size,
  }) {
    return Column(
      children: [
        EasyStepper(
          // enableStepTapping: false,
          showLoadingAnimation: false,
          // disableScroll: true,
          activeStep: context.watch<SelfCheckProvider>().current,
          // lineLength: 50,
          // maxReachedStep: dotCount - 1,
          stepShape: StepShape.rRectangle,
          stepBorderRadius: Consts.DefaultBorderRadius,
          borderThickness: 2,
          // padding: 20,f
          // stepRadius: 28,
          // finishedStepTextColor: Colors.deepOrange,
          finishedStepBackgroundColor: Theme.of(context).colorScheme.secondary,
          finishedStepBorderColor: Theme.of(context).colorScheme.secondary,
          lineStyle: LineStyle(
            defaultLineColor: Theme.of(context).primaryColor,
          ),
          // activeStepIconColor: Colors.deepOrange,
          activeStepBorderColor: Theme.of(context).primaryColor,
          activeStepBackgroundColor: Theme.of(context).primaryColor,
          activeStepTextColor: Theme.of(context).primaryColor,
          // activeLineColor:

          onStepReached: (index) {
            context.read<SelfCheckProvider>().current = index;
            _stepWidgetChange(index: index);
          },
          steps: [
            EasyStep(
              customStep: ClipRRect(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                child: Opacity(
                  opacity:
                      context.watch<SelfCheckProvider>().current == 0 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/images/self-check_step_1.jpg',
                  ),
                ),
              ),
              customTitle: Opacity(
                opacity:
                    context.watch<SelfCheckProvider>().current == 0 ? 1 : 0.3,
                child: Text(
                  AppLocalizations.of(context)!.selfCheckStep1Title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            EasyStep(
              customStep: ClipRRect(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                child: Opacity(
                  opacity:
                      context.watch<SelfCheckProvider>().current == 1 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/images/self-check_step_2.jpg',
                  ),
                ),
              ),
              customTitle: Opacity(
                opacity:
                    context.watch<SelfCheckProvider>().current == 1 ? 1 : 0.3,
                child: Text(
                  AppLocalizations.of(context)!.selfCheckStep2Title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            EasyStep(
              customStep: ClipRRect(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                child: Opacity(
                  opacity:
                      context.watch<SelfCheckProvider>().current == 2 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/images/self-check_step_3.jpg',
                  ),
                ),
              ),
              customTitle: Opacity(
                opacity:
                    context.watch<SelfCheckProvider>().current == 2 ? 1 : 0.3,
                child: Text(
                  AppLocalizations.of(context)!.selfCheckStep3Title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            EasyStep(
              customStep: ClipRRect(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                child: Opacity(
                  opacity:
                      context.watch<SelfCheckProvider>().current == 3 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/images/self-check_step_4.jpg',
                  ),
                ),
              ),
              customTitle: Opacity(
                opacity:
                    context.watch<SelfCheckProvider>().current == 3 ? 1 : 0.3,
                child: Text(
                  AppLocalizations.of(context)!.selfCheckStep4Title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            EasyStep(
              customStep: ClipRRect(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                child: Opacity(
                  opacity:
                      context.watch<SelfCheckProvider>().current == 4 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/images/self-check_step_5.jpg',
                  ),
                ),
              ),
              customTitle: Opacity(
                opacity:
                    context.watch<SelfCheckProvider>().current == 4 ? 1 : 0.3,
                child: Text(
                  AppLocalizations.of(context)!.selfCheckStep5Title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            EasyStep(
              customStep: ClipRRect(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                child: Opacity(
                  opacity:
                      context.watch<SelfCheckProvider>().current == 5 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/images/self-check_step_6.jpg',
                  ),
                ),
              ),
              customTitle: Opacity(
                opacity:
                    context.watch<SelfCheckProvider>().current == 5 ? 1 : 0.3,
                child: Text(
                  AppLocalizations.of(context)!.selfCheckStep6Title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            EasyStep(
              customStep: ClipRRect(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                child: Opacity(
                  opacity:
                      context.watch<SelfCheckProvider>().current == 6 ? 1 : 0.3,
                  child: Image.asset(
                    'assets/images/self-check_step_7.jpg',
                  ),
                ),
              ),
              customTitle: Opacity(
                opacity:
                    context.watch<SelfCheckProvider>().current == 6 ? 1 : 0.3,
                child: Text(
                  AppLocalizations.of(context)!.selfCheckStep7Title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        CarouselSlider(
          disableGesture: true,
          carouselController: stepcontroller,
          items: easysteppersteps,
          options: CarouselOptions(
            initialPage: context.watch<SelfCheckProvider>().current,
            scrollPhysics: const NeverScrollableScrollPhysics(),
            enableInfiniteScroll: false,
            viewportFraction: 0.9,
            aspectRatio: 1,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
        ),
        // easysteppersteps[context.read<SelfCheckProvider>().current],
        const Spacer(),
        Padding(
          padding: EdgeInsets.all(size.width * 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              context.read<SelfCheckProvider>().current == 0
                  ? const SizedBox()
                  : ElevatedButton(
                      child: Text(AppLocalizations.of(context)!.prevbutton),
                      onPressed: () {
                        // activeStep MUST BE GREATER THAN 0 TO PREVENT OVERFLOW.
                        if (context.read<SelfCheckProvider>().current > 0) {
                          context.read<SelfCheckProvider>().current--;

                          _stepWidgetChange(
                              index: context.read<SelfCheckProvider>().current);
                        }
                      },
                    ),
              context.watch<SelfCheckProvider>().current ==
                      context.watch<SelfCheckProvider>().totalSteps - 1
                  ? ElevatedButton(
                      onPressed: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const SelfCheckFinish(),
                          withNavBar: true, // OPTIONAL VALUE. True by default.
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                        context.read<SelfCheckProvider>().current == 0;
                      },
                      child: Text(AppLocalizations.of(context)!.finishbutton))
                  : ElevatedButton(
                      child: Text(AppLocalizations.of(context)!.nextbutton),
                      onPressed: () {
                        context.read<SelfCheckProvider>().current++;
                        _stepWidgetChange(
                            index: context.read<SelfCheckProvider>().current);
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _showHintDialog(
    BuildContext context,
  ) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Utils(context).showCustomDialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  AppLocalizations.of(context)!.selfCheckHintTitle,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                child: Image.asset(
                  'assets/images/shower.jpg',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.selfCheckHintBody,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    });
  }
}

_buildStepCard({
  required Size size,
  required String stepimagepath,
  required String steptitle,
  required String stepsubtitle,
  required BuildContext context,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      // vertical: 50,
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
          child: Image.asset(
            stepimagepath,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          child: Text(
            stepsubtitle,
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

List<Widget> easysteppersteps(
        {required BuildContext context, required Size size}) =>
    [
      _buildStepCard(
        context: context,
        size: size,
        stepimagepath: 'assets/images/self-check_step_1.jpg',
        steptitle: AppLocalizations.of(context)!.selfCheckStep1Title,
        stepsubtitle: AppLocalizations.of(context)!.selfCheckStep1Body,
      ),
      _buildStepCard(
        context: context,
        size: size,
        stepimagepath: 'assets/images/self-check_step_2.jpg',
        steptitle: AppLocalizations.of(context)!.selfCheckStep2Title,
        stepsubtitle: AppLocalizations.of(context)!.selfCheckStep2Body,
      ),
      _buildStepCard(
        context: context,
        size: size,
        stepimagepath: 'assets/images/self-check_step_3.jpg',
        steptitle: AppLocalizations.of(context)!.selfCheckStep3Title,
        stepsubtitle: AppLocalizations.of(context)!.selfCheckStep3Body,
      ),
      _buildStepCard(
        context: context,
        size: size,
        stepimagepath: 'assets/images/self-check_step_4.jpg',
        steptitle: AppLocalizations.of(context)!.selfCheckStep4Title,
        stepsubtitle: AppLocalizations.of(context)!.selfCheckStep4Body,
      ),
      _buildStepCard(
        context: context,
        size: size,
        stepimagepath: 'assets/images/self-check_step_5.jpg',
        steptitle: AppLocalizations.of(context)!.selfCheckStep5Title,
        stepsubtitle: AppLocalizations.of(context)!.selfCheckStep5Body,
      ),
      _buildStepCard(
        context: context,
        size: size,
        stepimagepath: 'assets/images/self-check_step_6.jpg',
        steptitle: AppLocalizations.of(context)!.selfCheckStep6Title,
        stepsubtitle: AppLocalizations.of(context)!.selfCheckStep6Body,
      ),
      _buildStepCard(
        context: context,
        size: size,
        stepimagepath: 'assets/images/self-check_step_7.jpg',
        steptitle: AppLocalizations.of(context)!.selfCheckStep7Title,
        stepsubtitle: AppLocalizations.of(context)!.selfCheckStep7Body,
      ),
    ];
_stepWidgetChange({required int index}) {
  return stepcontroller.animateToPage(
    index,
    duration: const Duration(milliseconds: 1000),
    curve: Curves.linear,
  );
}
