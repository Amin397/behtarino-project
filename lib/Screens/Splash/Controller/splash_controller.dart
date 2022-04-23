import 'package:get/get.dart';
import 'package:my_note/Consts/name_routs.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAndToNamed(NameRouts.auth);
    });
    super.onInit();
  }
}
