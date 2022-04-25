import 'package:get/get.dart';

import '../../Calendar/Model/day_calendar_model.dart';

class HistoryController extends GetxController{


  List<DayCalendarModel> dayList = [];

  @override
  void onInit() {
    dayList = Get.arguments['list'];
    super.onInit();
  }
}