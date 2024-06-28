import 'package:flutter/material.dart';

import '../../const/consts.dart';
import '../../widget/responsivegridview.dart';
import '../../widget/shimmerwidget.dart';

class DoctorsListShimmer extends StatelessWidget {
  const DoctorsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ResponsiveGridView(
        itemBuilder: (context, index) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final double containerWidth = constraints.maxWidth;
              final double maxWidth = MediaQuery.of(context).size.width * 0.8;
              final double width =
                  containerWidth > maxWidth ? maxWidth : containerWidth;
              return Container(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(Consts.DefaultBorderRadius),
                ),
                width: width,
                child: ShimmerWidget(
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Consts.DefaultBorderRadius),
                    child: Container(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
