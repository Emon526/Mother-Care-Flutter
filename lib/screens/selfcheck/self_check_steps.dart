import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import '../../const/consts.dart';
import '../../providers/selfcheckprovider.dart';
import '../../utils/utils.dart';
import '../../widget/selfcheckstepwidget.dart';
import 'self_check_finish.dart';

class SelfCheckSteps extends StatefulWidget {
  const SelfCheckSteps({super.key});

  @override
  State<SelfCheckSteps> createState() => _SelfCheckStepsState();
}

CarouselSliderController stepcontroller = CarouselSliderController();

class _SelfCheckStepsState extends State<SelfCheckSteps> {
  Widget steps() {
    return EasyStepper(
      // enableStepTapping: false,
      showLoadingAnimation: false,
      // disableScroll: true,
      activeStep: context.watch<SelfCheckProvider>().currentStep,
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
        context.read<SelfCheckProvider>().currentStep = index;
        _stepWidgetChange(index: index);
      },
      steps: [
        EasyStep(
          customStep: ClipRRect(
            borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
            child: Opacity(
              opacity:
                  context.watch<SelfCheckProvider>().currentStep == 0 ? 1 : 0.3,
              child: Image.asset(
                'assets/images/self-check_step_1.jpg',
              ),
            ),
          ),
          customTitle: Opacity(
            opacity:
                context.watch<SelfCheckProvider>().currentStep == 0 ? 1 : 0.3,
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
                  context.watch<SelfCheckProvider>().currentStep == 1 ? 1 : 0.3,
              child: Image.asset(
                'assets/images/self-check_step_2.jpg',
              ),
            ),
          ),
          customTitle: Opacity(
            opacity:
                context.watch<SelfCheckProvider>().currentStep == 1 ? 1 : 0.3,
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
                  context.watch<SelfCheckProvider>().currentStep == 2 ? 1 : 0.3,
              child: Image.asset(
                'assets/images/self-check_step_3.jpg',
              ),
            ),
          ),
          customTitle: Opacity(
            opacity:
                context.watch<SelfCheckProvider>().currentStep == 2 ? 1 : 0.3,
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
                  context.watch<SelfCheckProvider>().currentStep == 3 ? 1 : 0.3,
              child: Image.asset(
                'assets/images/self-check_step_4.jpg',
              ),
            ),
          ),
          customTitle: Opacity(
            opacity:
                context.watch<SelfCheckProvider>().currentStep == 3 ? 1 : 0.3,
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
                  context.watch<SelfCheckProvider>().currentStep == 4 ? 1 : 0.3,
              child: Image.asset(
                'assets/images/self-check_step_5.jpg',
              ),
            ),
          ),
          customTitle: Opacity(
            opacity:
                context.watch<SelfCheckProvider>().currentStep == 4 ? 1 : 0.3,
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
                  context.watch<SelfCheckProvider>().currentStep == 5 ? 1 : 0.3,
              child: Image.asset(
                'assets/images/self-check_step_6.jpg',
              ),
            ),
          ),
          customTitle: Opacity(
            opacity:
                context.watch<SelfCheckProvider>().currentStep == 5 ? 1 : 0.3,
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
                  context.watch<SelfCheckProvider>().currentStep == 6 ? 1 : 0.3,
              child: Image.asset(
                'assets/images/self-check_step_7.jpg',
              ),
            ),
          ),
          customTitle: Opacity(
            opacity:
                context.watch<SelfCheckProvider>().currentStep == 6 ? 1 : 0.3,
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
    );
  }

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
        child: Column(
          //mainAxisSize: MainAxisSize.min,
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            steps(),
            Expanded(
              child: CarouselSlider(
                disableGesture: true,
                carouselController: stepcontroller,
                options: CarouselOptions(
                  initialPage: context.watch<SelfCheckProvider>().currentStep,
                  scrollPhysics: const NeverScrollableScrollPhysics(),
                  enableInfiniteScroll: false,
                  viewportFraction: 0.9,
                  height:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? size.height * 0.5
                          : size.height * 0.3,
                  // aspectRatio: 1,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                ),
                items: [
                  SelfCheckStepWidget(
                    image: 'assets/images/self-check_step_1.jpg',
                    title: AppLocalizations.of(context)!.selfCheckStep1Title,
                    description:
                        AppLocalizations.of(context)!.selfCheckStep1Body,
                  ),
                  SelfCheckStepWidget(
                    image: 'assets/images/self-check_step_2.jpg',
                    title: AppLocalizations.of(context)!.selfCheckStep2Title,
                    description:
                        AppLocalizations.of(context)!.selfCheckStep2Body,
                  ),
                  SelfCheckStepWidget(
                    image: 'assets/images/self-check_step_3.jpg',
                    title: AppLocalizations.of(context)!.selfCheckStep3Title,
                    description:
                        AppLocalizations.of(context)!.selfCheckStep3Body,
                  ),
                  SelfCheckStepWidget(
                    image: 'assets/images/self-check_step_4.jpg',
                    title: AppLocalizations.of(context)!.selfCheckStep4Title,
                    description:
                        AppLocalizations.of(context)!.selfCheckStep4Body,
                  ),
                  SelfCheckStepWidget(
                    image: 'assets/images/self-check_step_5.jpg',
                    title: AppLocalizations.of(context)!.selfCheckStep5Title,
                    description:
                        AppLocalizations.of(context)!.selfCheckStep5Body,
                  ),
                  SelfCheckStepWidget(
                    image: 'assets/images/self-check_step_6.jpg',
                    title: AppLocalizations.of(context)!.selfCheckStep6Title,
                    description:
                        AppLocalizations.of(context)!.selfCheckStep6Body,
                  ),
                  SelfCheckStepWidget(
                    image: 'assets/images/self-check_step_7.jpg',
                    title: AppLocalizations.of(context)!.selfCheckStep7Title,
                    description:
                        AppLocalizations.of(context)!.selfCheckStep7Body,
                  ),
                ],
              ),
            ),
            // easysteppersteps[context.read<SelfCheckProvider>().current],
            // const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                context.read<SelfCheckProvider>().currentStep == 0
                    ? const SizedBox()
                    : ElevatedButton(
                        child: Text(AppLocalizations.of(context)!.prevbutton),
                        onPressed: () {
                          // activeStep MUST BE GREATER THAN 0 TO PREVENT OVERFLOW.
                          if (context.read<SelfCheckProvider>().currentStep >
                              0) {
                            context.read<SelfCheckProvider>().currentStep--;

                            _stepWidgetChange(
                                index: context
                                    .read<SelfCheckProvider>()
                                    .currentStep);
                          }
                        },
                      ),
                context.watch<SelfCheckProvider>().currentStep ==
                        context.watch<SelfCheckProvider>().totalSteps - 1
                    ? ElevatedButton(
                        onPressed: () async {
                          context.read<SelfCheckProvider>().currentStep = 0;
                          Utils(context).pushReplacement(
                            widget: const SelfCheckFinish(),
                          );
                        },
                        child: Text(AppLocalizations.of(context)!.finishbutton))
                    : ElevatedButton(
                        child: Text(AppLocalizations.of(context)!.nextbutton),
                        onPressed: () {
                          context.read<SelfCheckProvider>().currentStep++;
                          _stepWidgetChange(
                              index: context
                                  .read<SelfCheckProvider>()
                                  .currentStep);
                        },
                      ),
              ],
            ),
          ],
        ),
      ),
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
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Consts.DefaultBorderRadius),
                  child: Image.asset(
                    'assets/images/shower.jpg',
                  ),
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

_stepWidgetChange({required int index}) {
  return stepcontroller.animateToPage(
    index,
    duration: const Duration(milliseconds: 1000),
    curve: Curves.linear,
  );
}
