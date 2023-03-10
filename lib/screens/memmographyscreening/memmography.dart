// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../providers/modelprovider.dart';
import '../../providers/predictionprovider.dart';
import '../../widget/mammogramnote.dart';
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
        title: const Text('Memmography Screening'),
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
                const MammogramNote(),
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
                                  'Waiting for Image',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18.0,
                                  ),
                                ),
                                ElevatedButton.icon(
                                  label: const Text('Upload Image'),
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
                            onTap: () {},
                            child: RichText(
                              text: const TextSpan(
                                text: 'What is ',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                      text: 'Mammogram?',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      )),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              ElevatedButton.icon(
                                label: const Text('Change Image'),
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
                                label: const Text('Get Prediction Result'),
                              ),
                            ],
                          ),
                  ],
                ),
              ],
            ),
    );
  }
}
