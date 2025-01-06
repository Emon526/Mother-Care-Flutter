import 'package:flutter/material.dart';

class ResponsiveGridView extends StatelessWidget {
  final Widget Function(BuildContext, int) itemBuilder;
  final int? itemCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double maxWidth;

  const ResponsiveGridView(
      {required this.itemBuilder,
      this.itemCount,
      this.mainAxisSpacing = 8,
      this.crossAxisSpacing = 8,
      this.maxWidth = 350,
      super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double containerWidth = constraints.maxWidth;
        // debugPrint(containerWidth.toString());
        final int itemPerRow =
            (containerWidth / (maxWidth + crossAxisSpacing)).floor();
        // debugPrint(itemPerRow.toString());
        return GridView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: itemCount,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: itemPerRow == 0 ? 1 : itemPerRow,
            // crossAxisCount: itemPerRow,
            // childAspectRatio: aspectRatio,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisSpacing: crossAxisSpacing,
            // mainAxisExtent: 310,
          ),
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}
