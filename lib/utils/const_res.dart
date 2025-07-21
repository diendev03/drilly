import 'package:drilly/generated/l10n.dart';

class ConstRes {
  static const String baseUrl = 'https://drilly.io.vn/api/v1';

  ///ClouDiary key
  static const String apiKey = '211428272922525';
  static const String apiSecret = 'EwQ-Z_GiuvDyn8MfskXIH3PTUWI';
  static const String cloudName = 'dl95asm0f';

  static const String languageCode = 'language_code';

  ///Local key
  static const String uuid = 'uuid';
  static const String token = 'token';
  static const String drillierId = 'drillier_id';
  static const String timeLogin = 'time_login';

  ///routes
  //User
  static const String loginEP = '/user/login';
  static const String registerEP = '/user/create';
  static const String forgotPasswordEP = '/user/forgot-password';
  static const String changePasswordEP = '/user/change-password';
  static const String profileEP = '/user/profile';
  static const String updateProfileEP = '/user/profile/update';

  /// Transaction
  static List<String> transactionTypes = [S.current.income, S.current.expense];
  static List<String> transactionCategories = [S.current.food, S.current.salary, S.current.shopping,S.current.entertainment ];
  static List<String> transactionPayments = [S.current.cash, S.current.bankCard,S.current.momo];
}
