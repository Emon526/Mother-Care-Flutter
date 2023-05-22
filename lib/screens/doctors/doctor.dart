import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/consts.dart';
import '../../models/doctormodel.dart';
import '../../providers/doctorprovider.dart';
import '../../providers/languageprovider.dart';
import '../../utils/utils.dart';

class Doctor extends StatelessWidget {
  final DoctorModel doctor;
  const Doctor({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageProvider>().languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          doctor.doctorname[locale],
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxWidth,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Consts.DefaultBorderRadius),
                    child: FutureBuilder(
                      future: context
                          .watch<DoctorProvider>()
                          .getDoctorImage(doctor.doctorimagePath),
                      builder: (BuildContext context,
                          AsyncSnapshot<Uint8List?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Image.memory(
                            snapshot.data!,
                            fit: BoxFit.fill,
                          );
                        }

                        if (snapshot.hasError) {
                          return const SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline),
                                Text('Unable to Load Image'),
                              ],
                            ),
                          );
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  doctor.doctorname[locale],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    // '${doctor.speciality[locale]} ${AppLocalizations.of(context)!.specialist}',
                    '${doctor.speciality[locale]}',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    doctor.degree[locale],
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(
                                  Consts.DefaultBorderRadius)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              children: [
                                Text(AppLocalizations.of(context)!.experience),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    '${Utils(context).formatNumber(number: doctor.experience)}+ ${AppLocalizations.of(context)!.years}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(
                                  Consts.DefaultBorderRadius)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              children: [
                                Text(AppLocalizations.of(context)!.rating),
                                const SizedBox(
                                  height: 5,
                                ),
                                RatingBarIndicator(
                                  itemSize: 20,
                                  rating: doctor.rating,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.biography,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReadMoreText(
                    doctor.bioGraphy[locale],
                    trimLines: 5,
                    colorClickableText: Colors.red,
                    // trimMode: TrimMode.Line,
                    trimMode: TrimMode.Length,

                    trimCollapsedText: AppLocalizations.of(context)!.readmore,
                    trimExpandedText: AppLocalizations.of(context)!.readless,
                    moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //TODO: Add Book Appointment Button
                // Card(
                //   child: InkWell(
                //     onTap: () {},
                //     borderRadius:
                //         BorderRadius.circular(Consts.DefaultBorderRadius),
                //     child: ListTile(
                //       title: Text(
                //         AppLocalizations.of(context)!.bookappointmentbutton,
                //         textAlign: TextAlign.center,
                //         style: const TextStyle(
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Card(
                  child: InkWell(
                    onTap: () => _makePhoneCall(doctor.appointmentNumber),
                    borderRadius:
                        BorderRadius.circular(Consts.DefaultBorderRadius),
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.callforappointmentbutton,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
