import 'injector.dart';

abstract class InjectionManager {
  Future<void> register(Injector injector);
}
