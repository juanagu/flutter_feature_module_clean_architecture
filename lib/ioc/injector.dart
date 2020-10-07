import 'package:app/ioc/get_it_implementation/get_it_injector.dart';

typedef FactoryFunc<T> = T Function();

abstract class Injector {
  void registerFactory<T>(FactoryFunc<T> factoryFunc);

  void registerFactoryByName<T>(FactoryFunc<T> factoryFunc, String name);

  void registerSingleton<T>(T instance);

  void registerLazySingleton<T>(FactoryFunc<T> factoryFunc);

  void registerLazySingletonByName<T>(FactoryFunc<T> factoryFunc, String name);

  void clear();

  T resolve<T>();

  T resolveByName<T>(String name);

  static Injector getInstance() {
    return GetItInjector();
  }
}
