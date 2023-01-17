import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class PredictionProvider extends ChangeNotifier {
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
    notifyListeners();
  }

  List? _output;
  List? get output => _output;

  void prediction({
    required BuildContext context,
  }) async {
    _loading = true;
    try {
      await classifyImage(_image!);
    } catch (e) {
      // print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    _loading = false;
    notifyListeners();
  }

  Future<void> loadModel() async {
    // String? res =
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      // useGpuDelegate: true,
    );
    // print(res);
  }

  Future<void> classifyImage(File image) async {
    await loadModel();
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    Tflite.close();
    // print('output: $output');
    _output = output!;
  }
}
