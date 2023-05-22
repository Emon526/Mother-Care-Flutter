import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../const/consts.dart';
import '../../providers/pdfgenerateprovider.dart';
import '../../providers/predictionprovider.dart';
import '../../utils/utils.dart';

class PredictionResult extends StatelessWidget {
  const PredictionResult({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PredictionProvider>(
      builder: (context, value, child) {
        var predictionLabel = value.output![0]['label'];
        var predictionConfidence = value.output![0]['confidence'] * 100;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.predictionresult,
            ),
          ),
          body: value.loading
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
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  borderRadius: BorderRadius.circular(
                                      Consts.DefaultBorderRadius)),
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Utils(context).boldsentenceword(
                              text:
                                  AppLocalizations.of(context)!.mammographyNote(
                                AppLocalizations.of(context)!.mammogram,
                              ),
                              boldText: AppLocalizations.of(context)!.mammogram,
                            ),
                          )
                        ],
                      ),
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
                                    // value: double.parse(
                                    //   predictionConfidence.toString(),
                                    // ),
                                    value: predictionConfidence,
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
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    markerHeight: 20,
                                    markerWidth: 20,
                                    // value: double.parse(
                                    //       predictionConfidence
                                    //           .toStringAsFixed(1),
                                    //     ) -
                                    //     2,
                                    value: predictionConfidence - 2,
                                  ),
                                ],
                                annotations: <GaugeAnnotation>[
                                  GaugeAnnotation(
                                    widget: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              Utils(context).formatPersentage(
                                                  number: predictionConfidence),
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
                                          Utils(context).translateText(
                                            string: predictionLabel,
                                          ),
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
                        onPressed: () =>
                            context.read<PdfGenerateProvider>().generateInvoice(
                                  predictionconfidence:
                                      predictionConfidence.toStringAsFixed(1),
                                  predictionresult: predictionLabel,
                                ),
                        icon: const Icon(
                          Icons.save_outlined,
                        ),
                        label: Text(
                          AppLocalizations.of(context)!.generatePdfButton,
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
