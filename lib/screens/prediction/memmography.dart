// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

import 'result.dart';

class MemmographyPrediction extends StatefulWidget {
  const MemmographyPrediction({super.key});

  @override
  State<MemmographyPrediction> createState() => _MemmographyPredictionState();
}

class _MemmographyPredictionState extends State<MemmographyPrediction> {
  bool _loading = false;

  List? _outputs;
  File? _image;

  @override
  void initState() {
    super.initState();
    _loading = true;

    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      // useGpuDelegate: true,
    );
    print(res);
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memmography Prediction'),
        centerTitle: true,
      ),
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator.adaptive(),
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
                            borderRadius: BorderRadius.circular(5)),
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
                      children: const [
                        Text('The Patient should be photographed by a'),
                        Text(
                          'Mammogram',
                          style: TextStyle(
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
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 2.0,
                          strokeAlign: StrokeAlign.outside,
                          style: BorderStyle.solid,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: _image == null
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
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _image == null
                        ? GestureDetector(
                            onTap: () {
                              print('What is Mammogram?');
                            },
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PredictionResult(
                                        outputs: _outputs,
                                      ),
                                    ),
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

  void pickImage() async {
    try {
      ImagePicker picker = ImagePicker();
      var image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        _loading = true;
        _image = File(image.path);
      });
      await classifyImage(_image!);
      setState(() {
        _loading = false;
      });
    } catch (error) {
      setState(() {
        _loading = false;
      });
      print(error);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  Future<void> classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print('output: $output');
    setState(() {
      _outputs = output;
    });
  }
}
