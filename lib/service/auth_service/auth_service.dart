// ignore_for_file: await_only_futures, avoid_print

import 'package:drilly/service/base_response.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloudinary/cloudinary.dart';

import '../api_client.dart';

class AuthService {
  Dio dio = Dio();
  final api = ApiClient();
  //Create user in Firebase and save to database
  Future<BaseResponse<String>> signUpAndSaveUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await api.post(ConstRes.registerEP, data: {
        'name': name,
        'email': email,
        'password': password,
      });
      return BaseResponse<String>.fromJsonGeneric(response.data);
    } catch (e) {
      return BaseResponse<String>(
        status: false,
        message: "Đăng Ký thất bại",
        data: e.toString(),
      );
    }
  }

  //Forgot password
  Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print("Email reset mật khẩu đã được gửi đến $email.");
    } catch (e) {
      print("Lỗi khi gửi email reset mật khẩu: $e");
    }
  }

  //Login
  Future<BaseResponse<String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(ConstRes.loginEP, data: {
        "email": email,
        "password": password,
      });
      return BaseResponse<String>.fromJsonGeneric(response.data);
    } catch (e) {
      return BaseResponse<String>(
        status: false,
        message: "Đăng nhập thất bại",
        data: e.toString(),
      );
    }
  }

  //Get user profile
  Future<Response?> getUserProfile({required String uuid}) async {
    try {
      Response response = await api.get('/profiles', params: {
        'uuid': uuid,
      });
      if (response.data["status"] == true) {
        print('Lấy thông tin người dùng thành công: ${response.data}');
        return response;
      } else {
        print('Lấy thông tin người dùng thất bại: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Lỗi khi lấy thông tin người dùng: ${e.toString()}');
      return null;
    }
  }

  //Update user profile
  Future<Response> updateProfile({
    required String uuid,
    required String name,
    required String birthday,
    required String phone,
    String? avatarUrl,
  }) async {
    try {
      Response response = await api.put('/profiles', data: {
        'uuid': uuid,
        'name': name,
        'birthday': birthday,
        'phone': phone,
        'avatar': avatarUrl,
      });
      if (response.data["status"] == true) {
        print('Cập nhật thông tin người dùng thành công: ${response.data}');
      } else {
        print(
            'Cập nhật thông tin người dùng thất bại: ${response.statusMessage}');
      }
      return response;
    } catch (e) {
      print('Lỗi khi cập nhật thông tin người dùng: ${e.toString()}');
      rethrow;
    }
  }
}
