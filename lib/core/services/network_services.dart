// import 'dart:math';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:zee_mart/core/env/env.dart';
import 'package:zee_mart/core/services/di_service.dart';

final HttpService httpService = locator<HttpService>();

final apiService = httpService._dio;

@singleton
class HttpService {
  static final HttpService _instance = HttpService._internal();

  factory HttpService() {
    return _instance;
  }

  HttpService._internal();

  final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  String _baseUrl = const Env().apiSecret;

  String get baseUrl => _baseUrl;

  Dio get dio => _dio;

  void setBaseUrl(String newBaseUrl) {
    _baseUrl = newBaseUrl;
    _dio.options = BaseOptions(baseUrl: _baseUrl);
  }
}
