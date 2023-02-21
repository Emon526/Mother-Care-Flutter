import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

import 'modelprovider.dart';

class PredictionProvider extends ChangeNotifier {
  bool _loading = true;
  bool get loading => _loading;
  List? _output;
  List? get output => _output;

  Future<void> prediction({required File image}) async {
    await initWithLocalModel();
    await classifyImage(image);
    _loading = false;
    notifyListeners();
  }

  Future<void> initWithLocalModel() async {
    await loadTFLiteModel(
      modelFile: ModelProvider.memmographyPredictionModel!.file,
      labelFile: ModelProvider.memmographyPredictionLabel!,
    );
  }

  Future<void> classifyImage(File image) async {
    try {
      _output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5,
      );
      debugPrint('output: $_output');
    } catch (e) {
      debugPrint(e.toString());
    }
    Tflite.close();
    notifyListeners();
  }

  Future<void> loadTFLiteModel({
    required File modelFile,
    required File labelFile,
  }) async {
    try {
      await Tflite.loadModel(
        model: modelFile.path,
        labels: labelFile.path,
        isAsset: false,
      );
      debugPrint('Model loaded');
    } catch (exception) {
      debugPrint(
          'Failed on loading your model to the TFLite interpreter: $exception');
      rethrow;
    }
  }
}
