import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../const/consts.dart';
import '../../widget/mammogramnote.dart';

class PredictionResult extends StatefulWidget {
  const PredictionResult({
    super.key,
    required this.image,
  });
  final File image;

  @override
  State<PredictionResult> createState() => _PredictionResultState();
}

class _PredictionResultState extends State<PredictionResult> {
  bool _loading = false;
  List? _outputs;

  @override
  void initState() {
    _loading = true;
    loadModel().then((value) {
      prediction(image: widget.image);
    });
    super.initState();
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  Future<void> loadModel() async {
    String? res = await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
      // useGpuDelegate: true,
    );
    print(res);
  }

  void prediction({required File image}) async {
    try {
      setState(() {
        _loading = true;
      });
      await classifyImage(image);
      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prediction Result',
        ),
      ),
      body: _loading
          ? Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator.adaptive(),
            )
          : Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const MammogramNote(),
                  SfRadialGauge(
                      enableLoadingAnimation: true,
                      animationDuration: 4500,
                      axes: <RadialAxis>[
                        RadialAxis(
                            interval: 10,
                            startAngle: 90,
                            endAngle: 90,
                            showTicks: false,
                            showLabels: false,
                            axisLineStyle: const AxisLineStyle(
                              thickness: 30,
                              // cornerStyle: CornerStyle.bothCurve,
                              // thicknessUnit: GaugeSizeUnit.logicalPixel,
                              // gradient: SweepGradient(
                              //   colors: <Color>[
                              //     Colors.green,
                              //     Colors.yellow,
                              //     Colors.red,
                              //   ],
                              //   stops: <double>[0.4, 0.7, 1],
                              // ),
                            ),
                            // ranges: <GaugeRange>[
                            //   GaugeRange(
                            //       startValue: 0,
                            //       endValue: 40,
                            //       color: Colors.green,
                            //       startWidth: 10,
                            //       endWidth: 10),
                            //   GaugeRange(
                            //       startValue: 40,
                            //       endValue: 70,
                            //       color: Colors.orange,
                            //       startWidth: 10,
                            //       endWidth: 10),
                            //   GaugeRange(
                            //     startValue: 70,
                            //     endValue: 100,
                            //     color: Colors.red,
                            //     startWidth: 10,
                            //     endWidth: 10,
                            //   ),
                            // ],
                            pointers: <GaugePointer>[
                              RangePointer(
                                value: double.parse(
                                  (_outputs![0]["confidence"] * 100)
                                      .toStringAsFixed(1),
                                ),
                                width: 30,
                                gradient: const SweepGradient(
                                  colors: <Color>[
                                    Consts.primaryColor,
                                    Consts.darkprimaryColor,
                                  ],
                                  stops: <double>[
                                    0.4,
                                    1,
                                  ],
                                ),
                                enableAnimation: true,
                                cornerStyle: CornerStyle.bothCurve,
                              ),
                              MarkerPointer(
                                enableAnimation: true,
                                markerType: MarkerType.circle,
                                color: Theme.of(context).colorScheme.secondary,
                                markerHeight: 20,
                                markerWidth: 20,
                                value: double.parse(
                                      (_outputs![0]["confidence"] * 100)
                                          .toStringAsFixed(1),
                                    ) -
                                    2,
                              ),
                              // NeedlePointer(
                              //   value: double.parse(
                              //     (outputs![0]["confidence"] * 100).toStringAsFixed(1),
                              //   ),
                              // ),
                              // WidgetPointer(
                              //   value: double.parse(
                              //     (outputs![0]["confidence"] * 100).toStringAsFixed(1),
                              //   ),
                              //   child: Text(
                              //       '${(outputs![0]["confidence"] * 100).toStringAsFixed(1)}'),
                              // ),
                            ],
                            annotations: <GaugeAnnotation>[
                              GaugeAnnotation(
                                widget: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${(_outputs![0]["confidence"] * 100).toStringAsFixed(1)}',
                                          style: const TextStyle(
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Text(
                                          '%',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '${_outputs![0]["label"]}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                // angle: 270,
                                positionFactor: 0.1,
                              )
                            ])
                      ]),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.save_outlined,
                    ),
                    label: const Text('Download Pdf'),
                  ),
                ],
              ),
            ),
    );
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
