import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_note/Consts/name_routs.dart';
import 'package:my_note/Globals/blocs.dart';
import 'package:my_note/Utils/project_requests.dart';
import 'package:my_note/Utils/storage.dart';
import 'package:my_note/Utils/view_utils.dart';

class AuthController extends GetxController {
  TextEditingController phoneController = TextEditingController();

  void sendMobile() async {
    EasyLoading.show();
    ProjectRequests.makePostRequest(
      controller: 'auth',
      method: 'login',
      body: {
        'username': phoneController.text.toString(),
      },
    ).then((value) async {
      EasyLoading.dismiss();
      if (value.statusCode == 200) {
        Map<String, dynamic> myMap = jsonDecode(value.body);
        StorageUtils.setKey(
          key: myMap['key'],
        );
        print('key set');

        StorageUtils.setMobile(
          mobile: phoneController.text,
        );
        print('mobile set');
        Globals.user.setKey(
          myMap['key'],
          phoneController.text,
        );
        print('bloc inited');

        Get.toNamed(
          NameRouts.checkOtp,
        );
      } else {
        ViewUtils.errorSnackBar(
          message: 'خطایی رخ داد',
        );
      }
    });
  }
}
