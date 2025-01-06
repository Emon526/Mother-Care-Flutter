// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path_provider/path_provider.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';

// import '../const/consts.dart';

// class ModelProvider extends ChangeNotifier {
//   ModelProvider() {
//     checkModel();
//   }
//   final storage = FirebaseStorage.instance;
//   final modelDownloader = FirebaseModelDownloader.instance;

//   bool _isDownloading = false;
//   bool get isDownloading => _isDownloading;

//   static FirebaseCustomModel? memmographyPredictionModel;
//   static File? memmographyPredictionLabel;

//   // void deleteModel() async {
//   //   await modelDownloader
//   //       .deleteDownloadedModel(Consts.MEMMOGRAPHYPREDICTIONMODEL);
//   //   debugPrint('Model Deleted');
//   // }

//   void checkModel() async {
//     _isDownloading = true;
//     final model = await modelDownloader.listDownloadedModels();

//     if (model.isEmpty) {
//       memmographyPredictionModel = await downloadModel();
//       memmographyPredictionLabel = await downloadLabel();
//     } else {
//       final Directory appDirectory = await getApplicationDocumentsDirectory();
//       memmographyPredictionModel = model.first;
//       memmographyPredictionLabel =
//           File('${appDirectory.path}/_${Consts.MEMMOGRAPHYPREDICTIONLABEL}');
//     }

//     _isDownloading = false;
//     notifyListeners();
//   }

//   Future<FirebaseCustomModel> downloadModel() async {
//     final model = await modelDownloader.getModel(
//         Consts.MEMMOGRAPHYPREDICTIONMODEL,
//         FirebaseModelDownloadType.latestModel,
//         FirebaseModelDownloadConditions(
//           iosAllowsCellularAccess: true,
//           iosAllowsBackgroundDownloading: false,
//           androidChargingRequired: false,
//           androidWifiRequired: false,
//           androidDeviceIdleRequired: false,
//         ));
//     return model;
//   }

//   Future<File> downloadLabel() async {
//     final Directory appDirectory = await getApplicationDocumentsDirectory();

//     final file =
//         File("${appDirectory.path}/${Consts.MEMMOGRAPHYPREDICTIONLABEL}");

//     await storage
//         .ref()
//         .child(Consts.MEMMOGRAPHYPREDICTIONLABEL)
//         .writeToFile(file);
//     Uint8List bytes = await file.readAsBytes();

//     memmographyPredictionLabel =
//         await File('${appDirectory.path}/_${Consts.MEMMOGRAPHYPREDICTIONLABEL}')
//             .writeAsBytes(bytes);

//     return memmographyPredictionLabel!;
//   }
// }
