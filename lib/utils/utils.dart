import 'dart:developer';

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
      barrierDismissible: false,
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

  String translateText({required String string}) {
    // log(string);
    var input = string;
    final bengaliTranslation = Intl.message(
      input,
      locale: context.read<LanguageProvider>().languageCode,
      // args: [],
      // desc: 'Cancerers',
    );

    print(
        '${context.read<LanguageProvider>().languageCode}: $bengaliTranslation');
    return bengaliTranslation;
  }
}
