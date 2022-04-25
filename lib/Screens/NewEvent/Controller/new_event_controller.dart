import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_note/GPRS/calendar.pb.dart';
import 'package:my_note/GPRS/calendar.pbgrpc.dart';
import 'package:my_note/Globals/blocs.dart';
import 'package:my_note/Utils/project_requests.dart';
import 'package:my_note/Utils/storage.dart';

import '../../../DataBase/event_database.dart';
import '../../../GPRS/calendar.pb.dart';
import '../../../GPRS/calendar.pb.dart';
import '../../../GPRS/calendar.pbgrpc.dart';
import '../../../Utils/view_utils.dart';
import '../../Calendar/Model/day_calendar_model.dart';
import '../Model/select_time_model.dart';

class NewEventController extends GetxController {
  late DayCalendarModel dayCalendar;

  TextEditingController eventTitle = TextEditingController();

  List<SelectTimeModel> minuteList = [];
  List<SelectTimeModel> hourList = [];
  List<SelectTimeModel> eventMinuteList = [];

  PageController minutePageController = PageController();
  PageController hourPageController = PageController();
  PageController eventMinutePageController = PageController();

  @override
  void onInit() {
    dayCalendar = Get.arguments['item'];

    initData();

    super.onInit();
  }

  void initData() async {
    for (int i = 1; i <= 60; i++) {
      minuteList.add(
        SelectTimeModel(
          number: i.toString(),
          isSelected: false.obs,
        ),
      );
    }

    minuteList[Globals.time.now.minute - 1].isSelected(true);

    minutePageController = PageController(
      viewportFraction: 1 / 3,
      initialPage: Globals.time.now.minute - 1,
    );

    for (int i = 0; i <= 24; i++) {
      hourList.add(
        SelectTimeModel(
          number: i.toString(),
          isSelected: false.obs,
        ),
      );
    }

    hourList[Globals.time.now.hour].isSelected(true);

    hourPageController = PageController(
      viewportFraction: 1 / 3,
      initialPage: (Globals.time.now.hour == 0) ? 0 : Globals.time.now.hour - 1,
    );

    for (int i = 1; i <= 60; i++) {
      eventMinuteList.add(
        SelectTimeModel(
          number: i.toString(),
          isSelected: false.obs,
        ),
      );
    }

    eventMinuteList[0].isSelected(true);

    eventMinutePageController =
        PageController(viewportFraction: 1 / 3, initialPage: 0);

    update();
  }

  void previous({
    required List<SelectTimeModel> list,
    required PageController pageController,
  }) {
    int index = 0;
    list.map((e) {
      if (e.isSelected.isTrue) {
        index = list.indexOf(e);
      }
    }).toList();

    if (index != 0) {
      list.forEach((element) {
        element.isSelected(false);
      });

      list[index - 1].isSelected(true);

      pageController.previousPage(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeIn,
      );
    }
  }

  void next(
      {required List<SelectTimeModel> list,
      required PageController pageController}) {
    int index = 0;
    list.map((e) {
      if (e.isSelected.isTrue) {
        index = list.indexOf(e);
      }
    }).toList();

    if (index != list.length - 1) {
      list.forEach((element) {
        element.isSelected(false);
      });

      list[index + 1].isSelected(true);

      pageController.nextPage(
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeIn,
      );
    }
  }

  void submitNewEvent() async {
    String startTime = DateTime(
            Globals.time.now.year,
            Globals.time.now.month,
            Globals.time.now.day,
            int.parse(hourList
                .singleWhere((element) => element.isSelected.isTrue)
                .number),
            int.parse(minuteList
                .singleWhere((element) => element.isSelected.isTrue)
                .number))
        .toUtc()
        .toIso8601String();

    int endHour = int.parse(
        hourList.singleWhere((element) => element.isSelected.isTrue).number);

    int endMinute = int.parse(minuteList
            .singleWhere((element) => element.isSelected.isTrue)
            .number) +
        int.parse(eventMinuteList
            .singleWhere((element) => element.isSelected.isTrue)
            .number);

    if (endMinute >= 60) {
      endHour++;
      endMinute = endMinute - 60;
    }

    String endTime = DateTime(Globals.time.now.year, Globals.time.now.month,
            Globals.time.now.day, endHour, endMinute)
        .toUtc()
        .toIso8601String();

    ProjectRequests.makePostRequest(
        controller: 'calendar',
        method: 'create',
        withToken: true,
        body: {
          'name': eventTitle.text,
          'start': startTime,
          'end': endTime,
        }).then((value) async {
      print(value.body);

      if(value.statusCode == 200){
        DayCalendarModel model = DayCalendarModel(
          time: hourList
              .singleWhere((element) => element.isSelected.isTrue)
              .number +':'+
              minuteList
                  .singleWhere((element) => element.isSelected.isTrue)
                  .number,
          alarms: EventModel.fromJson(
            jsonDecode(value.body),
          ),
        );
        StorageUtils.setEvent(model: model);

        Get.back(result: true);

      }else{
        ViewUtils.errorSnackBar(message: 'خطایی رخ داد',);
      }
    });
  }
}
