import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/consts.dart';
import '../providers/themeprovider.dart';

class ThemeRadioButtonWidget extends StatelessWidget {
  const ThemeRadioButtonWidget({
    super.key,
    required this.ontap,
    required this.themetitle,
    required this.themeMode,
  });
  final Function ontap;
  final String themetitle;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
      onTap: () => ontap(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              themetitle,
            ),
            context.watch<ThemeProvider>().themeMode == themeMode
                ? Icon(
                    Icons.radio_button_checked,
                    color: Theme.of(context).primaryColor,
                  )
                : Icon(
                    Icons.radio_button_unchecked,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
          ],
        ),
      ),
    );
  }
}
