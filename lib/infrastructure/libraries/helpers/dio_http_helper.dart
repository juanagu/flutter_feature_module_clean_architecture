import 'package:app/commons/helpers/http_helper.dart';
import 'package:app/commons/helpers/oauth_helper.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class DioHttpHelper implements HttpHelper {
  final OAuthHelper _oAuthHelper;

  DioHttpHelper(this._oAuthHelper);

  @override
  Future<HttpResponse> post(
    String path, {
    dynamic data,
  }) async {
    var dio = await _buildDio();
    try {
      var response = await dio.post(
        path,
        data: data,
      );

      return _buildHttpResponse(response);
    } catch (e) {
      var error = _getOrThrowExceptionByResponse(e);
      return _buildErrorHttpResponse(error);
    }
  }

  @override
  Future<HttpResponse> get(String url, {Duration cacheTime}) async {
    var dio = await _buildDio();
    try {
      var response = await dio.get(
        url,
        options: cacheTime != null ? buildCacheOptions(cacheTime) : null,
      );

      return _buildHttpResponse(response);
    } catch (e) {
      var error = _getOrThrowExceptionByResponse(e);
      return _buildErrorHttpResponse(error);
    }
  }

  HttpResponse _buildErrorHttpResponse(HttpRequestError error) {
    return HttpResponse(
      error.data,
      error.statusCode,
    );
  }

  HttpResponse _buildHttpResponse(Response response) {
    return HttpResponse(
      response.data,
      response.statusCode,
    );
  }

  Future<Dio> _buildDio() async {
    var dio = Dio();
    await _checkAuthorization(dio);
    return dio;
  }

  Future _checkAuthorization(Dio dio) async {
    var token = await _oAuthHelper.getToken();
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Exception _getOrThrowExceptionByResponse(Exception e) {
    if (e is DioError && e.response != null) {
      return HttpRequestError(e.response.statusCode, e.response.data, e);
    }

    throw e;
  }
}
