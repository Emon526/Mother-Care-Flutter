import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/consts.dart';
import '../providers/themeprovider.dart';
import 'themeradiobuttonwidget.dart';

class ThemeTile extends StatelessWidget {
  const ThemeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: const EdgeInsets.all(5.0),
              alignment: Alignment.topRight,
              child: const Icon(
                Icons.close,
                color: Colors.grey,
                size: 20.0,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5.0, bottom: 8.0),
            child: Text(
              'Select your preferred Theme',
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ThemeRadioButtonWidget(
            themetitle: 'System',
            themeMode: ThemeMode.system,
            ontap: () {
              context.read<ThemeProvider>().themeMode = ThemeMode.system;
            },
          ),
          ThemeRadioButtonWidget(
            themetitle: 'Light',
            themeMode: ThemeMode.light,
            ontap: () {
              context.read<ThemeProvider>().themeMode = ThemeMode.light;
            },
          ),
          ThemeRadioButtonWidget(
            themetitle: 'Dark',
            themeMode: ThemeMode.dark,
            ontap: () {
              context.read<ThemeProvider>().themeMode = ThemeMode.dark;
            },
          ),
        ],
      ),
    );
  }
}
