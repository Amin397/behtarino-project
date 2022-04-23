import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'Consts/name_routs.dart';

void main() async{
  await GetStorage.init();
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
