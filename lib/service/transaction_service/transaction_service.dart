import 'package:dio/dio.dart';
import 'package:drilly/service/api_client.dart';

class TransactionService {
  final api = ApiClient();

  Future<Response?> getAllTransactions({required String uuid}) async {
    try {
      Response response = await api.get('/transactions', params: {
        'uuid': uuid,
      });
      if (response.data["status"] == true) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Response?> createTransaction({
    required String uuid,
    required String categoryId,
    required String paymentId,
    required String name,
    required double amount,
    required String type,
    String note = '',
    required String transactionDate,
    bool isRecurring = false,
    String? repeatCycle,
    String location = '',
  }) async {
    try {
      final headers = {
        'uuid': uuid,
        'Content-Type': 'application/json',
      };

      final body = {
        'category_id': categoryId,
        'payment_id': paymentId,
        'name': name,
        'amount': amount,
        'type': type,
        'note': note,
        'transaction_date': transactionDate,
        'is_recurring': isRecurring,
        'repeat_cycle': repeatCycle ?? '',
        'location': location,
      };

      print("Request body: $body");
      print("Request headers: $headers");

      Response response = await api.post(
        '/transactions',
        data: body,
        headers:  headers,
      );

      if (response.data != null && response.data["status"] == true) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      print("Error when creating transaction: $e");
      return null;
    }
  }
}
