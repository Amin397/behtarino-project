import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note/Consts/colors.dart';
import 'package:my_note/Consts/edge_insets.dart';
import 'package:my_note/Globals/blocs.dart';
import 'package:my_note/Utils/widget_utils.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../Controller/calendar_controller.dart';
import 'Widgets/clock_part_item.dart';

class CalendarScreen extends StatelessWidget {
  CalendarScreen({Key? key}) : super(key: key);
  final CalendarController controller = Get.put(CalendarController());

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
                text: 'BehtariNote',
                innerPage: false
              ),
              SizedBox(
                height: Get.height * .01,
              ),
              _buildSingleDay(),
              const Divider(),
              Expanded(
                child: SizedBox(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: GetBuilder(
                    init: controller,
                    builder: (ctx) => ListView.builder(
                      controller: controller.scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.dayList.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ClockPartItem(
                        controller: controller,
                        item: controller.dayList[index],
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

  Widget _buildSingleDay() {
    return SizedBox(
      width: Get.width,
      height: Get.height * .06,
      child: Center(
        child: AutoSizeText(
          Globals.time.format1(),
        ),
      ),
    );
  }
}
