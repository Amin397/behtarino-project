import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../Consts/colors.dart';
import '../Consts/edge_insets.dart';

class WidgetUtils {
  static Widget textFormField({
    TextEditingController? controller,
    String? label,
    int? maxLength,
    bool numeric = false,
    int? maxLines,
    bool? enable,
    TextAlign? textAlign,
    TextInputAction? inputAction,
    Color fillColor = Colors.white,
    List<TextInputFormatter> formatter = const [],
    ValueChanged? onChange,
    Color? borderColor,
    FocusNode? focusNode,
    double? hintSize,
    double? height,
    double? width,
    Widget? prefixWidget,
    bool? autoFocus,
    TextStyle? textStyle,
    Function(String)? func,
    Color? focusedColor,
    Color? placeHolderColor = Colors.grey,
  }) {
    if (borderColor == null) {
      borderColor = Colors.grey.withOpacity(0.1);
      placeHolderColor = Colors.black;
    }

    return SizedBox(
      width: width,
      height: height,
      child: Center(
        child: TextField(
          onSubmitted: (text) {
            func!(text);
          },
          textInputAction: inputAction,
          enabled: enable,
          autofocus: autoFocus!,
          maxLength: maxLength,
          focusNode: focusNode,
          textAlign: textAlign!,
          keyboardType: (numeric) ? TextInputType.number : TextInputType.text,
          maxLines: maxLines,
          onChanged: onChange,
          controller: controller,
          inputFormatters: formatter,
          style: textStyle,
          decoration: InputDecoration(
            counterText: "",
            prefixIcon: prefixWidget,
            fillColor: fillColor,
            enabledBorder: OutlineInputBorder(
              borderRadius: radiusAll8,
              borderSide: BorderSide(
                color: borderColor,
                width: 1,
                style: BorderStyle.solid,
              ),
            ),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: radiusAll16,
              borderSide: BorderSide(
                color: focusedColor!,
              ),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromRGBO(173, 179, 191, 1),
                width: 0.5,
                style: BorderStyle.solid,
              ),
            ),
            hintText: label,
            errorStyle: TextStyle(
              color: Colors.red.shade600,
              fontSize: 10.0,
            ),
            hintStyle: TextStyle(
              color: placeHolderColor,
              fontSize: hintSize,
            ),
          ),
        ),
      ),
    );
  }

  static Widget actionButton({
    required double width,
    required String text,
    required double height,
    double textSize = 16.0,
    List<BoxShadow>? shadow,
    EdgeInsets padding = EdgeInsets.zero,
    Color textColor = Colors.white,
    EdgeInsets margin = EdgeInsets.zero,
    BorderRadiusGeometry radius = BorderRadius.zero,
    Function? func,
  }) {
    return GestureDetector(
      onTap: () {
        func!();
      },
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
            borderRadius: radius,
            boxShadow: shadow,
            gradient: LinearGradient(
              colors: [
                const Color(0xff4CC9F0).withOpacity(.75),
                const Color(0xff4361EE).withOpacity(.75),
                const Color(0xff3A0CA3).withOpacity(.75),
                const Color(0xff3A0CA3).withOpacity(.75),
              ],
              stops: [.5, 1.5, .1, .7],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        child: Center(
          child: AutoSizeText(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: textSize,
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildAppBar({
    required String text,
    required bool innerPage,
  }) {
    return Container(
      height: Get.height * .1,
      width: Get.width,
      color: mainColor,
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 12.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Icon(
            Icons.arrow_forward_ios,
            color: mainColor,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.back();
            },
            child: Icon(
              Icons.arrow_forward_ios,
              color:(innerPage)? Colors.white:mainColor,
            ),
          ),
        ],
      ),
    );
  }
}
