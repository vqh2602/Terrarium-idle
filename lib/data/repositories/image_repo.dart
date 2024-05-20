import 'dart:convert';
import 'dart:io';

import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:dio/dio.dart';

// // String baseUrl =  'http://localhost:8080'; // ios
// // String baseUrl =  'http://127.0.0.1:8080'; // ios
// String baseUrl = 'http://10.0.2.2:8080'; // android
// String baserUrlMedia = '$baseUrl/storage/';
// //baseUrl:'http://127.0.0.1:8080',
//discord

class RepoImage {
  final dioRepo = Dio(BaseOptions(
    baseUrl: 'https://freeimage.host/api/1/upload',
    //baseUrl:'http://127.0.0.1:8080',
    // baseUrl: 'http://192.168.0.196:8080',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    receiveDataWhenStatusError: true,
    // 5s
    headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
    contentType: Headers.jsonContentType,
    // Transform the response data to a String encoded with UTF8.
    // The default value is [ResponseType.JSON].
    responseType: ResponseType.plain,
    validateStatus: (statusCode) {
      if (statusCode == null) {
        return false;
      }
      if (statusCode == 422 || statusCode == 400) {
        // your http status code
        return true;
      }
      if (statusCode >= 200 && statusCode < 400) {
        return true;
      } else {
        buildToast(
            status: TypeToast.toastError,
            title: 'Không thể kết nối đến máy chủ',
            message:
                'Vui lòng kiểm tra lại kết nối mạng hoặc liên hệ hỗ trợ báo cáo sự cố');
        return false;
      }
    },
  ));

  Future<String?> uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "key": "6d207e02198a847aa98d0a2a901485a5",
      "source": await MultipartFile.fromFile(file.path, filename: fileName),
      "format": "json"
    });
    var response = await dioRepo.post('', data: formData);
    Map<String, dynamic>? result = jsonDecode(response.data.toString());
    return result?['image']['url'];
  }

 }
