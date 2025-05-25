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

  Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print("Email reset mật khẩu đã được gửi đến $email.");
    } catch (e) {
      print("Lỗi khi gửi email reset mật khẩu: $e");
    }
  }

  Future<Response?> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post('/login', data: {
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

}
