// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../providers/modelprovider.dart';
import '../../providers/predictionprovider.dart';
import '../../utils/utils.dart';
import 'result.dart';

class MemmographyPrediction extends StatefulWidget {
  const MemmographyPrediction({super.key});

  @override
  State<MemmographyPrediction> createState() => _MemmographyPredictionState();
}

class _MemmographyPredictionState extends State<MemmographyPrediction> {
  ImagePicker picker = ImagePicker();
  File? pickedimage;
  @override
  void initState() {
    super.initState();
    _showMammogramInfoDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    void pickImage() async {
      try {
        var image = await picker.pickImage(source: ImageSource.gallery);
        if (image == null) return;

        setState(() {
          pickedimage = File(image.path);
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
          ),
        );
      }
    }

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.mammographyscreening),
        // centerTitle: true,
      ),
      body: context.watch<ModelProvider>().isDownloading
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Downloading Model')
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(
                                Consts.DefaultBorderRadius)),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.mammographyNote),
                        Text(
                          AppLocalizations.of(context)!.mammogram,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Container(
                      height: size.width * 0.7,
                      width: size.width * 0.7,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius:
                            BorderRadius.circular(Consts.DefaultBorderRadius),
                        border: Border.all(
                          width: 2.0,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          style: BorderStyle.solid,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: pickedimage == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.waitingforimage,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18.0,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  label: Text(AppLocalizations.of(context)!
                                      .uploadimage),
                                  onPressed: pickImage,
                                  icon: const Icon(Icons.photo_camera_outlined),
                                ),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Consts.DefaultBorderRadius),
                              child: Image.file(
                                pickedimage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    pickedimage == null
                        ? GestureDetector(
                            onTap: () => Utils(context).showCustomDialog(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 5.0, bottom: 5.0),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .mammogramHintTitle,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Consts.DefaultBorderRadius),
                                      child: Image.asset(
                                        'assets/images/mammogram.jpeg',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .mammogramHintBody,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: AppLocalizations.of(context)!.whatis,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                ),
                                children: [
                                  TextSpan(
                                      text:
                                          '${AppLocalizations.of(context)!.mammogram}?',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              ElevatedButton.icon(
                                label: Text(
                                  AppLocalizations.of(context)!.changeimage,
                                ),
                                onPressed: pickImage,
                                icon: const Icon(Icons.photo_camera_outlined),
                              ),
                              ElevatedButton.icon(
                                onPressed: () async {
                                  await context
                                      .read<PredictionProvider>()
                                      .prediction(
                                        image: pickedimage!,
                                      );
                                  await PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: const PredictionResult(),
                                    withNavBar:
                                        false, // OPTIONAL VALUE. True by default.
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                icon: const Icon(
                                  Icons.description_outlined,
                                ),
                                label: Text(AppLocalizations.of(context)!
                                    .getpredictionresultbutton),
                              ),
                            ],
                          ),
                  ],
                ),
              ],
            ),
    );
  }

  Future<void> _showMammogramInfoDialog(
    BuildContext context,
  ) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Utils(context).showCustomDialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(
                  AppLocalizations.of(context)!.mammogramHintTitle,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                child: Image.asset(
                  'assets/images/mammogram.jpeg',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                AppLocalizations.of(context)!.mammogramHintBody,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      );
    });
  }
}
