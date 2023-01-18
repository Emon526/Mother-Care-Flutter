import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/themeprovider.dart';
import 'themetile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildListtile(
          tiletitle: 'Theme',
          iconData: context.watch<ThemeProvider>().themeMode == ThemeMode.system
              ? Icons.phonelink_setup_outlined
              : context.watch<ThemeProvider>().themeMode == ThemeMode.light
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
          onTap: () => showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const ThemeTile();
            },
          ),
        ),
      ],
    );
  }

  _buildListtile({
    required IconData iconData,
    required String tiletitle,
    required Function onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: ListTile(
          title: Text(tiletitle),
          trailing: Icon(iconData),
        ),
      ),
    );
  }
}
