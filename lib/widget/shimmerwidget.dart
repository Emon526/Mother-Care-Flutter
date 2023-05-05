import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;
  const ShimmerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      // period: const Duration(milliseconds: 3000),
      gradient: LinearGradient(
        colors: [
          // Colors.grey[300]!,
          // Colors.grey[200]!,
          // Colors.grey[300]!,

          // Theme.of(context).primaryColor,
          // Theme.of(context).colorScheme.secondary,
          // Theme.of(context).primaryColor,

          Theme.of(context).colorScheme.secondary,
          Colors.grey[200]!,
          Theme.of(context).colorScheme.secondary,

          // Theme.of(context).primaryColor,
          // Colors.grey[200]!,
          // Theme.of(context).primaryColor,
        ],
        stops: const [
          0.3,
          0.5,
          0.7,
        ],
        begin: const Alignment(-1.0, -0.5),
        end: const Alignment(1.0, 0.5),
        tileMode: TileMode.repeated,
      ),
      child: child,
    );
  }
}
