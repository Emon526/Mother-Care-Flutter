import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final String label;
  final Widget child;

  const SettingsItem({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 170,
            child: child,
          ),
        ],
      ),
    );
  }
}
