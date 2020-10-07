import 'package:app/ioc/injection_manager.dart';
import 'package:app/ioc/injector.dart';
import 'package:flutter/material.dart';

import 'feature.dart';

abstract class Module implements InjectionManager {
  final Map<String, Feature> features;

  Module(this.features);

  Map<String, WidgetBuilder> routes() => {};

  @override
  Future<void> register(Injector injector) async {
    features.values.forEach((element) {
      element.register(injector);
    });
  }

  Feature getFeatureByKey(String key) {
    return features[key];
  }

  Future<dynamic> navigateToFeature(BuildContext context, String key,
      {dynamic arguments}) {
    var feature = getFeatureByKey(key);
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => feature.build(
          null,
          arguments: arguments,
        ),
      ),
    );
  }
}
