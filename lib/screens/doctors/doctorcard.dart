import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../const/consts.dart';
import '../../models/doctormodel.dart';
import '../../providers/doctorprovider.dart';
import '../../providers/languageprovider.dart';

class DoctorCardWidget extends StatelessWidget {
  final Function onTap;
  final DoctorModel doctorModel;
  const DoctorCardWidget({
    super.key,
    required this.onTap,
    required this.doctorModel,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageProvider>().languageCode;
    return InkWell(
      borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
      onTap: () {
        onTap();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          // final double containerWidth = constraints.maxWidth;

          //   debugPrint(containerWidth.toString());
          // final double maxWidth = MediaQuery.of(context).size.width * 0.8;
          // final double width =
          //     containerWidth > maxWidth ? maxWidth : containerWidth;
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
            ),
            //  width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(Consts.DefaultBorderRadius),
                      child: FutureBuilder(
                        future: context
                            .read<DoctorProvider>()
                            .getDoctorImage(doctorModel.doctorimagePath),
                        builder: (BuildContext context,
                            AsyncSnapshot<Uint8List?> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return Image.memory(
                              snapshot.data!,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline),
                                  Text('Unable to Load Image'),
                                ],
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline),
                                Text('Unable to Load Image'),
                              ],
                            );
                          }

                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        doctorModel.doctorname[locale],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        doctorModel.speciality[locale],
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        doctorModel.workplace[locale],
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
