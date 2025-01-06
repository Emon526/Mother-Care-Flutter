import 'package:flutter/material.dart';

import '../const/consts.dart';
import '../utils/utils.dart';

class SelfCheckStepWidget extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const SelfCheckStepWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final size = Utils(context).getScreenSize;

    return MediaQuery.of(context).orientation == Orientation.portrait
        ? Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                description,
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: size.width * 0.015,
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // SizedBox(
                    //   height: size.height * 0.015,
                    // ),
                    Text(
                      description,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
