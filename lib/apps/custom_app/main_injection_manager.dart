import 'package:app/apps/custom_app/helpers/custom_admin_format_price.dart';
import 'package:app/commons/helpers/price_format_helper.dart';
import 'package:app/feature_module/module.dart';
import 'package:app/ioc/dependencies/common_injection_manager.dart';
import 'package:app/ioc/injector.dart';
import 'package:app/ioc/injection_manager.dart';

class MainInjectionManager implements InjectionManager {
  final List<Module> modules;

  MainInjectionManager(this.modules);

  @override
  Future<void> register(Injector injector) async {
    _injectHelpers(injector);
    var managers = <InjectionManager>[
      CommonInjectionManager(),
    ];
 
    managers.forEach((manager) async {
      await manager.register(injector);
    });

    modules.forEach((module) async {
      await module.register(injector);
    });
  }

  void _injectHelpers(Injector injector) {
    injector
        .registerFactory<PriceFormatHelper>(() => CustomPriceFormatHelper());
  }
}
