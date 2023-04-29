import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/consts.dart';
import '../../widget/responsivegridview.dart';

class DoctorsListShimmer extends StatelessWidget {
  const DoctorsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ResponsiveGridView(
        crossAxisCount: 2,
        itemCount: 10,
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
                child: Shimmer(
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey[300]!,
                      Colors.grey[200]!,
                      Colors.grey[300]!,
                    ],
                    stops: const [
                      0.4,
                      0.5,
                      0.6,
                    ],
                    begin: const Alignment(-1.0, -0.5),
                    end: const Alignment(1.0, 0.5),
                    tileMode: TileMode.repeated,
                  ),
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Consts.DefaultBorderRadius),
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: [
                //       Text(
                //         'doctorModel.doctorname',
                //         textAlign: TextAlign.center,
                //         style: const TextStyle(
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       const SizedBox(
                //         height: 5,
                //       ),
                //       Text(
                //         'doctorModel.speciality',
                //         textAlign: TextAlign.center,
                //       ),
                //       const SizedBox(
                //         height: 5,
                //       ),
                //       Text(
                //         'doctorModel.workplace',
                //         textAlign: TextAlign.center,
                //       ),
                //     ],
                //   ),
                // ),
              );
            },
          );
        },
      ),
    );
  }
}
