import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note/Consts/colors.dart';
import 'package:my_note/Consts/edge_insets.dart';
import 'package:my_note/Screens/Calendar/Controller/calendar_controller.dart';
import 'package:my_note/Utils/view_utils.dart';

import '../../../../Globals/blocs.dart';
import '../../Model/day_calendar_model.dart';

class ClockPartItem extends StatelessWidget {
  ClockPartItem({Key? key, required this.item, required this.controller})
      : super(key: key);

  final DayCalendarModel item;
  final CalendarController controller;

  String amOrPm = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        controller.showAlertForAddAlarm(dayCalendar: item);
      },
      child: Container(
        height: Get.height * .3,
        width: Get.width,
        margin: EdgeInsets.only(
          bottom: 12.0,
          right: Get.width * .02,
        ),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.5,
            ),
          ),
        ),
        child: Column(
          children: [
            _buildTimePart(),
            _buildMinuetsPart(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePart() {
    if (int.parse(item.time!.substring(0, 2)) > 12) {
      amOrPm = 'ب.ظ';
    } else {
      amOrPm = 'ق.ظ';
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Get.width * .02,
      ),
      height: Get.height * .05,
      width: Get.width,
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "${item.time!} \n $amOrPm",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildMinuetsPart() {
    bool hasEvent = false;

    hasEvent = (item.alarms is EventModel);

    return Expanded(
      child: GetBuilder(
        init: controller,
        builder: (ctx) => Stack(
          children: [
            SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: ListView.builder(
                itemCount: 59,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return StreamBuilder(
                    stream: Globals.time.getStream,
                    builder: (c, b) {
                      return _buildMinuteItem(
                        index: index,
                      );
                    },
                  );
                },
              ),
            ),
            (hasEvent)
                ? Align(
                    alignment: Alignment.topCenter,
                    child: _buildEvent(),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildMinuteItem({required int index}) {
    double height = 1.0;

    if (Globals.time.now.hour == int.parse(item.time!.split(':').first)) {
      if (Globals.time.now.minute == index) {
        height = Get.height * .035;
      }
    }

    return Container(
      width: 100,
      height: height,
      margin: EdgeInsets.symmetric(
        vertical: Get.height * .001,
      ),
      child: Row(
        children: [
          Container(
            height: double.maxFinite,
            width: Get.width * .15,
            decoration: BoxDecoration(
              borderRadius: radiusAll12,
              border: Border.all(
                color: (height > 1) ? Colors.blueAccent : Colors.white,
                width: 1.5,
              ),
            ),
            child: (height > 1)
                ? Center(
                    child: Text(
                        '${Globals.time.now.hour}:${Globals.time.now.minute}'),
                  )
                : const SizedBox(),
          ),
          Expanded(
            child: Container(
              height: double.maxFinite,
              width: double.maxFinite,
              color: (index == 15 || index == 30 || index == 45 || index == 0)
                  ? Colors.grey.withOpacity(.5)
                  : Colors.white,
              child: Stack(
                children: [
                  (height > 1)
                      ? Center(
                          child: Container(
                            width: double.maxFinite,
                            height: 1,
                            color: Colors.blueAccent,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvent() {
    return GestureDetector(
      onLongPress: () {
        controller.eventSelect(true);
      },
      child: Obx(()=>AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: Get.width,
        height: Get.height * .08,
        decoration: BoxDecoration(
          color: (controller.eventSelect.isTrue)
              ? Colors.red.shade800
              : eventColor,
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(12.0),
          ),
          boxShadow: ViewUtils.shadow(),
        ),
        child: (controller.eventSelect.isTrue)
            ? Row(
          children: [
            IconButton(
              onPressed: () {
                controller.eventSelect(false);
              },
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                controller.deleteEvent(item:item);
              },
              icon: const Icon(
                Icons.delete_forever,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: Center(
                          child: AutoSizeText(
                            item.alarms!.name!,
                            maxLines: 1,
                            maxFontSize: 18.0,
                            minFontSize: 12.0,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: Center(
                          child: AutoSizeText(
                            '${item.alarms!.start!.hour}:${item.alarms!.start!.minute} تا ${item.alarms!.end!.hour}:${item.alarms!.end!.minute}',
                            maxLines: 1,
                            maxFontSize: 18.0,
                            minFontSize: 12.0,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )

          ],
        )
            : Column(
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Center(
                  child: AutoSizeText(
                    item.alarms!.name!,
                    maxLines: 1,
                    maxFontSize: 18.0,
                    minFontSize: 12.0,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Center(
                  child: AutoSizeText(
                    '${item.alarms!.start!.hour}:${item.alarms!.start!.minute} تا ${item.alarms!.end!.hour}:${item.alarms!.end!.minute}',
                    maxLines: 1,
                    maxFontSize: 18.0,
                    minFontSize: 12.0,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
