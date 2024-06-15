import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../providers/languageprovider.dart';
import '../../providers/nav_bar_provider.dart';
import '../../providers/themeprovider.dart';
import '../../utils/utils.dart';
import '../../widget/customdropdownbutton.dart';

import '../../widget/settingsbuttonitemwidget.dart';
import '../../widget/settingsectionwidget.dart';
import '../../widget/settingsitemwidget.dart';
import 'profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
        ),
      ),
      body: Column(
        children: [
          _generalSection(context: context),
          _accountSection(context: context),
          const Spacer(),
          _logo(context: context, size: size),
          _credit(
            context: context,
            url: Consts.CREDIT_DEVELOPER_URL,
          ),
          SizedBox(
            height: size.height * 0.01,
          )
        ],
      ),
    );
  }

  _generalSection({required BuildContext context}) {
    return SettingsSection(
      title: AppLocalizations.of(context)!.general,
      children: [
        SettingsItem(
          label: AppLocalizations.of(context)!.theme,
          child: CustomDropdownButton(
            value: context.watch<ThemeProvider>().themeMode,
            items: ThemeMode.values.map((theme) {
              return DropdownMenuItem(
                value: theme,
                alignment: Alignment.center,
                child: Text(theme == ThemeMode.system
                    ? AppLocalizations.of(context)!.systemTheme
                    : theme == ThemeMode.light
                        ? AppLocalizations.of(context)!.lightTheme
                        : AppLocalizations.of(context)!.darkTheme),
              );
            }).toList(),
            onChanged: (theme) =>
                context.read<ThemeProvider>().themeMode = theme,
          ),
        ),
        SettingsItem(
          label: AppLocalizations.of(context)!.language,
          child: CustomDropdownButton(
            value: context.watch<LanguageProvider>().language,
            items:
                context.watch<LanguageProvider>().languageList.map((language) {
              return DropdownMenuItem(
                value: language,
                alignment: Alignment.center,
                child: Text(language),
              );
            }).toList(),
            onChanged: (language) =>
                context.read<LanguageProvider>().language = language,
          ),
        ),
      ],
    );
  }

  _accountSection({required BuildContext context}) {
    return SettingsSection(
      title: AppLocalizations.of(context)!.account,
      children: [
        SettingsButtonItem(
          label: AppLocalizations.of(context)!.profile,
          buttonLabel: AppLocalizations.of(context)!.open,
          onTap: () async {
            await Utils(context).push(
              widget: const ProfileScreen(),
            );
          },
        ),
      ],
    );
  }

  _credit({required BuildContext context, required String url}) {
    return GestureDetector(
      onTap: () => Utils(context).launchURL(url),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          AppLocalizations.of(context)!.madewithbyasraful,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _logo({
    required BuildContext context,
    required Size size,
  }) {
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
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
