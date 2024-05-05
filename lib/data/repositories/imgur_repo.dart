import 'dart:convert';
import 'dart:io';

import 'package:terrarium_idle/config/config.dart';
import 'package:terrarium_idle/data/storage/storage.dart';
import 'package:terrarium_idle/modules/splash/splash_screen.dart';
import 'package:terrarium_idle/widgets/build_toast.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

var dioRepo = dio.Dio(dio.BaseOptions(
  baseUrl: Env.config.imgurApi,
  connectTimeout: const Duration(seconds: 60),
  receiveTimeout: const Duration(seconds: 60),
  receiveDataWhenStatusError: true,
  // 5s
  headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
  contentType: dio.Headers.jsonContentType,
  // Transform the response data to a String encoded with UTF8.
  // The default value is [ResponseType.JSON].
  responseType: dio.ResponseType.plain,
  validateStatus: (statusCode) {
    if (statusCode == null) {
      return false;
    }
    if (statusCode == 401) {
      // your http status code
      Get.toNamed(SplashScreen.routeName, arguments: {
        "refreshToken": true,
      });
      return true;
    }
    if (statusCode == 422 || statusCode == 400) {
      // your http status code
      return true;
    }
    if (statusCode >= 200 && statusCode < 300) {
      return true;
    } else {
      // buildToast(
      //     type: TypeToast.failure,
      //     title: 'Không thể kết nối đến máy chủ',
      //     message:
      //         'Vui lòng kiểm tra lại kết nối mạng hoặc liên hệ hỗ trợ báo cáo sự cố');
      return false;
    }
  },
));

class ImgurRepo {
  GetStorage box = GetStorage();

  var dioRepo = dio.Dio(dio.BaseOptions(
    baseUrl: Env.config.imgurApi,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    receiveDataWhenStatusError: true,
    // 5s
    headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
    contentType: dio.Headers.jsonContentType,
    // Transform the response data to a String encoded with UTF8.
    // The default value is [ResponseType.JSON].
    responseType: dio.ResponseType.plain,
    validateStatus: (statusCode) {
      if (statusCode == null) {
        return false;
      }
      if (statusCode == 401) {
        // your http status code

        Get.toNamed(SplashScreen.routeName, arguments: {
          "refreshToken": true,
        });
        buildToast(
            status: TypeToast.toastError,
            title: 'Đang làm mới token',
            message: 'Đang làm mới token');
        return true;
      }
      if (statusCode == 429) {
        buildToast(
            status: TypeToast.toastError,
            title: 'Máy chủ lưu trữ đang quá tải',
            message: 'Máy chủ lưu trữ đang quá tải');
        return true;
      }
      if (statusCode == 422 || statusCode == 400) {
        // your http status code
        return true;
      }
      if (statusCode >= 200 && statusCode < 300) {
        return true;
      } else {
        // buildToast(
        //     type: TypeToast.failure,
        //     title: 'Không thể kết nối đến máy chủ',
        //     message:
        //         'Vui lòng kiểm tra lại kết nối mạng hoặc liên hệ hỗ trợ báo cáo sự cố');
        return false;
      }
    },
  ));

  // lấy token api imgur
  Future<Map<String, dynamic>?> resetTokenImgur() async {
    var res = await dioRepo.post('/oauth2/token', data: {
      "refresh_token": box.read(Storages.dataRefreshTokenImgur) ??
          'f6a7a89e42f42aea041a977986085465d7180b7f',
      "client_id": "67a4477d0c4da9e",
      "client_secret": "b8de4afdd932822b3b31d591f10cc07cc27afc2d",
      "grant_type": "refresh_token"
    });
    //log('gift: $');
    Map<String, dynamic>? result = jsonDecode(res.toString());
    await box.write(Storages.dataTokenImgur, result?['access_token']);
    await box.write(Storages.dataRefreshTokenImgur, result?['refresh_token']);
    //print('data new json ${result}');
    return result;
  }

  // lấy token api imgur
  Future<Map<String, dynamic>?> upLoadImageImgur(File file) async {
    String fileName = file.path.split('/').last;

    String? token = box.read(Storages.dataTokenImgur);
    if (token == null) {
      await resetTokenImgur();
    }
    dio.FormData data = dio.FormData.fromMap({
      "image": await dio.MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    var res = await dioRepo.post('/3/upload',
        data: data,
        options: dio.Options(headers: {
          "Content-Type": "application/json",
          "Authorization": token,
        }));
    //log('gift: $');
    Map<String, dynamic>? result = jsonDecode(res.data.toString());
    if (res.statusCode == 200) {
      return result?["data"];
    } else {
      buildToast(
          title: 'Có lỗi xảy ra',
          message: '${result?['errors'][0]["status"]}',
          status: TypeToast.getError);
      return null;
    }
    //print('data new json ${result}');
  }
}
