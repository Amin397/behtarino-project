import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note/Consts/edge_insets.dart';
import 'package:my_note/Screens/Calendar/Model/day_calendar_model.dart';
import 'package:my_note/Utils/widget_utils.dart';

import '../../../Consts/colors.dart';
import '../../../Utils/view_utils.dart';
import '../../Calendar/Controller/calendar_controller.dart';
import '../Controller/history_controller.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);
  final HistoryController controller = Get.put(HistoryController());
  CalendarController calendarController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              WidgetUtils.buildAppBar(
                text: 'رویداد های روز',
                innerPage: true,
              ),
              SizedBox(
                height: Get.height * .03,
                width: Get.width,
              ),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  padding: paddingAll8,
                  child: (controller.dayList
                          .where((element) => element.alarms is EventModel)
                          .toList()
                          .isNotEmpty)
                      ? ListView.builder(
                          itemCount: controller.dayList
                              .where((element) => element.alarms is EventModel)
                              .toList()
                              .length,
                          itemBuilder: (BuildContext context, int index) =>
                              _buildEventItem(
                            item: controller.dayList
                                .where(
                                    (element) => element.alarms is EventModel)
                                .toList()[index],
                          ),
                        )
                      : Center(
                          child: Text(
                            'رویدادی یافت نشد',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildEventItem({required DayCalendarModel item}) {
    return GestureDetector(
      onLongPress: () {
        calendarController.eventSelect(true);
      },
      child: Obx(() => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: Get.width,
            height: Get.height * .08,
            decoration: BoxDecoration(
              color: (calendarController.eventSelect.isTrue)
                  ? Colors.red.shade800
                  : eventColor,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(12.0),
              ),
              boxShadow: ViewUtils.shadow(),
            ),
            child: (calendarController.eventSelect.isTrue)
                ? Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          calendarController.eventSelect(false);
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          calendarController.deleteEvent(item: item);
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
