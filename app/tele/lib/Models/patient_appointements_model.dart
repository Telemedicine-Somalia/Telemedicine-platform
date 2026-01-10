class PatientAppointementsModel {
  final String id;
  final int status;
  final String appointmentDate;
  final String doctorName;
  final String patientName;
  final String doctorProfile;
  final String shiftTime;
  final String shiftDay;
  final String doctorToken;
  final String patientToken;
  final String doctorPhone;
  final String patientPhone;
  final String doctorId;
  final String patientId;
  final String isReviewed;
  PatientAppointementsModel({
    required this.id,
    required this.status,
    required this.appointmentDate,
    required this.doctorName,
    required this.patientName,
    required this.doctorProfile,
    required this.shiftTime,
    required this.shiftDay,
    required this.doctorToken,
    required this.patientToken,
    required this.patientPhone,
    required this.doctorPhone,
    required this.doctorId,
    required this.patientId,
    required this.isReviewed,
  });
  factory PatientAppointementsModel.fromJson(Map<String, dynamic> json) {
    return PatientAppointementsModel(
      id: json['_id'] ?? '',
      status: json['status'] ?? 0,
      appointmentDate: json['appointment_date'] ?? '',
      doctorName: json['doctor_name'] ?? '',
      patientName: json['patient_name'] ?? '',
      doctorProfile: json['doctor_profile'] ?? '',
      shiftTime: json['shift_time'] ?? '',
      shiftDay: json['shift_day'] ?? '',
      doctorToken: json['doctor_token'] ?? '',
      patientToken: json['patient_token'] ?? '',
      doctorPhone: json['doctor_phone'] ?? '',
      patientPhone: json['patient_phone'] ?? '',
      doctorId: json['doctor_id'] ?? '',
      patientId: json['patient_id'] ?? '',
      // isReviewed: json['is_reviewed'] ?? '',
      isReviewed: json['is_reviewed']?.toString() ?? 'false',
    );
  }
  String toString() {
    return 'Appointment(id: $id, status: $status, date: $appointmentDate, doctor: $doctorName, time: $shiftTime, day: $shiftDay)';
  }
}
