class DateModel {
  String? message;
  bool? status;
  List<DateData>? data;

  DateModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DateData>[];
      json['data'].forEach((v) {
        data!.add( DateData.fromJson(v));
      });
    }
  }

}

class DateData {
  String? id;
  String? dayType;
  String? weekDay;
  List<DayHours>? dayHours;
  String? status;

  DateData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dayType = json['day_type'];
    weekDay = json['week_day'];
    if (json['day_hours'] != null) {
      dayHours = <DayHours>[];
      json['day_hours'].forEach((v) {
        dayHours!.add(new DayHours.fromJson(v));
      });
    }
    status = json['status'];
  }

}

class DayHours {
  String? hourRange;
  String? status;
  String? sId;

  DayHours.fromJson(Map<String, dynamic> json) {
    hourRange = json['hour_range'];
    status = json['status'];
    sId = json['_id'];
  }
}
