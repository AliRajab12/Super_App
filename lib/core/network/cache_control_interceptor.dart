import 'package:dio/dio.dart';

class CacheControlInterceptor extends InterceptorsWrapper {
  static const String etagHeader = 'etag';

  final Duration? maxStale;
  final Duration? maxAge;

  CacheControlInterceptor({this.maxStale, this.maxAge});

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (maxStale != null || maxAge != null) {
      response.headers.removeAll('Pragma');
      response.headers.removeAll('pragma');
      response.headers.removeAll('Cache-Control');
      response.headers.removeAll('cache-control');
      if (response.statusCode == 200 && response.headers[etagHeader] == null) {
        response.headers
            .add(etagHeader, DateTime.now().microsecondsSinceEpoch.toString());
      }
    }
    if (maxStale != null) {
      response.headers.add('Cache-Control', 'max-stale=${maxStale!.inSeconds}');
    }
    if (maxAge != null) {
      response.headers.add('Cache-Control', 'max-age=${maxAge!.inSeconds}');
    }
    super.onResponse(response, handler);
  }
}
