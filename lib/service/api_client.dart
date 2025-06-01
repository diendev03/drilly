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
print('Dio instance created with base URL:  ${dio.options.baseUrl}/your_endpoint');
    // Gắn interceptor nếu cần
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onError: (error, handler) {
        print('Lỗi: ${error.message}');
        return handler.next(error);
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    return await dio.get(path, queryParameters: params);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return await dio.put(path, data: data);
  }

  Future<Response> delete(String path, {Map<String, dynamic>? params}) async {
    return await dio.delete(path, queryParameters: params);
  }
}
