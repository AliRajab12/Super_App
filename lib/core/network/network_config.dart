import 'dart:convert';
import 'dart:io';
import 'package:somi/core/network/auth_interceptor.dart';
import 'package:somi/core/network/cache_control_interceptor.dart';
import 'package:somi/core/network/network_cache_cipher.dart';
import 'package:somi/core/network/page_params.dart';
import 'package:somi/core/repos/auth_data_repo.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'ssl_pinning.dart';

/// Class that helps to create and configure [Dio] instances for common use cases
class NetworkConfig {
  final String baseUrl;
  final Map<String, String> baseHeaders;
  final Duration cacheMaxAge;
  final bool forceRefresh;
  final PageParams pageParams;
  final Map<String, dynamic>? extraQueryParams;
  final int retries;
  final bool includeLocaleId;

  NetworkConfig({
    this.baseUrl = '',
    this.baseHeaders = const {},
    this.cacheMaxAge = Duration.zero,
    this.forceRefresh = false,
    this.pageParams = PageParams.none,
    this.extraQueryParams,
    this.retries = 0,
    this.includeLocaleId = true,
  });

  /// Creates a copy of this configuration with the given fields replaced with the new values
  NetworkConfig copyWith({
    String? baseUrl,
    Map<String, String>? baseHeaders,
    Duration? cacheMaxAge,
    bool? forceRefresh,
    PageParams? pageParams,
    Map<String, dynamic>? extraQueryParams,
    int? retries,
    bool? includeLocaleId,
  }) {
    return NetworkConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      baseHeaders: baseHeaders ?? this.baseHeaders,
      cacheMaxAge: cacheMaxAge ?? this.cacheMaxAge,
      forceRefresh: forceRefresh ?? this.forceRefresh,
      pageParams: pageParams ?? this.pageParams,
      extraQueryParams: extraQueryParams ?? this.extraQueryParams,
      retries: retries ?? this.retries,
      includeLocaleId: includeLocaleId ?? this.includeLocaleId,
    );
  }

  static late final CacheStore _cacheStore;
  static late final AuthDataRepo _authRepo;
  static late final UserRepo _userRepo;
  static late bool _isNetworkLoggerEnabled;

  static Future<void> init({bool isNetworkLoggerEnabled = false}) async {
    final tempDir = await getTemporaryDirectory();
    _cacheStore = FileCacheStore(tempDir.path);
    _authRepo = locator<AuthDataRepo>();
    _userRepo = locator<UserRepo>();
    _isNetworkLoggerEnabled = isNetworkLoggerEnabled;
  }

  static final _cacheControlInterceptor = CacheControlInterceptor(
    maxStale: const Duration(days: 14),
    maxAge: const Duration(hours: 48),
  );

  /// Creates a [Dio] instance using this configuration
  Dio get dio {
    // Configure base options
    var options = BaseOptions(
      baseUrl: baseUrl,
      headers: baseHeaders,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
    );

    // Add paging parameters
    Map<String, dynamic> extraParams = extraQueryParams ?? {};
    pageParams.appendParams(extraParams);

    // Add locale
    if (includeLocaleId) {
      extraParams['localeId'] = _userRepo.user?.localeId ??
          PlatformDispatcher.instance.locale.toLanguageTag();
    }
    options.queryParameters = extraParams;

    // Create Dio instance and add interceptors
    final dio = Dio(options);

    //Init dio for SSL pinning
    //Get the SSL Pin SHA256 according to environment
    //dio.httpClientAdapter = getHTTPClientAdapter(Env.sslPinSHA256List);

    //To log network calls in a pretty, easy to read format.This is disabled by default
    if (_isNetworkLoggerEnabled) {
      dio.interceptors.add(PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: true,
          error: true,
          compact: true,
          maxWidth: 90));
    }

    // Authentication refresh interceptor
    dio.interceptors.add(AuthInterceptor(dio));

    // Handle retries if desired
    if (retries > 0) {
      dio.interceptors.add(RetryInterceptor(dio: dio, retries: retries));
    }

    dio.interceptors.add(_cacheControlInterceptor);

    final cacheOptions = CacheOptions(
      store: _cacheStore,
      policy: forceRefresh ? CachePolicy.refresh : CachePolicy.request,
      cipher: NetworkCacheCipher(),
      hitCacheOnErrorExcept: [401, 403],
    );

    final interceptor = DioCacheInterceptor(options: cacheOptions);
    dio.interceptors.add(interceptor);
    return dio;
  }

  /// Creates an authenticated config
  static NetworkConfig auth({
    bool forceRefresh = false,
    String? overrideToken,
    Map<String, String>? extraHeaders,
    PageParams pageParams = PageParams.none,
    String? hostUrl,
    bool includeLocaleId = true,
  }) {
    var headers = {'Authorization': 'Bearer ${_authRepo.accessToken}'};
    if (extraHeaders != null) headers.addAll(extraHeaders);
    return NetworkConfig(
      baseUrl: hostUrl ?? _authRepo.hostUrl,
      baseHeaders: headers,
      cacheMaxAge: const Duration(hours: 1),
      forceRefresh: forceRefresh,
      pageParams: pageParams,
      includeLocaleId: includeLocaleId,
    );
  }

  /// Creates a basic-auth config
  static NetworkConfig basicAuth({
    Map<String, String> headers = const {},
    Duration cacheMaxAge = Duration.zero,
    bool forceRefresh = false,
    PageParams pageParams = PageParams.none,
    String? hostUrl,
    bool includeLocaleId = true,
  }) {
    final auth =
        base64Encode(utf8.encode('${'Env.clientId'}:${'Env.clientSecret'}'));
    final newHeaders = {'Authorization': 'Basic $auth'};
    newHeaders.addAll(headers);
    return NetworkConfig(
      baseUrl: hostUrl ?? _authRepo.hostUrl,
      baseHeaders: newHeaders,
      cacheMaxAge: cacheMaxAge,
      forceRefresh: forceRefresh,
      pageParams: pageParams,
      includeLocaleId: includeLocaleId,
    );
  }

  /// Creates a non-authenticated config
  static NetworkConfig noAuth({
    Map<String, String> headers = const {},
    Duration cacheMaxAge = Duration.zero,
    bool forceRefresh = false,
    PageParams pageParams = PageParams.none,
    String? hostUrl,
    bool includeLocaleId = true,
  }) {
    return NetworkConfig(
      baseUrl: hostUrl ?? _authRepo.hostUrl,
      baseHeaders: headers,
      cacheMaxAge: cacheMaxAge,
      forceRefresh: forceRefresh,
      pageParams: pageParams,
      includeLocaleId: includeLocaleId,
    );
  }

  /// Clears the cache, deleting only the entries related to path OR clearing everything if path is null
  static Future<void> clearCache({String? path}) {
    if (path != null) {
      final regex = RegExp(path);
      return _cacheStore.deleteFromPath(regex);
    } else {
      return _cacheStore.clean();
    }
  }

  ///This method returns IOHttpClientAdapter for SSL pinning
  IOHttpClientAdapter getHTTPClientAdapter(List<String> sslPinSHA256List) {
    final httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        // Don't trust any certificate just because their root cert is trusted.
        final HttpClient client =
            HttpClient(context: SecurityContext(withTrustedRoots: false));
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      },
      validateCertificate: (cert, host, port) {
        if (cert == null) {
          return false;
        }
        //Extract OpenSSL Pin SHA256.
        final serverPinSHA256 = extractPinSHA256FromCertificate(cert.der);

        //Validating if pinSHA256 in sslPinSHA256List matches the OpenSSL Pin SHA256.
        for (String pinSHA256List in sslPinSHA256List) {
          if (pinSHA256List == serverPinSHA256) {
            return true;
          }
        }

        return false;
      },
    );

    return httpClientAdapter;
  }
}

