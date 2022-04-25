import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note/Consts/name_routs.dart';
import 'package:my_note/Globals/blocs.dart';
import 'package:my_note/Utils/storage.dart';
import '../Model/day_calendar_model.dart';
import '../View/Widgets/show_add_alarm_alert.dart';

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

  RxBool eventSelect = false.obs;

  @override
  void onInit() {
    Globals.time.updateTime();
    scrollController = ScrollController(
      initialScrollOffset: 0.0,
    );
    goToThisTime();
    amin();
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

  void showAlertForAddAlarm({
    required DayCalendarModel dayCalendar,
  }) async {
    var result = await showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          contentPadding: EdgeInsets.zero,
          content: ShowAddAlarmAlert(),
        );
      },
    );

    switch (result['id']) {
      case 0:
        {
          var result = await Get.toNamed(NameRouts.newEvent, arguments: {
            'item': dayCalendar,
          });

          if (result is bool) {
            amin();
          }
          break;
        }
      case 1:
        {

          Get.toNamed(NameRouts.history , arguments: {
            'list': dayList
          });
          break;
        }
      default:
        {}
    }
  }

  void amin() async {
    List<DayCalendarModel> eventList = [];

    eventList = await StorageUtils.getEvent();

    if (eventList.isNotEmpty) {
      for (var o in eventList) {
        print(o.time);
        dayList
            .singleWhere((element) =>
                element.time!.split(':').first == o.time!.split(':').first)
            .alarms = o.alarms;
      }
    }

    update();
  }

  void deleteEvent({required DayCalendarModel item}) async {
    List<DayCalendarModel> eventList = [];

    eventList = await StorageUtils.getEvent();

    dayList[dayList.indexOf(item)].alarms = null;
    eventList.removeWhere((element) =>
        element.time!.split(':').first == item.time!.split(':').first);

    await StorageUtils.cleanEvent();
    if (eventList.isNotEmpty) {
      eventList.forEach((element) {
        StorageUtils.setEvent(model: element);
      });
    }
    eventSelect(false);
    update();
  }
}
