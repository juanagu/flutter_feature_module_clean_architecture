abstract class EventBusHelper {
  Stream<T> on<T>();
  void fire(event);
  void destroy();
}
