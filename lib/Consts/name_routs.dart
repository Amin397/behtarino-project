import 'package:get/get.dart';

import '../Screens/Auth/View/auth_screen.dart';
import '../Screens/Calendar/View/calendar_screen.dart';
import '../Screens/CheckOtp/View/check_otp_screen.dart';
import '../Screens/History/View/history_screen.dart';
import '../Screens/NewEvent/VIew/new_event_screen.dart';
import '../Screens/Splash/View/splash_screen.dart';

class NameRouts{

  static const String splash = '/splash';
  static const String auth = '/auth';
  static const String checkOtp = '/checkOtp';
  static const String calendar = '/calendar';
  static const String history = '/history';
  static const String newEvent = '/newEvent';

}


class MyPageRout{


  static List<GetPage> pages = [
    GetPage(name: NameRouts.splash, page:()=> SplashScreen()),
    GetPage(name: NameRouts.auth, page:()=> AuthScreen()),
    GetPage(name: NameRouts.checkOtp, page:()=> CheckOtpScreen()),
    GetPage(name: NameRouts.calendar, page:()=> CalendarScreen()),
    GetPage(name: NameRouts.newEvent, page:()=> NewEventScreen()),
    GetPage(name: NameRouts.history, page:()=> HistoryScreen()),
  ];
}

