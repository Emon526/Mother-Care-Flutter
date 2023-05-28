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

  /// ` Mother Care`
  String get appname {
    return Intl.message(
      ' Mother Care',
      name: 'appname',
      desc: '',
      args: [],
    );
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

  /// `Prev`
  String get prevbutton {
    return Intl.message(
      'Prev',
      name: 'prevbutton',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finishbutton {
    return Intl.message(
      'Finish',
      name: 'finishbutton',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get applybutton {
    return Intl.message(
      'Apply',
      name: 'applybutton',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get resetbutton {
    return Intl.message(
      'Reset',
      name: 'resetbutton',
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

  /// `read more`
  String get readmore {
    return Intl.message(
      'read more',
      name: 'readmore',
      desc: '',
      args: [],
    );
  }

  /// `show less`
  String get readless {
    return Intl.message(
      'show less',
      name: 'readless',
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

  /// `CHECK YOURSELF STEP BY STEP`
  String get checkyourselfbutton {
    return Intl.message(
      'CHECK YOURSELF STEP BY STEP',
      name: 'checkyourselfbutton',
      desc: '',
      args: [],
    );
  }

  /// `Set a Reminder`
  String get setreminderbutton {
    return Intl.message(
      'Set a Reminder',
      name: 'setreminderbutton',
      desc: '',
      args: [],
    );
  }

  /// `Consult Doctor`
  String get consultdoctorbutton {
    return Intl.message(
      'Consult Doctor',
      name: 'consultdoctorbutton',
      desc: '',
      args: [],
    );
  }

  /// `Book an Appointment`
  String get bookappointmentbutton {
    return Intl.message(
      'Book an Appointment',
      name: 'bookappointmentbutton',
      desc: '',
      args: [],
    );
  }

  /// `Call for Appointment`
  String get callforappointmentbutton {
    return Intl.message(
      'Call for Appointment',
      name: 'callforappointmentbutton',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get okbutton {
    return Intl.message(
      'OK',
      name: 'okbutton',
      desc: '',
      args: [],
    );
  }

  /// `CANCEL`
  String get cancelbutton {
    return Intl.message(
      'CANCEL',
      name: 'cancelbutton',
      desc: '',
      args: [],
    );
  }

  /// `YES`
  String get yesbutton {
    return Intl.message(
      'YES',
      name: 'yesbutton',
      desc: '',
      args: [],
    );
  }

  /// `NO`
  String get nobutton {
    return Intl.message(
      'NO',
      name: 'nobutton',
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

  /// `This app is developed by the students of Daffodil International University. The developers are Asraful Islam, MD Shahajada Hasib and MD Sabbir Hossain Riad. The app is developed under the supervision of Sharmin Akter, Sr. Lecturer, Department of CSE, Daffodil International University.`
  String get creditBody {
    return Intl.message(
      'This app is developed by the students of Daffodil International University. The developers are Asraful Islam, MD Shahajada Hasib and MD Sabbir Hossain Riad. The app is developed under the supervision of Sharmin Akter, Sr. Lecturer, Department of CSE, Daffodil International University.',
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

  /// `MD Sabbir Hossain Riad`
  String get creditdevelopername3 {
    return Intl.message(
      'MD Sabbir Hossain Riad',
      name: 'creditdevelopername3',
      desc: '',
      args: [],
    );
  }

  /// `Sharmin Akter`
  String get supervisorname {
    return Intl.message(
      'Sharmin Akter',
      name: 'supervisorname',
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

  /// `Doctor`
  String get doctors {
    return Intl.message(
      'Doctor',
      name: 'doctors',
      desc: '',
      args: [],
    );
  }

  /// `Awareness`
  String get awareness {
    return Intl.message(
      'Awareness',
      name: 'awareness',
      desc: '',
      args: [],
    );
  }

  /// `Breast Cancer`
  String get breastcancer {
    return Intl.message(
      'Breast Cancer',
      name: 'breastcancer',
      desc: '',
      args: [],
    );
  }

  /// `Self Check`
  String get selfcheck {
    return Intl.message(
      'Self Check',
      name: 'selfcheck',
      desc: '',
      args: [],
    );
  }

  /// `Mammography Analysis`
  String get mammographyscreening {
    return Intl.message(
      'Mammography Analysis',
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

  /// `Are you sure?`
  String get exitTitle {
    return Intl.message(
      'Are you sure?',
      name: 'exitTitle',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to exit the app?`
  String get exitBody {
    return Intl.message(
      'Do you want to exit the app?',
      name: 'exitBody',
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

  /// `The earlier breast cancer is treated, the greater the chance of long-term survival. Regular self-checks can help you detect problems earlier and get treatment faster.`
  String get awarenessBody1 {
    return Intl.message(
      'The earlier breast cancer is treated, the greater the chance of long-term survival. Regular self-checks can help you detect problems earlier and get treatment faster.',
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

  /// `WHAT TO LOOK FOR`
  String get selfCheckInstructionTitle {
    return Intl.message(
      'WHAT TO LOOK FOR',
      name: 'selfCheckInstructionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Lumps, knots, thickening`
  String get selfCheckInstruction1Title {
    return Intl.message(
      'Lumps, knots, thickening',
      name: 'selfCheckInstruction1Title',
      desc: '',
      args: [],
    );
  }

  /// `Lumps, hardened knots or thickenings in the breast tissue can be a sign of breast cancer. They can occur right under the skin, in the middle of the breast or in the deep tissue near the bones.`
  String get selfCheckInstruction1Subtitle {
    return Intl.message(
      'Lumps, hardened knots or thickenings in the breast tissue can be a sign of breast cancer. They can occur right under the skin, in the middle of the breast or in the deep tissue near the bones.',
      name: 'selfCheckInstruction1Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Changes in size or shape`
  String get selfCheckInstruction2Title {
    return Intl.message(
      'Changes in size or shape',
      name: 'selfCheckInstruction2Title',
      desc: '',
      args: [],
    );
  }

  /// `Unusual changes in size, contour or shape should be checked. The same is true for distortions or swellings. Keep in mind that your left and right breast might look different. Know what is normal for you.`
  String get selfCheckInstruction2Subtitle {
    return Intl.message(
      'Unusual changes in size, contour or shape should be checked. The same is true for distortions or swellings. Keep in mind that your left and right breast might look different. Know what is normal for you.',
      name: 'selfCheckInstruction2Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Skin changes`
  String get selfCheckInstruction3Title {
    return Intl.message(
      'Skin changes',
      name: 'selfCheckInstruction3Title',
      desc: '',
      args: [],
    );
  }

  /// `There should be no strange wrinkling or bulging of the skin. Get checked if there is any persistent redness, soreness or rash, especially if only on one side.`
  String get selfCheckInstruction3Subtitle {
    return Intl.message(
      'There should be no strange wrinkling or bulging of the skin. Get checked if there is any persistent redness, soreness or rash, especially if only on one side.',
      name: 'selfCheckInstruction3Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Nipple discharge`
  String get selfCheckInstruction4Title {
    return Intl.message(
      'Nipple discharge',
      name: 'selfCheckInstruction4Title',
      desc: '',
      args: [],
    );
  }

  /// `The nipple should look normal to you, and should be free from irritation. Check for unusual discharge of fluid or blood.`
  String get selfCheckInstruction4Subtitle {
    return Intl.message(
      'The nipple should look normal to you, and should be free from irritation. Check for unusual discharge of fluid or blood.',
      name: 'selfCheckInstruction4Subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Helpful Hint : Shower`
  String get selfCheckHintTitle {
    return Intl.message(
      'Helpful Hint : Shower',
      name: 'selfCheckHintTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can do your self-check under the shower. Sometimes it’s easier when the breast is wet and soapy.`
  String get selfCheckHintBody {
    return Intl.message(
      'You can do your self-check under the shower. Sometimes it’s easier when the breast is wet and soapy.',
      name: 'selfCheckHintBody',
      desc: '',
      args: [],
    );
  }

  /// `Begin`
  String get selfCheckStep1Title {
    return Intl.message(
      'Begin',
      name: 'selfCheckStep1Title',
      desc: '',
      args: [],
    );
  }

  /// `Start in an upright position, hands on your hips. Look at your breasts with the help of a mirror, your mobile phone, or a friend.`
  String get selfCheckStep1Body {
    return Intl.message(
      'Start in an upright position, hands on your hips. Look at your breasts with the help of a mirror, your mobile phone, or a friend.',
      name: 'selfCheckStep1Body',
      desc: '',
      args: [],
    );
  }

  /// `Look`
  String get selfCheckStep2Title {
    return Intl.message(
      'Look',
      name: 'selfCheckStep2Title',
      desc: '',
      args: [],
    );
  }

  /// `Do you see any changes in size, shape or colour. Swelling? Puckering of the skin? Raise your arms and check again.`
  String get selfCheckStep2Body {
    return Intl.message(
      'Do you see any changes in size, shape or colour. Swelling? Puckering of the skin? Raise your arms and check again.',
      name: 'selfCheckStep2Body',
      desc: '',
      args: [],
    );
  }

  /// `Feel`
  String get selfCheckStep3Title {
    return Intl.message(
      'Feel',
      name: 'selfCheckStep3Title',
      desc: '',
      args: [],
    );
  }

  /// `Use the pads of your fingers and feel your breast. Follow a pattern. Feel for lumps, hardened knots and thickenings.`
  String get selfCheckStep3Body {
    return Intl.message(
      'Use the pads of your fingers and feel your breast. Follow a pattern. Feel for lumps, hardened knots and thickenings.',
      name: 'selfCheckStep3Body',
      desc: '',
      args: [],
    );
  }

  /// `Circles`
  String get selfCheckStep4Title {
    return Intl.message(
      'Circles',
      name: 'selfCheckStep4Title',
      desc: '',
      args: [],
    );
  }

  /// `Keep your fingers together and flat. Move in small circles. Repeat using light, medium and then firm pressure. With firm pressure you should feel your ribcage.`
  String get selfCheckStep4Body {
    return Intl.message(
      'Keep your fingers together and flat. Move in small circles. Repeat using light, medium and then firm pressure. With firm pressure you should feel your ribcage.',
      name: 'selfCheckStep4Body',
      desc: '',
      args: [],
    );
  }

  /// `Armpit`
  String get selfCheckStep5Title {
    return Intl.message(
      'Armpit',
      name: 'selfCheckStep5Title',
      desc: '',
      args: [],
    );
  }

  /// `Cover all the way up to your armpit. The left hand feels the right side and the right hand feels the left side.`
  String get selfCheckStep5Body {
    return Intl.message(
      'Cover all the way up to your armpit. The left hand feels the right side and the right hand feels the left side.',
      name: 'selfCheckStep5Body',
      desc: '',
      args: [],
    );
  }

  /// `Nipple`
  String get selfCheckStep6Title {
    return Intl.message(
      'Nipple',
      name: 'selfCheckStep6Title',
      desc: '',
      args: [],
    );
  }

  /// `Squeeze the nipple. Is there any unusual discharge?`
  String get selfCheckStep6Body {
    return Intl.message(
      'Squeeze the nipple. Is there any unusual discharge?',
      name: 'selfCheckStep6Body',
      desc: '',
      args: [],
    );
  }

  /// `Lie down`
  String get selfCheckStep7Title {
    return Intl.message(
      'Lie down',
      name: 'selfCheckStep7Title',
      desc: '',
      args: [],
    );
  }

  /// `Lie down so the tissue spreads out evenly. Repeat the examination of your breasts.`
  String get selfCheckStep7Body {
    return Intl.message(
      'Lie down so the tissue spreads out evenly. Repeat the examination of your breasts.',
      name: 'selfCheckStep7Body',
      desc: '',
      args: [],
    );
  }

  /// `DID YOU NOTICE ANYTHING UNUSUAL?`
  String get selfCheckFinishTitle {
    return Intl.message(
      'DID YOU NOTICE ANYTHING UNUSUAL?',
      name: 'selfCheckFinishTitle',
      desc: '',
      args: [],
    );
  }

  /// `Keep calm - most changes are not dangerous.\n\nCheck again after your next menstrual cycle. If it's still there, consult your doctor or health professional.`
  String get selfCheckFinishBody {
    return Intl.message(
      'Keep calm - most changes are not dangerous.\n\nCheck again after your next menstrual cycle. If it\'s still there, consult your doctor or health professional.',
      name: 'selfCheckFinishBody',
      desc: '',
      args: [],
    );
  }

  /// `No reminder Added Yet!`
  String get emptyReminder {
    return Intl.message(
      'No reminder Added Yet!',
      name: 'emptyReminder',
      desc: '',
      args: [],
    );
  }

  /// `Add Reminder`
  String get addReminder {
    return Intl.message(
      'Add Reminder',
      name: 'addReminder',
      desc: '',
      args: [],
    );
  }

  /// `Menstrual Self Check`
  String get addReminderHint {
    return Intl.message(
      'Menstrual Self Check',
      name: 'addReminderHint',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get addReminderTitle {
    return Intl.message(
      'Title',
      name: 'addReminderTitle',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get addReminderDate {
    return Intl.message(
      'Date',
      name: 'addReminderDate',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get addReminderTime {
    return Intl.message(
      'Time',
      name: 'addReminderTime',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Title`
  String get addRemindertitleError {
    return Intl.message(
      'Please Enter Title',
      name: 'addRemindertitleError',
      desc: '',
      args: [],
    );
  }

  /// `Please Pick a Date`
  String get addReminderDateError {
    return Intl.message(
      'Please Pick a Date',
      name: 'addReminderDateError',
      desc: '',
      args: [],
    );
  }

  /// `Please Pick a Time`
  String get addReminderTimeError {
    return Intl.message(
      'Please Pick a Time',
      name: 'addReminderTimeError',
      desc: '',
      args: [],
    );
  }

  /// `You will be reminded {duration} later`
  String addReminderSnakeBar(Object duration) {
    return Intl.message(
      'You will be reminded $duration later',
      name: 'addReminderSnakeBar',
      desc: '',
      args: [duration],
    );
  }

  /// `days`
  String get days {
    return Intl.message(
      'days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `hours`
  String get hours {
    return Intl.message(
      'hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `minutes`
  String get minutes {
    return Intl.message(
      'minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `seconds`
  String get seconds {
    return Intl.message(
      'seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `What Is a Mammogram?`
  String get mammogramHintTitle {
    return Intl.message(
      'What Is a Mammogram?',
      name: 'mammogramHintTitle',
      desc: '',
      args: [],
    );
  }

  /// `A mammogram is an X-ray picture of the breast. Doctors use a mammogram to look for early signs of breast cancer. Regular mammograms are the best tests doctors have to find breast cancer early, sometimes up to three years before it can be felt.`
  String get mammogramHintBody {
    return Intl.message(
      'A mammogram is an X-ray picture of the breast. Doctors use a mammogram to look for early signs of breast cancer. Regular mammograms are the best tests doctors have to find breast cancer early, sometimes up to three years before it can be felt.',
      name: 'mammogramHintBody',
      desc: '',
      args: [],
    );
  }

  /// `Mammogram`
  String get mammogram {
    return Intl.message(
      'Mammogram',
      name: 'mammogram',
      desc: '',
      args: [],
    );
  }

  /// `What is {mammogram} ?`
  String whatis(Object mammogram) {
    return Intl.message(
      'What is $mammogram ?',
      name: 'whatis',
      desc: '',
      args: [mammogram],
    );
  }

  /// `Click to Upload Image`
  String get waitingforimage {
    return Intl.message(
      'Click to Upload Image',
      name: 'waitingforimage',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get uploadimage {
    return Intl.message(
      'Upload Image',
      name: 'uploadimage',
      desc: '',
      args: [],
    );
  }

  /// `Change Image`
  String get changeimage {
    return Intl.message(
      'Change Image',
      name: 'changeimage',
      desc: '',
      args: [],
    );
  }

  /// `The Patient should be photographed by a {mammogram}`
  String mammographyNote(Object mammogram) {
    return Intl.message(
      'The Patient should be photographed by a $mammogram',
      name: 'mammographyNote',
      desc: '',
      args: [mammogram],
    );
  }

  /// `Get Analysis Result`
  String get getpredictionresultbutton {
    return Intl.message(
      'Get Analysis Result',
      name: 'getpredictionresultbutton',
      desc: '',
      args: [],
    );
  }

  /// `Analysis Result`
  String get predictionresult {
    return Intl.message(
      'Analysis Result',
      name: 'predictionresult',
      desc: '',
      args: [],
    );
  }

  /// `Generate Pdf`
  String get generatePdfButton {
    return Intl.message(
      'Generate Pdf',
      name: 'generatePdfButton',
      desc: '',
      args: [],
    );
  }

  /// `Please select some locations`
  String get filterDoctorListError {
    return Intl.message(
      'Please select some locations',
      name: 'filterDoctorListError',
      desc: '',
      args: [],
    );
  }

  /// `Filter Doctor List`
  String get filterDoctorList {
    return Intl.message(
      'Filter Doctor List',
      name: 'filterDoctorList',
      desc: '',
      args: [],
    );
  }

  /// `Locations`
  String get locations {
    return Intl.message(
      'Locations',
      name: 'locations',
      desc: '',
      args: [],
    );
  }

  /// `Experience`
  String get experience {
    return Intl.message(
      'Experience',
      name: 'experience',
      desc: '',
      args: [],
    );
  }

  /// `years`
  String get years {
    return Intl.message(
      'years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message(
      'Rating',
      name: 'rating',
      desc: '',
      args: [],
    );
  }

  /// `Biography`
  String get biography {
    return Intl.message(
      'Biography',
      name: 'biography',
      desc: '',
      args: [],
    );
  }

  /// `Specialist`
  String get specialist {
    return Intl.message(
      'Specialist',
      name: 'specialist',
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
