typedef ProgressCallback = void Function(int count, int total);

abstract class HttpHelper {
  Future<HttpResponse> post(
    String path, {
    dynamic data,
  });

  Future<HttpResponse> get(String url, {Duration cacheTime});
}

class HttpResponse {
  final dynamic data;
  final int statusCode;

  HttpResponse(
    this.data,
    this.statusCode,
  );

  bool isOk() {
    return statusCode == 200;
  }
}

class HttpRequestError implements Exception {
  final int statusCode;
  final String data;
  final Exception stackTrace;

  const HttpRequestError(
    this.statusCode,
    this.data,
    this.stackTrace,
  );

  @override
  String toString() =>
      'HttpRequestError: statusCode -> $statusCode, data -> $data';
}
