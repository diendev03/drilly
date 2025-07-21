import 'package:dio/dio.dart';
import 'package:drilly/model/transaction.dart';
import 'package:drilly/service/api_client.dart';
import 'package:drilly/service/base_response.dart';

class TransactionService {
  final api = ApiClient();
  Future<BaseResponse<Map<String, dynamic>>> getSummary(
      {required String from, required String to}) async {
    try {
      final response = await api.get('/transaction/summary', params: {
        "start_date": from,
        "end_date": to,
      });
      return BaseResponse<Map<String, dynamic>>.fromJsonGeneric(response.data);
    } catch (e) {
      return BaseResponse<Map<String, dynamic>>(
        status: false,
        message: "Get summary failed",
        data: {},
      );
    }
  }

  Future<BaseResponse<List<Transaction>>> getTransactions({
    required String from,
    required String to,
    String? type,
    int? category,
  }) async {
    try {
      final response = await api.get('/transaction', params: {
        "start_date": from,
        "end_date": to,
        if (type != null) "type": type,
        if (category != null) "category": category,
      });
      return BaseResponse<List<Transaction>>.fromJsonList(
        response.data,
        (list) => list.map((e) => Transaction.fromJson(e)).toList(),
      );
    } catch (e) {
      return BaseResponse<List<Transaction>>(
        status: false,
        message: "Get transactions failed",
        data: [],
      );
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

      Response response = await api.post(
        '/transactions',
        data: body,
        headers: headers,
      );

      if (response.data != null && response.data["status"] == true) {
        return response;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
