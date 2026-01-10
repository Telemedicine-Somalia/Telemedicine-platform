class DoctorAppointementsModel {
  final String id;
  final int status;
  final String appointmentDate;
  final String doctorName;
  final String patientName;
  final String patientProfile;
  final String shiftTime;
  final String shiftDay;
  final String doctorToken;
  final String patientToken;
  final String doctorPhone;
  final String patientPhone;
  final String doctorId;
  final String patientId;
  final int patienAge;
  final String patientGender;

  DoctorAppointementsModel({
    required this.id,
    required this.status,
    required this.appointmentDate,
    required this.doctorName,
    required this.patientName,
    required this.patientProfile,
    required this.shiftTime,
    required this.shiftDay,
    required this.doctorToken,
    required this.patientToken,
    required this.patientPhone,
    required this.doctorPhone,
     required this.doctorId,
    required this.patientId,
    required this.patienAge,
    required this.patientGender,
  });
  factory DoctorAppointementsModel.fromJson(Map<String, dynamic> json) {
    return DoctorAppointementsModel(
        id: json['_id'] ?? '',
        status: json['status'] ?? 0,
        appointmentDate: json['appointment_date'] ?? '',
        doctorName: json['doctor_name'] ?? '',
        patientName: json['patient_name'] ?? '',
        patientProfile: json['patient_profile'] ?? '',
        shiftTime: json['shift_time'] ?? '',
        shiftDay: json['shift_day'] ?? '',
        doctorToken: json['doctor_token'] ?? '',
        patientToken: json['patient_token'] ?? '',
        doctorPhone: json['doctor_phone'] ?? '',
        patientPhone: json['patient_phone'] ?? '',
        doctorId: json['doctor_id'] ?? '',
        patientId: json['patient_id'] ?? '',
        patientGender: json['patient_Gender'] ?? '',
        patienAge: json['patient_Age'] ?? 0,
        );
  }
  String toString() {
    return 'Appointment(id: $id, status: $status, date: $appointmentDate, doctor: $patientName, time: $shiftTime, day: $shiftDay)';
  }

  let(void Function(DoctorAppointementsModel user) fillUserInfo) {}
}
