import 'package:flutter/material.dart';

import '../const/consts.dart';
import 'settingsitemwidget.dart';

class SettingsButtonItem extends StatelessWidget {
  final String label;
  final String buttonLabel;
  final void Function() onTap;

  const SettingsButtonItem({
    super.key,
    required this.label,
    required this.buttonLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsItem(
      label: label,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius)),
        ),
        onPressed: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            buttonLabel,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
