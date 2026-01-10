class NotificationResponse<T> {
  final bool success;
  final String message;
  final List<T> record;

  NotificationResponse({
    required this.success,
    required this.message,
    required this.record,
  });

  factory NotificationResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromRecordJson,
  ) {
    return NotificationResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      record: (json['record'] as List)
          .map((e) => fromRecordJson(e))
          .toList(),
    );
  }
}
class PatientNotification {
  final String id;
  final String status;
  final String title;
  final String message;
  final String sequenceId;
  final DateTime createDate;
  final String patientName;
  final String patientId;
  final String patientPhone;
  final String patientProfile;
  final String patientGender;
  final int patientAge;

  PatientNotification({
    required this.id,
    required this.status,
    required this.title,
    required this.message,
    required this.sequenceId,
    required this.createDate,
    required this.patientName,
    required this.patientId,
    required this.patientPhone,
    required this.patientProfile,
    required this.patientGender,
    required this.patientAge,
  });

  factory PatientNotification.fromJson(Map<String, dynamic> json) {
    return PatientNotification(
      id: json['_id'] ?? '',
      status: json['status'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      sequenceId: json['sequence_id'] ?? '',
      createDate: DateTime.parse(json['create_date']),
      patientName: json['patient_name'] ?? '',
      patientId: json['patient_id'] ?? '',
      patientPhone: json['patient_phone'] ?? '',
      patientProfile: json['patient_profile'] ?? '',
      patientGender: json['patient_Gender'] ?? '',
      patientAge: json['patient_Age'] ?? 0,
    );
  }
}
class DoctorNotification {
  final String id;
  final String status;
  final String title;
  final String message;
  final String sequenceId;
  final DateTime createDate;
  final String doctorName;
  final String doctorId;
  final String doctorPhone;
  final String doctorProfile;
  final String doctorToken;

  DoctorNotification({
    required this.id,
    required this.status,
    required this.title,
    required this.message,
    required this.sequenceId,
    required this.createDate,
    required this.doctorName,
    required this.doctorId,
    required this.doctorPhone,
    required this.doctorProfile,
    required this.doctorToken,
  });

  factory DoctorNotification.fromJson(Map<String, dynamic> json) {
    return DoctorNotification(
      id: json['_id'] ?? '',
      status: json['status'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      sequenceId: json['sequence_id'] ?? '',
      createDate: DateTime.parse(json['create_date']),
      doctorName: json['doctor_name'] ?? '',
      doctorId: json['doctor_id'] ?? '',
      doctorPhone: json['doctor_phone'] ?? '',
      doctorProfile: json['doctor_profile'] ?? '',
      doctorToken: json['doctor_token'] ?? '',
    );
  }
}
