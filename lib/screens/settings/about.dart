import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../const/consts.dart';
import '../../utils/utils.dart';
import '../../widget/mothercarelogo.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const MothercareLogo(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                AppLocalizations.of(context)!.appdescription,
                textAlign: TextAlign.center,
              ),
            ),
            TextButton(
              onPressed: () async {
                await Utils(context).launchURL(Consts.HOME_PAGE_URL);
              },
              child: Text('Homepage'),
            ),
            TextButton(
              onPressed: () async {
                await Utils(context).launchURL(Consts.PROJECT_URL);
              },
              child: Text('Source code (Github)'),
            ),
            TextButton(
              onPressed: () async {
                await Utils(context).launchURL(Consts.LICENSE_URL);
              },
              child: Text('License'),
            ),
            TextButton(
              onPressed: () => Utils(context).showLicense(),
              child: Text('License Notices'),
            ),
          ],
        ),
      ),
    );
  }
}
