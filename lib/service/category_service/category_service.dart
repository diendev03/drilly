import 'package:drilly/service/api_client.dart';
import 'package:dio/dio.dart';

class CategoryService {
  final api = ApiClient();
  String categoryTable = '/categories';

  Future<Response?> getAllCategories({required String uuid}) async {
    try {
      Response response = await api.get(categoryTable, headers: {
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

}