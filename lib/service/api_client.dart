import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:drilly/generated/l10n.dart';
import 'package:drilly/utils/app_res.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/shared_pref.dart';
// ignore: library_prefixes
import 'package:get/get.dart' as getX;

import '../screens/auth/auth_screen.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late Dio dio;

  ApiClient._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: ConstRes.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    );

    dio = Dio(options);

    dio.interceptors.add(CurlLoggerDioInterceptor(
      printOnSuccess: true,
    ));

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onError: (error, handler) {
        if(error.response?.statusCode==401){
          getX.Get.offAll(()=>const AuthScreen());
          SharePref().remove(ConstRes.token);
          AppRes.showSnackBar(S.current.authenticationFailed);
        }
        return handler.next(error);
      },
    ));
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? params, Map<String, dynamic>? headers}) async {
    Options? options;
    if (headers != null) {
      options = Options(headers: headers);
    }else{
      final token = await SharePref().getString(ConstRes.token);
      if (token != null) {
        options = Options(
          headers: {
            'Authorization':"Bearer ${await SharePref().getString(ConstRes.token)}"}
      );}
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
