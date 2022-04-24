import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note/Globals/blocs.dart';

import '../Model/day_calendar_model.dart';

class CalendarController extends GetxController {
  ScrollController? scrollController;

  List<DayCalendarModel> dayList = [
    DayCalendarModel(time: '00:00'),
    DayCalendarModel(time: '01:00'),
    DayCalendarModel(time: '02:00'),
    DayCalendarModel(time: '03:00'),
    DayCalendarModel(time: '04:00'),
    DayCalendarModel(time: '05:00'),
    DayCalendarModel(time: '06:00'),
    DayCalendarModel(time: '07:00'),
    DayCalendarModel(time: '08:00'),
    DayCalendarModel(time: '09:00'),
    DayCalendarModel(time: '10:00'),
    DayCalendarModel(time: '11:00'),
    DayCalendarModel(time: '12:00'),
    DayCalendarModel(time: '13:00'),
    DayCalendarModel(time: '14:00'),
    DayCalendarModel(time: '15:00'),
    DayCalendarModel(time: '16:00'),
    DayCalendarModel(time: '17:00'),
    DayCalendarModel(time: '18:00'),
    DayCalendarModel(time: '19:00'),
    DayCalendarModel(time: '20:00'),
    DayCalendarModel(time: '21:00'),
    DayCalendarModel(time: '22:00'),
    DayCalendarModel(time: '23:00'),
  ];



  @override
  void onInit() {
    Globals.time.updateTime();
    scrollController = ScrollController(
      initialScrollOffset: 0.0,
    );
    goToThisTime();
    super.onInit();
  }

  void goToThisTime() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      scrollController!.animateTo(
        (Get.height * .315 * Globals.time.now.hour),
        duration: const Duration(seconds: 1),
        curve: Curves.easeIn,
      );
    });
    update();
  }
}
