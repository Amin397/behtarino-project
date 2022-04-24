import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:my_note/Consts/colors.dart';
import 'package:my_note/Consts/edge_insets.dart';

import '../../Model/day_calendar_model.dart';

class ShowAddAlarmAlert extends StatelessWidget {
  ShowAddAlarmAlert({Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: Get.width,
        height: Get.height * .3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: radiusAll12,
        ),
        padding: paddingAll8,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.clear,),
                onPressed: (){
                  Get.back(result: {'id':3});
                },
              ),
            ),
            Expanded(
              child: SizedBox(
                height: double.maxFinite,
                width: double.maxFinite,
                child: Row(
                  children: [
                    _buildAlarmItem(
                      animation: 'assets/anims/add_new.json',
                      text: 'رویداد جدید',
                      id: 0,
                    ),
                    const SizedBox(
                      width: 12.0,
                    ),
                    _buildAlarmItem(
                      animation: 'assets/anims/history.json',
                      text: 'لیست رویداد ها',
                      id: 1,
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

  Widget _buildAlarmItem({
    required String animation,
    required String text,
    required int id,
  }) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          Get.back(result: {'id': id});
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: radiusAll8,
            border: Border.all(
              color: Colors.grey.withOpacity(.3),
              width: 1,
            ),
          ),
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                animation,
                height: Get.height * .1,
                width: Get.height * .1,
              ),
              AutoSizeText(
                text,
                maxFontSize: 16.0,
                minFontSize: 10.0,
                maxLines: 1,
                style: TextStyle(
                  color: textColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
