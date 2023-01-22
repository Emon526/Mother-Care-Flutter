// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';

class ModelProvider extends ChangeNotifier {
  final kModelName = "breastcancerprediction";
  FirebaseCustomModel? model;

  // Future<void> loadModel() async {
  //   String? res = await Tflite.loadModel(
  //     model: "assets/model_unquant.tflite",
  //     labels: "assets/labels.txt",
  //     // useGpuDelegate: true,
  //   );
  //   print(res);
  // }

  initWithLocalModel() async {
    final _model = await FirebaseModelDownloader.instance.getModel(
      kModelName,
      FirebaseModelDownloadType.localModel,
      //  FirebaseModelDownloadConditions(
      //     iosAllowsCellularAccess: true,
      //     iosAllowsBackgroundDownloading: false,
      //     androidChargingRequired: false,
      //     androidWifiRequired: false,
      //     androidDeviceIdleRequired: false,
      //   )
    );

    model = _model;

    log('Model name: ${model!.name}');
    await loadTFLiteModel(model!.file);
  }

  static Future<String> loadTFLiteModel(File modelFile) async {
    try {
      final appDirectory = await getApplicationDocumentsDirectory();
      final labelsData = await rootBundle.load('assets/labels.txt');
      final labelsFile = await File('${appDirectory.path}/_labels.txt')
          .writeAsBytes(labelsData.buffer
              .asUint8List(labelsData.offsetInBytes, labelsData.lengthInBytes));
      assert(await Tflite.loadModel(
            model: modelFile.path,
            labels: labelsFile.path,
            isAsset: false,
          ) ==
          'success');
      return 'Model is loaded';
    } catch (exception) {
      print(
          'Failed on loading your model to the TFLite interpreter: $exception');
      print('The program will not be resumed');
      rethrow;
    }
  }
}
