import 'package:get/get.dart';

import '../Screens/Auth/View/login_screen.dart';
import '../Screens/Splash/View/splash_screen.dart';

class NameRouts{

  static const String splash = '/splash';
  static const String auth = '/auth';

}


class MyPageRout{


  static List<GetPage> pages = [
    GetPage(name: NameRouts.splash, page:()=> SplashScreen()),
    GetPage(name: NameRouts.auth, page:()=> AuthScreen()),
  ];
}