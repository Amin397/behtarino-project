import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:my_note/Consts/name_routs.dart';
import 'package:my_note/Globals/blocs.dart';
import 'package:my_note/Utils/project_requests.dart';
import 'package:my_note/Utils/storage.dart';

class OtpController extends GetxController {
  TextEditingController otpController = TextEditingController();

  RxBool invalidCode = false.obs;

  void checkOtp() async {
    EasyLoading.show();
    ProjectRequests.makePostRequest(
        controller: 'auth',
        method: 'verify',
        body: {
          'username': Globals.user.user.mobile,
          'key': Globals.user.user.key,
          'otp': otpController.text
        }).then((value) async{
      EasyLoading.dismiss();
      if (value.statusCode == 200) {
        Map<String, dynamic> myMap = jsonDecode(value.body);
        // print(myMap);
        Globals.user.setToken(myMap['token']);
        await StorageUtils.setToken(token: myMap['token']);

        Get.offAndToNamed(NameRouts.calendar);

      }else{
        invalidCode(true);
        otpController.clear();
      }
    });
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }
}
