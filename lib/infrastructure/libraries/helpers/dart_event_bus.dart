import 'package:app/commons/helpers/event_bus_helper.dart';
import 'package:event_bus/event_bus.dart';

class DartEventBus implements EventBusHelper {
  final EventBus _eventBus = EventBus();

  @override
  void destroy() {
    _eventBus.destroy();
  }

  @override
  void fire(event) {
    _eventBus.fire(event);
  }

  @override
  Stream<T> on<T>() {
    return _eventBus.on<T>();
  }
}
