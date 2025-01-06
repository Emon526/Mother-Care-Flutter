import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mothercare/utils/utils.dart';
import 'package:provider/provider.dart';

import '../const/consts.dart';
import '../providers/languageprovider.dart';
import '../providers/nav_bar_provider.dart';

class MothercareLogo extends StatelessWidget {
  const MothercareLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: size.height * 0.3,
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
        ),
        Text(
          '${AppLocalizations.of(context)!.version} : ${context.watch<NavBarProvider>().appVersionInfo(
                locale: context.watch<LanguageProvider>().languageCode,
              )}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          '© ${Utils(context).formatNumber(number: DateTime.now().year)} ${AppLocalizations.of(context)!.creditdevelopername1}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
