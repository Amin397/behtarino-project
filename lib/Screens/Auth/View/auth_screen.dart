import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_note/Consts/edge_insets.dart';
import 'package:my_note/Screens/Auth/Controller/AuthController.dart';
import 'package:my_note/Utils/view_utils.dart';
import 'package:my_note/Utils/widget_utils.dart';

import '../../../Consts/colors.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: paddingAll12,
          height: Get.height,
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'لطفا شماره تلفن همراه خود را وارد کنید',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16.0,
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              WidgetUtils.textFormField(
                controller: controller.phoneController,
                height: Get.height * .06,
                width: Get.width,
                autoFocus: true,
                enable: true,
                label: 'مثال : 09123456789',
                fillColor: Colors.blueAccent.withOpacity(.1),
                borderColor: Colors.blueAccent,
                hintSize: 16.0,
                inputAction: TextInputAction.done,
                func: (text) {},
                maxLength: 11,
                maxLines: 1,
                numeric: true,
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  color: textColor,
                  fontSize: 16.0,
                ),
                placeHolderColor: Colors.grey,
                onChange: (s) => ViewUtils.onChange(
                    string: s,
                    textEditingController: controller.phoneController,
                    func: () {
                      if(controller.phoneController.text.length == 11){
                        controller.sendMobile();
                      }
                    }),
                focusedColor: Colors.orange,
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              WidgetUtils.actionButton(
                width: Get.width,
                height: Get.height * .06,
                text: 'ارسال',
                func: () {
                  controller.sendMobile();
                },
                shadow: ViewUtils.shadow(),
                radius: radiusAll24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
