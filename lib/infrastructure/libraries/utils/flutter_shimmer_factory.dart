import 'package:app/commons/presentation/utils/shimmer_factory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FlutterShimmerFactory implements ShimmerFactory {
  @override
  Widget create(BuildContext context, Widget child) {
    if (kIsWeb) {
      return Opacity(
        child: child,
        opacity: 0.4,
      );
    }

    return Shimmer.fromColors(
      baseColor: Colors.black12,
      highlightColor: Colors.white12,
      child: child,
    );
  }
}
