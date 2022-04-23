import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_note/Globals/blocs.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../Consts/colors.dart';
import '../../../Consts/edge_insets.dart';
import '../../../Utils/view_utils.dart';
import '../../../Utils/widget_utils.dart';
import '../Controller/otp_controller.dart';

class CheckOtpScreen extends StatelessWidget {
  CheckOtpScreen({Key? key}) : super(key: key);

  final OtpController controller = Get.put(OtpController());

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
              _buildTopText(),
              SizedBox(
                height: Get.height * .02,
              ),
              Padding(
                padding: paddingSymmetricH30,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    animationType: AnimationType.fade,
                    autoFocus: true,
                    // validator: (v) {
                    //   if (v!.length < 3) {
                    //     return "I'm from validator";
                    //   } else {
                    //     return null;
                    //   }
                    // },
                    onTap: (){
                      controller.invalidCode(false);
                    },
                    pinTheme: PinTheme(
                        activeColor: Colors.blueAccent,
                        shape: PinCodeFieldShape.box,
                        borderRadius: radiusAll12,
                        fieldHeight: Get.height * .075,
                        fieldWidth: Get.width * .12,
                        activeFillColor: Colors.white,
                        selectedFillColor: Colors.blueAccent.withOpacity(.1),
                        inactiveFillColor: Colors.white),

                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    // errorAnimationController: errorController,
                    controller: controller.otpController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      controller.checkOtp();
                    },
                    onChanged: (String value) {},
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              Obx(
                () => (controller.invalidCode.isTrue)
                    ? SizedBox(
                        height: Get.height * .05,
                        width: Get.width,
                        child: AutoSizeText(
                          'کد وارد شده اشتباه است',
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 12.0,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ),
              SizedBox(
                height: Get.height * .02,
              ),
              WidgetUtils.actionButton(
                width: Get.width,
                height: Get.height * .06,
                text: 'ارسال',
                func: () {
                  controller.checkOtp();
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

  Widget _buildTopText() {
    return RichText(
      text: TextSpan(
        text: 'کد ۴ رقمی ارسال شده به شماره ی \n',
        style: TextStyle(color: textColor, fontFamily: 'iranSans'),
        children: [
          TextSpan(
            text: Globals.user.user.mobile.toString(),
            style: const TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: '  را وارد کنید',
            style: TextStyle(color: textColor, fontFamily: 'iranSans'),
          ),
        ],
      ),
    );
  }
}
