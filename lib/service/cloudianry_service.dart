import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drilly/utils/const_res.dart';

class CloudinaryService {
  final Dio dio = Dio();

  // Hàm upload ảnh lên Cloudinary
  Future<String?> uploadImage(XFile imageXFile) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      File imageFile = File(imageXFile.path);

      // URL của Cloudinary để upload ảnh
      String uploadUrl = 'https://api.cloudinary.com/v1_1/${ConstRes.cloudName}/image/upload';

      // Tạo FormData để gửi yêu cầu upload
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path, filename: fileName),
        'upload_preset': 'drilly', // Sử dụng upload preset "drilly" mà bạn đã tạo
        'api_key': ConstRes.apiKey,    // Kiểm tra api_key có chính xác không
      });

      // Gửi yêu cầu POST lên Cloudinary
      final response = await dio.post(uploadUrl, data: formData);

      if (response.statusCode == 200) {
        return response.data['secure_url'];
      } else {
        throw Exception('Lỗi khi upload ảnh lên Cloudinary: ${response.data}');
      }
    } catch (e) {
      return null;
    }
  }
}
