import 'package:drilly/model/account.dart';
import 'package:drilly/model/profile.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:drilly/utils/date_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ApiService {
  final SupabaseClient _supabase = Supabase.instance.client;
  String accountTable = ConstRes.accounts;
  String profileTable = ConstRes.profiles;
  Future<Account?> signUpAndSaveUser({
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

      Account account = Account(
        uuid: uid,
        email: email,
        password: password,
        createAt: DateTimeUtils.getCurrentDate(),
      );

      final insertAccount = await _supabase
          .from(accountTable)
          .insert(account.toMap())
          .select()
          .single();

      await _supabase.from(profileTable).insert(Profile.empty(uid).toMap());
      Account newAccount = Account.fromMap(insertAccount);

      return newAccount;
    } catch (e) {
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

  Future<Account?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential firebaseResponse =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = firebaseResponse.user!.uid;
      Account? user = await getRecord<Account>(
          tableName: accountTable,
          columnName: ConstRes.uuid,
          value: uid,
          fromMap: (map) => Account.fromMap(map));
      return user;
    } catch (e) {
      return null;
    }
  }

  Future<T?> getRecord<T>({
    required String tableName,
    required String columnName,
    required String value,
    required T Function(Map<String, dynamic>) fromMap,
  }) async {
    try {
      final response = await _supabase
          .from(tableName)
          .select()
          .eq(columnName, value)
          .single();

      // Chuyển đổi Map thành đối tượng của loại T (Account, Profile, v.v...)
      return fromMap(response);
    } catch (e) {
      print('Lỗi khi lấy dữ liệu: $e');
      return null;
    }
  }
}
