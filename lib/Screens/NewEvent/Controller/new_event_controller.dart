import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_note/Globals/blocs.dart';

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

    eventMinutePageController =
        PageController(viewportFraction: 1 / 3, initialPage: 1);

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

    for (int i = 1; i <= 24; i++) {
      hourList.add(
        SelectTimeModel(
          number: i.toString(),
          isSelected: false.obs,
        ),
      );
    }

    hourList[Globals.time.now.hour - 1].isSelected(true);

    hourPageController = PageController(
      viewportFraction: 1 / 3,
      initialPage: Globals.time.now.hour - 1,
    );

    for (int i = 1; i <= 60; i++) {
      eventMinuteList.add(
        SelectTimeModel(
          number: i.toString(),
          isSelected: false.obs,
        ),
      );
    }

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

    if (index != list.length -1) {
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
}
