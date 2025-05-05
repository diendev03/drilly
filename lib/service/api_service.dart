import 'package:drilly/model/drillier.dart';
import 'package:drilly/utils/date_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {

  Future<Drillier?> signUpAndSaveUser({
    required String email,
    required String password,
  }) async {
    UserCredential firebaseResponse = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = firebaseResponse.user!.uid;

    Drillier newUser = Drillier(
      uuid: uid,
      email: email,
      password: password,
      createAt: DateTimeUtils().getCurrentDate(),
    );

    final insertResponse = await Supabase.instance.client
        .from('drilliers')
        .insert(newUser.toMap())
        .select()
        .single();

    Drillier account = Drillier.fromMap(insertResponse);

    return account;
  }


  Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print("Email reset mật khẩu đã được gửi đến $email.");
    } catch (e) {
      print("Lỗi khi gửi email reset mật khẩu: $e");
    }
  }

  Future<Drillier?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential firebaseResponse = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = firebaseResponse.user!.uid;

      final response = await Supabase.instance.client
          .from('drilliers')
          .select()
          .eq('uuid', uid)
          .single();

       Drillier user = Drillier.fromMap(response);

      return user;

    } catch (e) {
      print('Lỗi khi đăng nhập: $e');
      return null;
    }
  }
}
