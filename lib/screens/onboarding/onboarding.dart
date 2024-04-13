import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../providers/languageprovider.dart';
import '../../providers/themeprovider.dart';
import '../../utils/utils.dart';
import '../../widget/customexpandedbutton.dart';
import '../../widget/selectionbuttonwidget.dart';
import 'introduction.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) => Utils(context).onWillPop(),
        child: Scaffold(
          body: AnnotatedRegion(
            value: SystemUiOverlayStyle(
              systemNavigationBarColor:
                  themeProvider.isDarkTheme ? Colors.black : Colors.white,
              systemNavigationBarIconBrightness: themeProvider.isDarkTheme
                  ? Brightness.light
                  : Brightness.dark,
              statusBarColor:
                  themeProvider.isDarkTheme ? Colors.black : Colors.white,
              statusBarIconBrightness: themeProvider.isDarkTheme
                  ? Brightness.light
                  : Brightness.dark,
            ),
            child: SafeArea(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: SvgPicture.asset(
                      'assets/images/family.svg',
                      width: size.width,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          AppLocalizations.of(context)!.selectLanguage,
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
                        CustomExpanedButton(
                          onPressed: () async {
                            await Utils(context)
                                .push(widget: const IntroductionPage());
                          },
                          text: AppLocalizations.of(context)!.nextbutton,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Opacity(
                          opacity: 0.5,
                          child: Text(
                            AppLocalizations.of(context)!.languageNote,
                            style: const TextStyle(
                              fontSize: 12.0,
                              // color: Colors.black45,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  _logo({
    required BuildContext context,
    required Size size,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: size.height * 0.4,
          // color: Theme.of(context).primaryColor,
          child: Image.asset(
            color: Theme.of(context).primaryColor,
            Consts.LOGO,
          ),
        ),
        Positioned(
          // bottom: 20,
          child: Text(
            AppLocalizations.of(context)!.appname,
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
    return Consumer<LanguageProvider>(builder: (context, provider, child) {
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
              iconCondition: provider.languageCode == 'en',
              ontap: () {
                provider.languageCode = 'en';
              },
            ),
            Divider(
              color: Theme.of(context).primaryColor,
              height: 0,
            ),
            SelectionButtonWidget(
              iconCondition: provider.languageCode == 'bn',
              buttontitle: 'বাংলা',
              ontap: () {
                provider.languageCode = 'bn';
              },
            ),
          ],
        ),
      );
    });
  }
}
