import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomErrorWidget extends StatelessWidget {
  final String svgAsset;
  final String message;
  final Size size;
  final EdgeInsets viewPadding;
  final Future<void> Function() onRefresh;

  const CustomErrorWidget({
    required this.svgAsset,
    required this.message,
    required this.size,
    required this.viewPadding,
    required this.onRefresh,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          width: size.width,
          height: size.height - AppBar().preferredSize.height - viewPadding.top,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: SvgPicture.asset(
                  svgAsset,
                  height: size.height * .3,
                ),
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
          ),
        ),
      ),
    );
  }
}
