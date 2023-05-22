import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../const/consts.dart';
import '../providers/languageprovider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
  Size get getScreenSize => MediaQuery.of(context).size;

  onWillPop() async {
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
                onPressed: () => Navigator.of(context).pop(true),
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

//TODO: Translate prediction output Text is not working
  String translateText({required String string}) {
    // log(string);
    var input = string;
    final bengaliTranslation = Intl.message(
      input,
      locale: context.read<LanguageProvider>().languageCode,
      // args: [],
      // desc: 'Cancerers',
    );

    debugPrint(
        '${context.read<LanguageProvider>().languageCode}: $bengaliTranslation');
    return bengaliTranslation;
  }

  RichText boldsentenceword({
    required String text,
    required List<String> boldTextList,
    TextAlign? textAlign,
  }) {
    List<InlineSpan> spans = [];

    // Iterate through the text and check for matches with the bold text list
    int startIndex = 0;
    int endIndex = 0;

    while (startIndex < text.length) {
      bool foundMatch = false;

      // Check for matches with each item in the bold text list
      for (String boldText in boldTextList) {
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

          // Add the bold text part
          spans.add(TextSpan(
            text: text.substring(startIndex, endIndex),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              // color: Colors.red,
            ),
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
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
