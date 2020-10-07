import 'package:app/ioc/injector.dart';
import 'package:flutter/material.dart';

typedef OnResult = void Function(FeatureResult featureResult);

abstract class Feature {
  Future<void> register(Injector injector);
  Widget build(OnResult onResult, {dynamic arguments});
}

abstract class FeatureResult {
  final BuildContext context;
  final dynamic data;

  FeatureResult(
    this.context,
    this.data,
  );
}
