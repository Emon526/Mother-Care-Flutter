import 'package:day_night_time_picker/day_night_time_picker.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../const/consts.dart';
import '../providers/reminderprovider.dart';
import '../utils/utils.dart';

class ShowClockWidget {
  BuildContext context;
  TextEditingController controller;
  ShowClockWidget({required this.context, required this.controller}) {
    _showClock();
  }

  _showClock() {
    Navigator.of(context).push(
      showPicker(
        backgroundColor: Theme.of(context).primaryColor,
        dialogInsetPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        borderRadius: Consts.DefaultBorderRadius,
        okText: AppLocalizations.of(context)!.okbutton,
        cancelText: AppLocalizations.of(context)!.cancelbutton,
        hourLabel: AppLocalizations.of(context)!.hours,
        minuteLabel: AppLocalizations.of(context)!.minutes,
        amLabel: AppLocalizations.of(context)!.am,
        pmLabel: AppLocalizations.of(context)!.pm,
        iosStylePicker: true,
        context: context,
        barrierDismissible: false,
        minuteInterval: TimePickerInterval.ONE,
        hmsStyle: const TextStyle(
          color: Colors.white,
        ),
        okStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        cancelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        //TODO: CHECK CLOCK
        value: context.read<ReminderProvider>().time,
        onChange: (newTime) {
          context.read<ReminderProvider>().time = newTime;
        },
        onChangeDateTime: (DateTime dateTime) {
          controller.text = Utils(context).formatTime(
            dateTime: dateTime,
          );
        },
      ),
    );
  }
}
