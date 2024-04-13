import 'package:flutter/material.dart';

import '../const/consts.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final T value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T>? onChanged;
  final bool expanded;

  const CustomDropdownButton({
    super.key,
    required this.value,
    required this.items,
    this.onChanged,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
      ),
      child: DropdownButton<T>(
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.black,
            ),
        iconEnabledColor: Colors.black,
        dropdownColor: Theme.of(context).colorScheme.secondary,
        value: value,
        isExpanded: expanded,
        underline: Container(),
        borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
        items: items,
        onChanged: onChanged == null
            ? null
            : (value) {
                if (value != null) {
                  onChanged!(value);
                }
              },
      ),
    );
  }
}
