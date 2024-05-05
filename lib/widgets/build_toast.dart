import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

enum TypeToast {
  getError,
  getSuccess,
  getDefault,
  toastDefault,
  toastError,
  toastSuccess
}

void buildToast(
    {String? title,
    required String message,
    required TypeToast status,
    Duration? duration,
    Color? backgroundColor,
    Color? textColor}) {
  switch (status) {
    case TypeToast.getSuccess:
      {
        Get.snackbar(title ?? 'Thành công'.tr, message,
            duration: duration ?? const Duration(seconds: 1),
            backgroundColor: backgroundColor ?? Colors.green,
            colorText: textColor ?? Colors.white);
        break;
      }
    case TypeToast.getError:
      {
        Get.snackbar(title ?? 'Có lỗi xảy ra'.tr, message,
            duration: duration ?? const Duration(seconds: 1),
            backgroundColor: backgroundColor ?? Colors.red,
            colorText: textColor ?? Colors.white);
        break;
      }
    case TypeToast.getDefault:
      {
        Get.snackbar(title ?? 'Thông báo'.tr, message,
            backgroundColor: backgroundColor,
            colorText: textColor,
            duration: duration ?? const Duration(seconds: 1));
        break;
      }
    case TypeToast.toastDefault:
      {
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: backgroundColor,
            textColor: textColor,
            fontSize: 16,
            gravity: ToastGravity.BOTTOM);
        break;
      }
    case TypeToast.toastSuccess:
      {
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: backgroundColor ?? Colors.green,
            textColor: textColor ?? Colors.white,
            fontSize: 16,
            gravity: ToastGravity.BOTTOM);
        break;
      }
    case TypeToast.toastError:
      {
        Fluttertoast.showToast(
            msg: message,
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: backgroundColor ?? Colors.red,
            textColor: textColor ?? Colors.white,
            fontSize: 16,
            gravity: ToastGravity.BOTTOM);
        break;
      }
    default:
      {
        Get.snackbar('Thông báo'.tr, message,
            duration: const Duration(seconds: 1));
      }
  }
}
