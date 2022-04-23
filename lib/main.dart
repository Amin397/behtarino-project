import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Consts/name_routs.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: MyPageRout.pages,
      initialRoute: NameRouts.splash,
      theme: ThemeData(
        fontFamily: 'iranSans',
      ),
    ),
  );
}
