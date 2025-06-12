import 'package:dio/dio.dart';
import 'package:drilly/utils/const_res.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late Dio dio;

  ApiClient._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: ConstRes.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? params, Map<String, dynamic>? headers}) async {
    Options? options;
    if (headers != null) {
      options = Options(headers: headers);
    }
    return await dio.get(path, queryParameters: params, options: options);
  }

  Future<Response> post(String path,
      {dynamic data, Map<String, dynamic>? headers}) async {
    Options? options;
    if (headers != null) {
      options = Options(headers: headers);
    }
    return await dio.post(path, data: data, options: options);
  }

  Future<Response> put(String path,
      {dynamic data, Map<String, dynamic>? headers}) async {
    Options? options;
    if (headers != null) {
      options = Options(headers: headers);
    }
    return await dio.put(path, data: data, options: options);
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? params, Map<String, dynamic>? headers}) async {
    Options? options;
    if (headers != null) {
      options = Options(headers: headers);
    }
    return await dio.delete(path, queryParameters: params, options: options);
  }
}
