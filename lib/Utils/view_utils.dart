import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewUtils{

  static void onChange({String? string,
    TextEditingController? textEditingController,
    Function? func}) {
    func!();
    List<String> list = string!.split('');
    if (list.isNotEmpty) {
      switch (list.length) {
        case 1:
          if (list[0] == '0') {
            textEditingController!.text = '0';
          } else {
            textEditingController!.clear();
          }
          break;
        case 2:
          if (list[1] == '9') {
            textEditingController!.text = '09';
          } else {
            textEditingController!.text = '0';
          }

          break;
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
          list.removeAt(0);
          list.removeAt(0);
          textEditingController!.text = '09' + list.join('');
          break;
      }
      Future.delayed(
        Duration.zero,
            () =>
        textEditingController!.selection = TextSelection.fromPosition(
          TextPosition(
            offset: textEditingController.text.length,
          ),
        ),
      );
    }
  }




  static void errorSnackBar({String? message}) {
    Get.snackbar(
      'خطا',
      message!,
      isDismissible: true,
      barBlur: 10.0,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      icon: const Icon(
        Icons.clear,
        color: Colors.white,
        size: 30.0,
      ),
      backgroundColor: Colors.red.withOpacity(.3),
      boxShadows: shadow(),
      margin: EdgeInsets.symmetric(
        vertical: Get.height * .03,
        horizontal: Get.width * .02,
      ),
    );
  }

  static void successSnackBar({String? message}) {
    Get.snackbar(
      'موفقیت',
      message!,
      isDismissible: true,
      barBlur: 10.0,
      colorText: Colors.white,
      icon: const Icon(
        Icons.check_circle,
        color: Colors.white,
        size: 30.0,
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(.3),
      boxShadows: shadow(),
      margin: EdgeInsets.symmetric(
        vertical: Get.height * .03,
        horizontal: Get.width * .02,
      ),
      shouldIconPulse: true,
      duration: const Duration(seconds: 2),
    );
  }



  static List<BoxShadow> shadow() {
    return [
      BoxShadow(
        color: Colors.grey.withOpacity(.3),
        blurRadius: 5.0,
        spreadRadius: 3.0,
        offset: const Offset(
          0.0,
          3.0,
        ),
      ),
    ];
  }



}