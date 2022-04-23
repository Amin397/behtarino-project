import 'package:get/get.dart';

import '../Screens/Auth/View/auth_screen.dart';
import '../Screens/Calendar/View/calendar_screen.dart';
import '../Screens/CheckOtp/View/check_otp_screen.dart';
import '../Screens/Splash/View/splash_screen.dart';

class NameRouts{

  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String checkOtp = '/checkOtp';
  static const String calendar = '/calendar';

}


class MyPageRout{


  static List<GetPage> pages = [
    GetPage(name: NameRouts.splash, page:()=> SplashScreen()),
    GetPage(name: NameRouts.auth, page:()=> AuthScreen()),
    GetPage(name: NameRouts.checkOtp, page:()=> CheckOtpScreen()),
    GetPage(name: NameRouts.calendar, page:()=> CalendarScreen()),
  ];
}

