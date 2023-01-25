// ignore_for_file: avoid_print

import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';

import '../const/consts.dart';

class ModelProvider extends ChangeNotifier {
  final storage = FirebaseStorage.instance;
  final modelDownloader = FirebaseModelDownloader.instance;

  bool _isDownloading = true;
  bool get isDownloading => _isDownloading;

  FirebaseCustomModel? memmographyPredictionModel;
  File? memmographyPredictionLabel;

  void deleteModel() async {
    await modelDownloader
        .deleteDownloadedModel(Consts.MEMMOGRAPHYPREDICTIONMODEL);
  }

  Future<void> initWithLocalModel() async {
    final data = await modelDownloader.listDownloadedModels();

    if (data.isEmpty) {
      memmographyPredictionModel = await downloadModel();
      memmographyPredictionLabel = await downloadLabel();

      await loadTFLiteModel(
        modelFile: memmographyPredictionModel!.file,
        labelFile: memmographyPredictionLabel!,
      );
      log(memmographyPredictionModel!.name);
      log(memmographyPredictionLabel!.path);
      log('Model Downloaded');
    } else {
      final Directory appDirectory = await getApplicationDocumentsDirectory();
      memmographyPredictionModel = data.first;
      memmographyPredictionLabel =
          File('${appDirectory.path}/_${Consts.MEMMOGRAPHYPREDICTIONLABEL}');
      await loadTFLiteModel(
        modelFile: memmographyPredictionModel!.file,
        labelFile: memmographyPredictionLabel!,
      );
      log(memmographyPredictionModel!.name);
      log(memmographyPredictionLabel!.path);
      log('Model loaded');
    }
    _isDownloading = false;
    notifyListeners();
  }

  Future<FirebaseCustomModel> downloadModel() async {
    final model = await modelDownloader.getModel(
        Consts.MEMMOGRAPHYPREDICTIONMODEL,
        FirebaseModelDownloadType.localModel,
        FirebaseModelDownloadConditions(
          iosAllowsCellularAccess: true,
          iosAllowsBackgroundDownloading: false,
          androidChargingRequired: false,
          androidWifiRequired: false,
          androidDeviceIdleRequired: false,
        ));
    return model;
  }

  Future<File> downloadLabel() async {
    final Directory appDirectory = await getApplicationDocumentsDirectory();

    final file =
        File("${appDirectory.path}/${Consts.MEMMOGRAPHYPREDICTIONLABEL}");

    await storage
        .ref()
        .child(Consts.MEMMOGRAPHYPREDICTIONLABEL)
        .writeToFile(file);
    Uint8List bytes = await file.readAsBytes();

    memmographyPredictionLabel =
        await File('${appDirectory.path}/_${Consts.MEMMOGRAPHYPREDICTIONLABEL}')
            .writeAsBytes(bytes);

    return memmographyPredictionLabel!;
  }

  Future<String> loadTFLiteModel({
    required File modelFile,
    required File labelFile,
  }) async {
    try {
      assert(await Tflite.loadModel(
            model: modelFile.path,
            labels: labelFile.path,
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
