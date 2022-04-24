import 'dart:async';

import 'package:flutter/services.dart';
import 'package:shamsi_date/shamsi_date.dart';

class TimeBloc {
  final streamController = StreamController.broadcast();

  Stream get getStream => streamController.stream;

  DateTime now = DateTime.now();


  Timer? timer;

  updateTime() async {
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      now = DateTime.now();
      streamController.sink.add(now);
    });
  }



  Jalali j1 = Jalali.now();


  String format1() {
    final f = j1.formatter;

    return '${f.wN} ${f.d} ${f.mN}';
  }

}
