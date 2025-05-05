// cloudinary_service.dart

// ignore_for_file: avoid_print

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:drilly/utils/const_res.dart';
import 'package:image_picker/image_picker.dart';

class CloudinaryService {

  // Khởi tạo Dio
  Dio dio = Dio();

  // Hàm tải ảnh từ thư viện
  Future<String?> uploadImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      return await uploadImage(image.path);
    } else {
      return null;
    }
  }

  // Hàm tải ảnh lên Cloudinary bằng Dio
  Future<String?> uploadImage(String imagePath) async {
    try {
      final File imageFile = File(imagePath);

      // Tạo request tải ảnh lên Cloudinary
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path),
      });

      final response = await dio.post(
        'https://api.cloudinary.com/v1_1/${ConstRes.cloudName}/image/upload',
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['secure_url'];
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}
