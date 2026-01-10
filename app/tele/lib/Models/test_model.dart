class Shift {
  final String id;
  final int status;
  final String sequenceId;
  final String doctorId;
  final String day;
  final String time;
  final String extraDetail;
  final String createDate;

  Shift({
    required this.id,
    required this.status,
    required this.sequenceId,
    required this.doctorId,
    required this.day,
    required this.time,
    required this.extraDetail,
    required this.createDate,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['_id'],
      status: json['status'],
      sequenceId: json['sequence_id'],
      doctorId: json['doctor_id'],
      day: json['day'],
      time: json['time'],
      extraDetail: json['extra_detail'],
      createDate: json['create_date'],
    );
  }
   String toString() {
    return 'Shift(id: $id, time: $time, doctorId: $doctorId, status: $status)';
  }
}
class ShiftSchedule {
  final bool success;
  final String message;
  final Map<String, List<Shift>> shiftsByDay;

  ShiftSchedule({
    required this.success,
    required this.message,
    required this.shiftsByDay,
  });

  factory ShiftSchedule.fromJson(Map<String, dynamic> json) {
    Map<String, List<Shift>> shifts = {};
    
    json.forEach((key, value) {
      if (key != "success" && key != "message") {
        shifts[key] = (value as List).map((e) => Shift.fromJson(e)).toList();
      }
    });

    return ShiftSchedule(
      success: json['success'],
      message: json['message'],
      shiftsByDay: shifts,
    );
  }
}