class NetworkProvider {
  Dio auth({
    bool forceRefresh = false,
    String? overrideToken,
    Map<String, String>? extraHeaders,
    PageParams pageParams = PageParams.none,
    String? hostUrl,
    bool includeLocaleId = true,
  }) {
    return NetworkConfig.auth(
      forceRefresh: forceRefresh,
      overrideToken: overrideToken,
      extraHeaders: extraHeaders,
      pageParams: pageParams,
      hostUrl: hostUrl,
      includeLocaleId: includeLocaleId,
    ).dio;
  }

  Dio basicAuth({
    Map<String, String> headers = const {},
    Duration cacheMaxAge = Duration.zero,
    bool forceRefresh = false,
    PageParams pageParams = PageParams.none,
    String? hostUrl,
    bool includeLocaleId = true,
  }) {
    return NetworkConfig.basicAuth(
      headers: headers,
      cacheMaxAge: cacheMaxAge,
      forceRefresh: forceRefresh,
      pageParams: pageParams,
      hostUrl: hostUrl,
      includeLocaleId: includeLocaleId,
    ).dio;
  }

  Dio noAuth({
    Map<String, String> headers = const {},
    Duration cacheMaxAge = Duration.zero,
    bool forceRefresh = false,
    PageParams pageParams = PageParams.none,
    String? hostUrl,
    bool includeLocaleId = true,
  }) {
    return NetworkConfig.noAuth(
      headers: headers,
      cacheMaxAge: cacheMaxAge,
      forceRefresh: forceRefresh,
      pageParams: pageParams,
      hostUrl: hostUrl,
      includeLocaleId: includeLocaleId,
    ).dio;
  }

  Future<void> clearCache({String? path}) =>
      NetworkConfig.clearCache(path: path);
}
