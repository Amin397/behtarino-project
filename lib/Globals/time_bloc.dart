import 'dart:async';

class TimeBloc {
  final streamController = StreamController.broadcast();

  Stream get getStream => streamController.stream;

  DateTime now = DateTime.now();

  Timer? timer;

  updateTime() async {
    timer = Timer.periodic(const Duration(seconds: 60), (timer) {
      now = DateTime.now();
      streamController.sink.add(now);
    });
  }
}
