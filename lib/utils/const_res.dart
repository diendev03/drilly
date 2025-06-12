import 'package:drilly/generated/l10n.dart';

class ConstRes {
  static const String baseUrl = 'https://b7e4-171-252-153-187.ngrok-free.app';

  ///ClouDiary key
  static const String apiKey = '211428272922525';
  static const String apiSecret = 'EwQ-Z_GiuvDyn8MfskXIH3PTUWI';
  static const String cloudName = 'dl95asm0f';
  /// Api body keyword
  static const String grantType = 'grant_type';
  static const String username = 'username';
  static const String password = 'password';

  static const String email = 'email';
  static const String name = 'name';
  static const String type = 'type';
  static const String phone = 'phone';
  static const String photo = 'photo';
  static const String gender = 'gender';
  static const String about = 'about';
  static const String status = 'status';
  static const String languageCode = 'language_code';
  static const String drillierId = 'drillier_id';

  ///DateFormat
  static const String normalDate='dd/MM/yyyy';
  static const String versionDate = 'yy.MM.dd';
  static const String fullDate = 'yyyy-MM-dd HH:mm:ss';

  ///Local key
  static const String uuid = 'uuid';
  static const String timeLogin = 'time_login';

  ///DB key
  static const String accounts = 'accounts';
  static const String profiles = 'profiles';

  /// Transaction
  static List<String> transactionTypes = [S.current.income, S.current.expense];
  static List<String> transactionCategories = [S.current.food, S.current.salary, S.current.shopping,S.current.entertainment ];
  static List<String> transactionPayments = [S.current.cash, S.current.bankCard,S.current.momo];
}
