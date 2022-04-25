import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note/Consts/edge_insets.dart';

import '../../../Consts/colors.dart';
import '../../../Globals/blocs.dart';
import '../../../Utils/view_utils.dart';
import '../../../Utils/widget_utils.dart';
import '../Controller/new_event_controller.dart';
import '../Model/select_time_model.dart';

class NewEventScreen extends StatelessWidget {
  NewEventScreen({Key? key}) : super(key: key);
  final NewEventController controller = Get.put(NewEventController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              WidgetUtils.buildAppBar(
                text: Globals.time.format1(),
                innerPage: true,
              ),
              SizedBox(
                height: Get.height * .03,
              ),
              Expanded(
                child: Container(
                  padding: paddingAll8,
                  height: double.maxFinite,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      _buildEventTitle(),
                      SizedBox(
                        height: Get.height * .02,
                      ),
                      _buildEventDetails(),
                      SizedBox(
                        height: Get.height * .02,
                      ),
                      WidgetUtils.actionButton(
                        width: Get.width,
                        text: 'ثبت',
                        height: Get.height * .07,
                        radius: radiusAll6,
                        textSize: 18.0,
                        shadow: ViewUtils.shadow(),
                        func: (){
                          controller.submitNewEvent();
                        }
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventTitle() {
    return Container(
      height: Get.height * .15,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: radiusAll10,
        border: Border.all(
          color: Colors.grey.withOpacity(.5),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'نام رویداد',
              style: TextStyle(
                color: textColor,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          WidgetUtils.textFormField(
            controller: controller.eventTitle,
            height: Get.height * .06,
            width: Get.width,
            autoFocus: false,
            enable: true,
            label: 'مثال : جشن نوروز',
            fillColor: Colors.blueAccent.withOpacity(.1),
            borderColor: Colors.blueAccent,
            hintSize: 16.0,
            inputAction: TextInputAction.done,
            func: (text) {},
            maxLength: 60,
            maxLines: 1,
            numeric: false,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              color: textColor,
              fontSize: 16.0,
            ),
            placeHolderColor: Colors.grey,
            onChange: (s) {},
            focusedColor: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetails() {
    return Container(
      width: Get.width,
      height: Get.height * .35,
      padding: paddingAll8,
      decoration: BoxDecoration(
        borderRadius: radiusAll10,
        border: Border.all(
          color: Colors.grey.withOpacity(.5),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'زمان رویداد',
              style: TextStyle(
                color: textColor,
                fontSize: 16.0,
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Expanded(
            child: SizedBox(
              height: double.maxFinite,
              width: double.maxFinite,
              child: Column(
                children: [
                  _buildEventTime(),
                  _buildEventEndTime()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildEventTime() {
    return Flexible(
      flex: 1,
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Row(
          children: [
            _buildEventStartTime(
                text: 'دقیقه',
                list: controller.minuteList,
                pageController: controller.minutePageController),
            Text(
              ':',
              style: TextStyle(
                color: Colors.grey.withOpacity(.8),
                fontSize: 30.0,
              ),
            ),
            _buildEventStartTime(
              text: 'ساعت',
              list: controller.hourList,
              pageController: controller.hourPageController,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventStartTime({
    required String text,
    required List<SelectTimeModel> list,
    required PageController pageController,
  }) {
    return Flexible(
      child: Container(
        padding: paddingAll8,
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.grey.withOpacity(.8),
                fontSize: 16.0,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: Get.height * .016,
                ),
                height: double.maxFinite,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueAccent.withOpacity(.5),
                    width: 2.0,
                  ),
                  borderRadius: radiusAll6,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.previous(
                          list: list,
                          pageController: pageController,
                        );
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 18.0,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: pageController,
                          itemCount: list.length,
                          itemBuilder: (BuildContext context, int index) =>
                              _buildTimeNumber(
                            item: list[index],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        controller.next(
                          list: list,
                          pageController: pageController,
                        );
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeNumber({SelectTimeModel? item}) {
    return Obx(
      () => Center(
        child: Text(
          item!.number,
          style: TextStyle(
            color: (item.isSelected.isTrue)
                ? textColor
                : Colors.grey.withOpacity(.5),
            fontSize: (item.isSelected.isTrue) ? 20.0 : 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildEventEndTime() {
    return Flexible(
      flex: 1,
      child: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'مدت زمان رویداد (دقیقه)',
              style: TextStyle(
                color: textColor,
                fontSize: 16.0,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: Get.height * .023,
                  horizontal: Get.width * .2,
                ),
                height: double.maxFinite,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blueAccent.withOpacity(.5),
                    width: 2.0,
                  ),
                  borderRadius: radiusAll6,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.previous(
                          list: controller.eventMinuteList,
                          pageController: controller.eventMinutePageController,
                        );
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        size: 18.0,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: double.maxFinite,
                        width: double.maxFinite,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          controller: controller.eventMinutePageController,
                          itemCount: controller.eventMinuteList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              _buildTimeNumber(
                                item: controller.eventMinuteList[index],
                              ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        controller.next(
                          list: controller.eventMinuteList,
                          pageController: controller.eventMinutePageController,
                        );
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
