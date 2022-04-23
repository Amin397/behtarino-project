import 'package:get/get.dart';
import 'package:my_note/Consts/name_routs.dart';
import 'package:my_note/Globals/blocs.dart';
import 'package:my_note/Utils/storage.dart';

class SplashController extends GetxController {



  @override
  void onInit() {


    // Future.delayed(const Duration(seconds: 2), () {
    //   Get.offAndToNamed(NameRouts.auth);
    // });

    super.onInit();
    checkUser();
  }

  void checkUser() async {

    StorageUtils.getToken().then((value) async {

      print('=============');
      print(value);

      print('=============');
      if (value is String) {

        Globals.user.setKey(
          await StorageUtils.getKey(),
          await StorageUtils.getMobile(),
        );
        Globals.user.setToken(
          value,
        );
        Get.offAndToNamed(NameRouts.calendar);
      } else {
        Get.offAndToNamed(NameRouts.auth);
      }
    });
  }
}
