import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../providers/languageprovider.dart';
import '../../providers/themeprovider.dart';
import '../../utils/utils.dart';
import '../../widget/customdropdownbutton.dart';

import '../../widget/mothercarelogo.dart';
import '../../widget/settingsbuttonitemwidget.dart';
import '../../widget/settingsectionwidget.dart';
import '../../widget/settingsitemwidget.dart';
import 'about.dart';
import 'changelog.dart';
import 'profile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.settings,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _generalSection(context: context),
            _accountSection(context: context),
            _otherSection(context: context),
            const MothercareLogo(),
            _changeLog(context: context),
            _credit(
              context: context,
              url: Consts.CREDIT_DEVELOPER_URL,
            ),
            SizedBox(
              height: kBottomNavigationBarHeight,
            ),
          ],
        ),
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
          AppLocalizations.of(context)!.madebyasraful,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  _otherSection({required BuildContext context}) {
    return SettingsSection(
      title: AppLocalizations.of(context)!.other,
      children: [
        SettingsButtonItem(
          label: AppLocalizations.of(context)!.aboutMothercare,
          buttonLabel: AppLocalizations.of(context)!.open,
          onTap: () async {
            await Utils(context).push(
              widget: const AboutScreen(),
            );
          },
        ),
        // SettingsButtonItem(
        //   label: AppLocalizations.of(context)!.supportMothercare,
        //   buttonLabel: AppLocalizations.of(context)!.donate,
        //   onTap: () async {
        //     await Utils(context).push(
        //       widget: const SupportScreen(),
        //     );
        //   },
        // ),
        SettingsButtonItem(
          label: AppLocalizations.of(context)!.privacypolicy,
          buttonLabel: AppLocalizations.of(context)!.open,
          onTap: () async {
            await Utils(context).launchURL(Consts.PRIVACY_POLICY_URL);
          },
        ),
        SettingsButtonItem(
          label: AppLocalizations.of(context)!.termsconditions,
          buttonLabel: AppLocalizations.of(context)!.open,
          onTap: () async {
            await Utils(context).launchURL(Consts.TERMS_CONDITIONS_URL);
          },
        ),
      ],
    );
  }

  Widget _changeLog({required BuildContext context}) {
    return TextButton.icon(
      onPressed: () async {
        await Utils(context).push(
          widget: const ChangelogScreen(),
        );
      },
      icon: Icon(
        Icons.history,
        color: Theme.of(context).primaryColor,
      ),
      label: Text(AppLocalizations.of(context)!.changelog),
    );
  }
}
