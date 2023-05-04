import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/languageprovider.dart';
import '../../widget/persistent_nav_bar.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  IntroductionPageState createState() => IntroductionPageState();
}

class IntroductionPageState extends State<IntroductionPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 19.0),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
      imageAlignment: Alignment.center,
      bodyAlignment: Alignment.bottomCenter,
      imageFlex: 4,
      bodyFlex: 2,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        allowImplicitScrolling: true,
        autoScrollDuration: 3000,
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: TextButton(
            onPressed: () => _onIntroEnd(context),
            child: Text(
              'Skip',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).primaryColor),
            ),
          ),
        ),

        pages: [
          PageViewModel(
            title: 'Get information',
            body:
                "Get information about breast cancer, it's causes, symptoms and how to prevent it.",
            decoration: pageDecoration.copyWith(
              imageAlignment: Alignment.topCenter,
            ),

            // Check yourself to prevent breast cancer. Self-checking is the first step to preventing breast cancer.
            image: _buildImage('assets/images/information.svg'),
            reverse: true,
          ),
          PageViewModel(
            title: "Check yourself",
            body:
                "Check yourself to prevent breast cancer. Self-checking is the first step to preventing breast cancer.",
            image: _buildImage('assets/images/checkyourself.svg'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Menstrual selfcheck",
            body:
                'Get reminders for your menstrual self-check.You can also check yourself manually.',
            image: _buildImage('assets/images/notifications.svg'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Get Appointments",
            body:
                'Get appointments with the best doctors in the country for your checkups.',
            decoration: pageDecoration.copyWith(
              imageAlignment: Alignment.topCenter,
            ),
            image: _buildImage('assets/images/appointment.svg'),
            reverse: true,
          ),
          PageViewModel(
            title: "Mammography Analysis",
            body:
                'Use Artificial intelligence to analyse your mammography and check for any abnormalities.',
            image: _buildImage('assets/images/artificial_intelligence.svg'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        showBackButton: true,
        // showSkipButton: true,
        back: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
        skip: Text('Skip',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor)),
        next: Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor),
        done: Text('Done',
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor)),
        curve: Curves.fastLinearToSlowEaseIn,
        // controlsMargin: const EdgeInsets.all(16),
        // controlsPadding: kIsWeb
        //     ? const EdgeInsets.all(12.0)
        //     : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        // dotsDecorator: const DotsDecorator(
        //   size: Size(10.0, 10.0),
        //   color: Color(0xFFBDBDBD),
        //   activeSize: Size(22.0, 10.0),
        //   activeShape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
        //   ),
        // ),
        // dotsContainerDecorator: const ShapeDecoration(
        //   color: Colors.black87,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
        //   ),
        // ),
      ),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return SvgPicture.asset(
      assetName,
      width: width,
    );
  }

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (_) => const PersistentNavBar()),
      (Route<dynamic> route) => false,
    );

    context.read<LanguageProvider>().isBoardingCompleate = true;
    context.read<LanguageProvider>().boardingCompleated();
  }
}
