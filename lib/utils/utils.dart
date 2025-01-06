import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../const/consts.dart';
import '../providers/languageprovider.dart';
import '../providers/nav_bar_provider.dart';
import '../widget/responsivesnackbar.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
  Size get getScreenSize => MediaQuery.of(context).size;

  Widget get verticalSpace {
    return SizedBox(
      height: getScreenSize.height * 0.02,
    );
  }

  void onWillPop() async {
    return showCustomDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppLocalizations.of(context)!.exitTitle,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            AppLocalizations.of(context)!.exitBody,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  AppLocalizations.of(context)!.nobutton,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text(
                  AppLocalizations.of(context)!.yesbutton,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void customLoading() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => Center(
        child: SpinKitDoubleBounce(
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Future showCustomDialog({required Widget child}) async {
    return await showCupertinoModalPopup(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Positioned(
                right: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                ),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  formatDate({required DateTime dateTime}) {
    DateFormat dateFormat = DateFormat(
        'EEE, dd MMMM yyyy', context.read<LanguageProvider>().languageCode);
    String formattedDate = dateFormat.format(dateTime);
    return formattedDate;
  }

  formatNumber({
    required int number,
  }) {
    var f = NumberFormat('###', context.read<LanguageProvider>().languageCode);
    return f.format(number);
  }

  String formatTime({required DateTime dateTime}) {
    DateFormat dateFormat =
        DateFormat('h:mma', context.read<LanguageProvider>().languageCode);
    String formattedDate = dateFormat.format(dateTime);

    if (context.read<LanguageProvider>().languageCode == 'bn') {
      formattedDate = formattedDate.replaceAll('AM', 'এ.এম.');
      formattedDate = formattedDate.replaceAll('PM', 'পি.এম.');
    }
    return formattedDate;
  }

  String formatPersentage({required double number}) {
    // var f = NumberFormat.decimalPattern(
    //         context.read<LanguageProvider>().languageCode)
    //     .format(number);
    // final format =
    //     NumberFormat('##.##', context.read<LanguageProvider>().languageCode);
    var f =
        NumberFormat('###.##', context.read<LanguageProvider>().languageCode);
    return f.format(number);
  }

  String checkEmpty({
    required int duration,
    required String days,
  }) {
    if (duration == 0) {
      return '';
    } else {
      return "${formatNumber(number: duration)} $days ";
    }
  }

  String calculateAge({
    required String dateOfBirth,
  }) {
    DateDuration duration;
    DateFormat dateFormat = DateFormat('EEE, dd MMMM yyyy', 'en');
    DateTime parsedDate = dateFormat.parse(dateOfBirth);

    duration = AgeCalculator.age(parsedDate);

    String ageString = '${checkEmpty(
      duration: duration.years,
      days: AppLocalizations.of(context)!.year,
    )}${checkEmpty(
      duration: duration.months,
      days: AppLocalizations.of(context)!.month,
    )}${checkEmpty(
      duration: duration.days,
      days: AppLocalizations.of(context)!.day,
    )}';
    return ageString;
  }

  RichText boldsentenceword({
    required String text,
    required List<Map<String, String>> boldTextList,
    TextAlign?
        textAlign, // Make sure to pass the context when calling this function
  }) {
    List<InlineSpan> spans = [];

    // Iterate through the text and check for matches with the bold text list
    int startIndex = 0;
    int endIndex = 0;

    while (startIndex < text.length) {
      bool foundMatch = false;

      // Check for matches with each item in the bold text list
      for (Map<String, String> boldTextMap in boldTextList) {
        String boldText = boldTextMap['text']!;
        String url = boldTextMap['url']!;

        endIndex = startIndex + boldText.length;

        if (endIndex <= text.length &&
            text.substring(startIndex, endIndex) == boldText) {
          // Add the regular text part before the bold text
          if (startIndex > 0 && startIndex > endIndex) {
            spans.add(TextSpan(
              text: text.substring(0, startIndex),
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ));
          }

          spans.add(_buildClickableTextSpan(
            text.substring(startIndex, endIndex),
            url,
          ));

          startIndex = endIndex;
          foundMatch = true;
          break;
        }
      }

      if (!foundMatch) {
        endIndex = startIndex + 1;

        // Add the regular text part
        spans.add(TextSpan(
          text: text.substring(startIndex, endIndex),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ));

        startIndex = endIndex;
      }
    }

    return RichText(
      textAlign: textAlign ?? TextAlign.start,
      text: TextSpan(
        children: spans,
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  TextSpan _buildClickableTextSpan(
    String text,
    String url,
  ) {
    if (url != '') {
      return TextSpan(
        text: text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            // Handle the URL press event here
            launchURL(url);
          },
      );
    } else {
      return TextSpan(
        text: text,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  Future<void> launchURL(String url) async {
    try {
      await canLaunchUrl(Uri.parse(url));
      await launchUrl(Uri.parse(url));
    } catch (e) {
      await showsnackbar(message: e.toString());
    }
  }

  Future<void> showsnackbar({required String message}) async {
    await ResponsiveSnackbar.show(context, message);
  }

  Future<void> pushReplacement({required Widget widget}) async {
    await Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (context) => widget),
    );
  }

  Future<void> push({required Widget widget}) async {
    await Navigator.push(
        context, CupertinoPageRoute(builder: (context) => widget));
  }

  Future<void> pushUntil({required Widget widget}) async {
    await Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (_) => widget),
      (Route<dynamic> route) => false,
    );
  }

  void showLicense() {
    showLicensePage(
      context: context,
      //applicationIcon: const MothercareLogo(),
      applicationName: AppLocalizations.of(context)!.appname,
      applicationVersion:
          '${AppLocalizations.of(context)!.version} : ${context.read<NavBarProvider>().appVersionInfo(
                locale: context.read<LanguageProvider>().languageCode,
              )}',
      applicationLegalese:
          '© ${formatNumber(number: DateTime.now().year)} ${AppLocalizations.of(context)!.creditdevelopername1}',
    );
  }
}
