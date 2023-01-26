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

  List? _output;
  List? get output => _output;

  Future<void> prediction({required File image}) async {
    _loading = true;
    try {
      await classifyImage(image);
      // await Tflite.close();
    } catch (e) {
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
