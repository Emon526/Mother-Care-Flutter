import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../const/consts.dart';
import '../../widget/mammogramnote.dart';

class PredictionResult extends StatelessWidget {
  const PredictionResult({super.key, required this.outputs});
  final List? outputs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prediction Result',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SfRadialGauge(
              enableLoadingAnimation: true, animationDuration: 4500,
              // title: GaugeTitle(
              //   text: '${outputs![0]["label"]}',
              //   textStyle: const TextStyle(
              //     fontSize: 20.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              axes: <RadialAxis>[
                RadialAxis(
                  startAngle: 95,
                  endAngle: 85,
                  minimum: 0,
                  maximum: 100,
                  showTicks: false,
                  showLabels: false,
                  axisLineStyle: const AxisLineStyle(
                    thickness: 30,
                    cornerStyle: CornerStyle.bothCurve,
                    thicknessUnit: GaugeSizeUnit.logicalPixel,
                    gradient: SweepGradient(
                      colors: <Color>[
                        Colors.green,
                        Colors.yellow,
                        Colors.red,
                      ],
                      stops: <double>[0.4, 0.7, 1],
                    ),
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
                      value: double.parse(
                        (outputs![0]["confidence"] * 100).toStringAsFixed(1),
                      ),
                      // value: 0,
                    ),
                    MarkerPointer(
                      markerType: MarkerType.circle,
                      color: Theme.of(context).colorScheme.secondary,
                      markerHeight: 20,
                      markerWidth: 20,
                      value: double.parse(
                            (outputs![0]["confidence"] * 100)
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
                      verticalAlignment: GaugeAlignment.center,
                      horizontalAlignment: GaugeAlignment.center,
                      widget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${(outputs![0]["confidence"] * 100).toStringAsFixed(1)}',
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
                            '${outputs![0]["label"]}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      // angle: 90,
                      positionFactor: 0.1,
                    )
                  ],
                ),
              ],
            ),
            const MammogramNote(),
          ],
        ),
      ),
    );
  }
}
