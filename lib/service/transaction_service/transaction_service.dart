import 'package:dio/dio.dart';
import 'package:drilly/service/api_client.dart';
import 'package:drilly/utils/const_res.dart';

class TransactionService {
  String accountTable = ConstRes.accounts;
  String profileTable = ConstRes.profiles;
  Dio dio = Dio();
  final api = ApiClient();

  Future<Response?> getAllTransactions({required String uuid}) async {
    try {
      print('Lấy danh sách giao dịch');
      Response response = await api.get('/transactions', params: {
        'uuid': uuid,
      });
      if (response.data["status"] == true) {
        print('Lấy danh sách giao dịch thành công: ${response.data}');
        return response;
      } else {
        print('Lấy danh sách giao dịch thất bại: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Lỗi khi lấy danh sách giao dịch: ${e.toString()}');
      return null;
    }
  }
}
