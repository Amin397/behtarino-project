import 'dart:convert';

import 'package:get_storage/get_storage.dart';

import '../Screens/Calendar/Model/day_calendar_model.dart';

class MyStorage {
  static Future set({String? name, String? value}) async {
    GetStorage box = GetStorage();
    if (value == null) {
      box.remove('name');
    }
    return box.write(name!, value);
  }

  static dynamic getString({String? name}) {
    GetStorage box = GetStorage();
    return box.read(name!);
  }

  static dynamic cleanStorage({String? name}) {
    GetStorage box = GetStorage();
    return box.remove(name!);
  }
}

class StorageUtils {
  static Future<void> setMobile({String? mobile}) async {
    await MyStorage.set(name: 'mobile', value: mobile);
  }

  static Future<dynamic> getMobile() async {
    return MyStorage.getString(name: 'mobile');
  }

  static Future<void> setKey({String? key}) async {
    await MyStorage.set(name: 'key', value: key);
  }

  static Future<dynamic> getKey() async {
    return MyStorage.getString(name: 'key');
  }

  static Future<void> setToken({String? token}) async {
    await MyStorage.set(name: 'token', value: token);
  }

  static Future<dynamic> getToken() async {
    return MyStorage.getString(name: 'token');
  }

  static Future<void> setEvent({required DayCalendarModel model}) async {
    List<DayCalendarModel> eventList = [];

    eventList.add(model);

    await MyStorage.set(
      name: 'event',
      value: jsonEncode(eventList.map((e) => e.toMap()).toList()),
    );
  }

  static Future<void> cleanEvent() async {
    await MyStorage.cleanStorage(name:'event');
  }

  static Future<List<DayCalendarModel>> getEvent() async {
    List<DayCalendarModel> eventList = [];

    for (var o in jsonDecode(MyStorage.getString(name: 'event').toString())) {
      eventList.add(DayCalendarModel.fromJson(o));
      print(o);
    }

    return eventList;
  }
}
