import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

import 'modelprovider.dart';

class PredictionProvider extends ChangeNotifier {
  ModelProvider modelProvider = ModelProvider();
  bool _loading = false;
  bool get loading => _loading;

  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  File? _image;
  File? get image => _image;

  set image(File? image) {
    _image = image;
    log('image');
    notifyListeners();
  }

  List? _output;
  List? get output => _output;

  Future<void> prediction(

      // { required BuildContext context,  }

      ) async {
    _loading = true;
    try {
      await classifyImage(_image!);
      // await Tflite.close();
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(e.toString()),
      //   ),
      // );
      print(e.toString());
    }
    _loading = false;
    notifyListeners();
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
    _output = output!;
    // await Tflite.close();
  }
}
