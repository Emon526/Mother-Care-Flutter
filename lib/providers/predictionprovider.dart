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






// import 'dart:developer';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:tflite_flutter/tflite_flutter.dart';
// import 'package:image/image.dart';
// import 'modelprovider.dart';

// class PredictionProvider extends ChangeNotifier {
//   bool _loading = true;
//   bool get loading => _loading;
//   List? _output;
//   List? get output => _output;

//   Object? _objectoutput;
//   Object? get objectoutput => _objectoutput;

//   late Interpreter _interpreter;
//   final _modelFile = 'model/model_unquant.tflite';
//   final _vocabFile = 'labels.txt';

//   Future<void> prediction({required File image}) async {
//     // await _loadModel();
//     await classifyImage(image);
//     log('Prediction Done');
//     _loading = false;
//     notifyListeners();
//   }

// //   classifyImage(File imageFile) async {
// //     Interpreter interpreter =
// //         await Interpreter.fromAsset(_modelFile, options: InterpreterOptions());
// //     var _inputShape = interpreter.getInputTensor(0).shape;
// //     var _outputShape = interpreter.getOutputTensor(0).shape;
// //     var _inputType = interpreter.getInputTensor(0).type;
// //     var _outputType = interpreter.getOutputTensor(0).type;

// //     log(_inputShape.toString());
// //     log(_outputShape.toString());
// //     log(_inputType.toString());
// //     log(_outputType.toString());
// //     var input = [
// //       [1.23, 6.54, 7.81, 3.21, 2.22]
// //     ];

// // // if output tensor shape [1,2] and type is float32
// //     var output = List.filled(1 * 2, 0).reshape([1, 2]);

// // // inference
// //     interpreter.run(input, output);

// // // print the output
// //     print(output);
// //   }

//   Future<void> classifyImage(File imageFile) async {
//     // Load the TFLite model
//     Interpreter interpreter = await Interpreter.fromAsset(_modelFile);
//     var _inputShape = interpreter.getInputTensor(0).shape;
//     var _outputShape = interpreter.getOutputTensor(0).shape;
//     var _inputType = interpreter.getInputTensor(0).type;
//     var _outputType = interpreter.getOutputTensor(0).type;

//     log(_inputShape.toString());
//     log(_outputShape.toString());
//     log(_inputType.toString());
//     log(_outputType.toString());
//     // Get the image bytes as a Uint8List
//     Uint8List imageBytes = await imageFile.readAsBytes();

//     // Load the image using the image package
//     var image = decodeImage(imageBytes)!;

//     // Resize the image to 225x225 pixels
//     var resizedImage = copyResize(image, width: 225, height: 225);

//     // Convert the resized image to a tensor
//     var tensorImage = ByteConversionUtils.convertBytesToObject(
//         resizedImage.getBytes(), TfLiteType.uint8, [1, 225, 225, 3]);

//     // Run the inference

//     interpreter.run(tensorImage, _objectoutput!);

//     // Get the top prediction
//     // int topIndex =
//     //     _output![0].indexOf(_output![0].reduce((a, b) => a > b ? a : b));

//     // String label = await getLabel(topIndex);

//     // // Get the confidence
//     // double confidence = _output![0][topIndex];
//     log('message');
//     // Close the interpreter to free up resources
//     interpreter.close();

//     // Return the label and confidence
//     // return '$label (${(confidence * 100).toStringAsFixed(1)}%)';
//   }

//   Future<String> getLabel(int index) async {
//     // Load the labels file
//     String labels = await File('labels.txt').readAsString();

//     // Split the labels by newline
//     List<String> labelList = labels.split('\n');

//     // Return the label at the given index
//     return labelList[index];
//   }
// }
