import 'package:drilly/model/category.dart';
import 'package:drilly/service/api_client.dart';
import 'package:dio/dio.dart';
import 'package:drilly/service/base_response.dart';

class CategoryService {
  final api = ApiClient();

  Future<BaseResponse<List<Category>>> getAllCategories() async {
    try {
      Response response = await api.get("/transaction-category");
      return BaseResponse<List<Category>>.fromJsonList(
        response.data,
        (list) => list.map((e) => Category.fromJson(e)).toList(),
      );
    } catch (e) {
      return BaseResponse<List<Category>>(
        status: false,
        message: "Get list category failed",
        data: [],
      );
    }
  }
}
