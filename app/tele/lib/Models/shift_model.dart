class Shift {
  final String id;
  final int status;
  
  final String doctorId;
  final String day;
  final String time;
  final String extraDetail;
  final String createDate;
  Shift({
    required this.id,
    required this.status,
    
    required this.doctorId,
    required this.day,
    required this.time,
    required this.extraDetail,
    required this.createDate,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      id: json['_id'] ?? '', 
      status: json['status'] ?? 0,  
      doctorId: json['doctor_id'] ?? '', 
      day: json['day']?? '', 
      time: json['time']?? '', 
      extraDetail: json['extra_detail'] ?? '', 
      createDate: json['create_date'] ?? ''
      );
  }
}
class ShiftResponse {
  final bool success;
  final String message;
  final Map<String, List<Shift>> shiftsByDay;

  ShiftResponse({
    required this.success,
    required this.message,
    required this.shiftsByDay
  });
  
  factory ShiftResponse.fromJson(Map<String, dynamic> json) {
    Map<String, List<Shift>> shifts = {};

    json.forEach((key, value) {
      if (key != "success" && key != "message") {
        shifts[key] = (value as List).map((e) => Shift.fromJson(e)).toList();
      }
    });

    return ShiftResponse(
      success: json['success'],
      message: json['message'],
      shiftsByDay: shifts,
    );
  }
}