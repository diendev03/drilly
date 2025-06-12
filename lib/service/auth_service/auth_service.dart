// ignore_for_file: await_only_futures, avoid_print
import 'package:drilly/utils/const_res.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloudinary/cloudinary.dart';

import '../api_client.dart';

class AuthService {
  String accountTable = ConstRes.accounts;
  String profileTable = ConstRes.profiles;
  Dio dio = Dio();
  final api = ApiClient();
  //Create user in Firebase and save to database
  Future<Response?> signUpAndSaveUser({
    required String email,
    required String password,
  }) async {
    try {
      final existingUser =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (existingUser.isNotEmpty) {
        throw FirebaseAuthException(
          code: 'email-already-in-use',
          message: 'Email này đã được sử dụng cho một tài khoản khác.',
        );
      }

      UserCredential firebaseResponse =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = firebaseResponse.user!.uid;

      Response response = await api.post('/accounts', data: {
        'uuid': uid,
        'email': email,
        'password': password,
      });

      if (response.data["status"]== true) {
        print('Tạo account thành công: ${response.data}');
        return response;
      } else {
        print('Tạo account thất bại: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Tạo account thất bại: ${e.toString()}');
      return null;
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
  Future<Response?> login({
    required String email,
    required String password,
  }) async {
    try {
      print("Đang đăng nhập với email: $email và mật khẩu: $password");
      final response = await api.post('/accounts/login', data: {
        ConstRes.email: email,
        ConstRes.password: password,
      });
      if (response.data["status"]== true) {
        print('Login thành công: ${response.data}');
        print('tra ve: ${response.toString()}');
        return response;
      } else {
        print('Login thất bại: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      return null;
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
      Response response =await api.put('/profiles', data: {
        'uuid': uuid,
        'name': name,
        'birthday': birthday,
        'phone': phone,
        'avatar': avatarUrl,
      });
      if (response.data["status"] == true) {
        print('Cập nhật thông tin người dùng thành công: ${response.data}');
      } else {
        print('Cập nhật thông tin người dùng thất bại: ${response.statusMessage}');
      }
      return response;
    } catch (e) {
      print('Lỗi khi cập nhật thông tin người dùng: ${e.toString()}');
      rethrow;
    }
  }
}
