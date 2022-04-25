import 'dart:convert';

class DayCalendarModel {
  EventModel? alarms;
  String? time;

  DayCalendarModel({this.alarms, required this.time});

  factory DayCalendarModel.fromJson(Map<String, dynamic> json) =>
      DayCalendarModel(
        alarms: EventModel.fromJson(json["alarms"]),
        time: json['time'],
      );

  Map<String, dynamic> toMap() => {
        'time': time,
        'alarms': alarms!.toJson(),
      };
}

class EventModel {
  EventModel({
    this.id,
    this.name,
    this.start,
    this.end,
  });

  String? id;
  String? name;
  DateTime? start;
  DateTime? end;

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json["id"],
        name: json["name"],
        start: DateTime.parse(json["start"]).toLocal(),
        end: DateTime.parse(json["end"]).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "start": start!.toIso8601String(),
        "end": end!.toIso8601String(),
      };
}
