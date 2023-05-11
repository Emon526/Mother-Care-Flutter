// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Next`
  String get nextbutton {
    return Intl.message(
      'Next',
      name: 'nextbutton',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get donebutton {
    return Intl.message(
      'Done',
      name: 'donebutton',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skipbutton {
    return Intl.message(
      'Skip',
      name: 'skipbutton',
      desc: '',
      args: [],
    );
  }

  /// `Learn more`
  String get learnmorebutton {
    return Intl.message(
      'Learn more',
      name: 'learnmorebutton',
      desc: '',
      args: [],
    );
  }

  /// `How to self-check`
  String get howtoselfcheckbutton {
    return Intl.message(
      'How to self-check',
      name: 'howtoselfcheckbutton',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `And`
  String get and {
    return Intl.message(
      'And',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get systemTheme {
    return Intl.message(
      'System',
      name: 'systemTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get lightTheme {
    return Intl.message(
      'Light',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get darkTheme {
    return Intl.message(
      'Dark',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Credits`
  String get credits {
    return Intl.message(
      'Credits',
      name: 'credits',
      desc: '',
      args: [],
    );
  }

  /// `This app is developed by the students of Daffodil International University. The developers are Asraful Islam, MD Shahajada Hasib and Sabbir Hossain Riad. The app is developed under the supervision of Dr. Md. Shamsul Arefin, Associate Professor, Department of CSE, Daffodil International University.`
  String get creditBody {
    return Intl.message(
      'This app is developed by the students of Daffodil International University. The developers are Asraful Islam, MD Shahajada Hasib and Sabbir Hossain Riad. The app is developed under the supervision of Dr. Md. Shamsul Arefin, Associate Professor, Department of CSE, Daffodil International University.',
      name: 'creditBody',
      desc: '',
      args: [],
    );
  }

  /// `Developed by`
  String get creditdeveloper {
    return Intl.message(
      'Developed by',
      name: 'creditdeveloper',
      desc: '',
      args: [],
    );
  }

  /// `Department of CSE`
  String get creditdeveloperdepartment {
    return Intl.message(
      'Department of CSE',
      name: 'creditdeveloperdepartment',
      desc: '',
      args: [],
    );
  }

  /// `Asraful Islam`
  String get creditdevelopername1 {
    return Intl.message(
      'Asraful Islam',
      name: 'creditdevelopername1',
      desc: '',
      args: [],
    );
  }

  /// `MD Shahajada Hasib`
  String get creditdevelopername2 {
    return Intl.message(
      'MD Shahajada Hasib',
      name: 'creditdevelopername2',
      desc: '',
      args: [],
    );
  }

  /// `Sabbir Hossain Riad`
  String get creditdevelopername3 {
    return Intl.message(
      'Sabbir Hossain Riad',
      name: 'creditdevelopername3',
      desc: '',
      args: [],
    );
  }

  /// `Daffodil International University`
  String get creditdeveloperuniversity {
    return Intl.message(
      'Daffodil International University',
      name: 'creditdeveloperuniversity',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Doctors`
  String get doctors {
    return Intl.message(
      'Doctors',
      name: 'doctors',
      desc: '',
      args: [],
    );
  }

  /// `Mammography Screening`
  String get mammographyscreening {
    return Intl.message(
      'Mammography Screening',
      name: 'mammographyscreening',
      desc: '',
      args: [],
    );
  }

  /// `Reminders`
  String get reminders {
    return Intl.message(
      'Reminders',
      name: 'reminders',
      desc: '',
      args: [],
    );
  }

  /// `Select Theme`
  String get selectTheme {
    return Intl.message(
      'Select Theme',
      name: 'selectTheme',
      desc: '',
      args: [],
    );
  }

  /// `You can change the language later from the settings`
  String get languageNote {
    return Intl.message(
      'You can change the language later from the settings',
      name: 'languageNote',
      desc: '',
      args: [],
    );
  }

  /// `Get information`
  String get introTitle1 {
    return Intl.message(
      'Get information',
      name: 'introTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Check yourself`
  String get introTitle2 {
    return Intl.message(
      'Check yourself',
      name: 'introTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Menstrual self check`
  String get introTitle3 {
    return Intl.message(
      'Menstrual self check',
      name: 'introTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Get Appointments`
  String get introTitle4 {
    return Intl.message(
      'Get Appointments',
      name: 'introTitle4',
      desc: '',
      args: [],
    );
  }

  /// `Mammography Analysis`
  String get introTitle5 {
    return Intl.message(
      'Mammography Analysis',
      name: 'introTitle5',
      desc: '',
      args: [],
    );
  }

  /// `Get information about breast cancer, it's causes, symptoms and how to prevent it.`
  String get introBody1 {
    return Intl.message(
      'Get information about breast cancer, it\'s causes, symptoms and how to prevent it.',
      name: 'introBody1',
      desc: '',
      args: [],
    );
  }

  /// `Check yourself to prevent breast cancer. Self-checking is the first step to preventing breast cancer.`
  String get introBody2 {
    return Intl.message(
      'Check yourself to prevent breast cancer. Self-checking is the first step to preventing breast cancer.',
      name: 'introBody2',
      desc: '',
      args: [],
    );
  }

  /// `Get reminders for your menstrual self-check.You can also check yourself manually.`
  String get introBody3 {
    return Intl.message(
      'Get reminders for your menstrual self-check.You can also check yourself manually.',
      name: 'introBody3',
      desc: '',
      args: [],
    );
  }

  /// `Get appointments with the best doctors in the country for your checkups.`
  String get introBody4 {
    return Intl.message(
      'Get appointments with the best doctors in the country for your checkups.',
      name: 'introBody4',
      desc: '',
      args: [],
    );
  }

  /// `Use Artificial intelligence to analyse your mammography and check for any abnormalities.`
  String get introBody5 {
    return Intl.message(
      'Use Artificial intelligence to analyse your mammography and check for any abnormalities.',
      name: 'introBody5',
      desc: '',
      args: [],
    );
  }

  /// `Early Detection Saves Lives`
  String get awarenessTitle1 {
    return Intl.message(
      'Early Detection Saves Lives',
      name: 'awarenessTitle1',
      desc: '',
      args: [],
    );
  }

  /// `WHY IT MATTERS`
  String get awarenessTitle2 {
    return Intl.message(
      'WHY IT MATTERS',
      name: 'awarenessTitle2',
      desc: '',
      args: [],
    );
  }

  /// `The earlier breast cancer is is treated, the greater the chance of long-term survival. Regular self-checks can help you detect problems earlier and get treatment faster.`
  String get awarenessBody1 {
    return Intl.message(
      'The earlier breast cancer is is treated, the greater the chance of long-term survival. Regular self-checks can help you detect problems earlier and get treatment faster.',
      name: 'awarenessBody1',
      desc: '',
      args: [],
    );
  }

  /// `Why? Because the earlier signs of breast cancer are detected and treated, the better the chances of recovery.\n\nRegular check-ups with your gynaecologist or trusted health professional can help to detect breast cancer at an early stage. Your doctor may also recommend a mammogram.\n\nBut you can do more to protect yourself by checking your own breasts regularly!\n\nRegular self-checks are the best way to get to know what is normal for you, and will help you notice changes more quickly. The faster you notice, the sooner you'll be able to react and get treatment if needed.\n\nAnd if there's one thing we know about breast cancer, it's that the earlier it's treated, the greater the likelihood of survival.`
  String get awarenessBody2 {
    return Intl.message(
      'Why? Because the earlier signs of breast cancer are detected and treated, the better the chances of recovery.\n\nRegular check-ups with your gynaecologist or trusted health professional can help to detect breast cancer at an early stage. Your doctor may also recommend a mammogram.\n\nBut you can do more to protect yourself by checking your own breasts regularly!\n\nRegular self-checks are the best way to get to know what is normal for you, and will help you notice changes more quickly. The faster you notice, the sooner you\'ll be able to react and get treatment if needed.\n\nAnd if there\'s one thing we know about breast cancer, it\'s that the earlier it\'s treated, the greater the likelihood of survival.',
      name: 'awarenessBody2',
      desc: '',
      args: [],
    );
  }

  /// `Checking your breasts for changes each month is free, easy and might save your life.`
  String get awarenessNote2 {
    return Intl.message(
      'Checking your breasts for changes each month is free, easy and might save your life.',
      name: 'awarenessNote2',
      desc: '',
      args: [],
    );
  }

  /// `Check your breasts`
  String get awarenessHeader1Title {
    return Intl.message(
      'Check your breasts',
      name: 'awarenessHeader1Title',
      desc: '',
      args: [],
    );
  }

  /// `Save Your Lives`
  String get awarenessHeader1Subtitle {
    return Intl.message(
      'Save Your Lives',
      name: 'awarenessHeader1Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Check your breasts`
  String get awarenessHeader2Title {
    return Intl.message(
      'Check your breasts',
      name: 'awarenessHeader2Title',
      desc: '',
      args: [],
    );
  }

  /// `Save Your Lives`
  String get awarenessHeader2Subtitle {
    return Intl.message(
      'Save Your Lives',
      name: 'awarenessHeader2Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Get the free`
  String get awarenessHeader3Title {
    return Intl.message(
      'Get the free',
      name: 'awarenessHeader3Title',
      desc: '',
      args: [],
    );
  }

  /// `SELF CHECK GUIDE`
  String get awarenessHeader3Subtitle {
    return Intl.message(
      'SELF CHECK GUIDE',
      name: 'awarenessHeader3Subtitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'bn'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
