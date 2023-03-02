import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyWidget extends StatelessWidget {
  final String svgAsset;
  final String message;
  const EmptyWidget({
    required this.svgAsset,
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: SvgPicture.asset(svgAsset),
        ),
        const SizedBox(
          height: 20,
        ),
        Flexible(
          child: Text(
            message,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
