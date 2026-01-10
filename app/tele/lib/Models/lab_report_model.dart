class LabReportModel {
  final String id;
  final String sequenceId;
  final String reportUrl;
  final DateTime createDate;
  final String doctorName;
  final String patientName;
  final String patientToken;
  final String doctorToken;
  final String patientId;
  final String doctorId;
  final String appointmentId;
  final String patientGender;
  final int patientAge;
  final String doctorPhone;
  final String patientPhone;

  LabReportModel({
    required this.id,
    required this.sequenceId,
    required this.reportUrl,
    required this.createDate,
    required this.doctorName,
    required this.patientName,
    required this.patientToken,
    required this.doctorToken,
    required this.patientId,
    required this.doctorId,
    required this.appointmentId,
    required this.patientGender,
    required this.patientAge,
    required this.doctorPhone,
    required this.patientPhone,
  });

  factory LabReportModel.fromJson(Map<String, dynamic> json) {
    return LabReportModel(
      id: json['_id'] ?? '',
      sequenceId: json['sequence_id'] ?? '',
      reportUrl: json['report_url'] ?? '',
      // createDate: json['create_date'] ?? '',
      createDate: DateTime.parse(json['create_date']),
      doctorName: json['doctor_name'] ?? '',
      patientName: json['patient_name'] ?? '',
      patientToken: json['patient_token'] ?? '',
      doctorToken: json['doctor_token'] ?? '',
      patientId: json['patient_id'] ?? '',
      doctorId: json['doctor_id'] ?? '',
      appointmentId: json['appointment_id'] ?? '',
      patientGender: json['patient_Gender'] ?? '',
      patientAge: json['patient_Age'] ?? '',
      doctorPhone: json['doctor_phone'] ?? '',
      patientPhone: json['patient_phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sequence_id': sequenceId,
      'report_url': reportUrl,
      'create_date': createDate.toIso8601String(),
      'doctor_name': doctorName,
      'patient_name': patientName,
      'patient_token': patientToken,
      'doctor_token': doctorToken,
      'patient_id': patientId,
      'doctor_id': doctorId,
      'appointment_id': appointmentId,
      'patient_Gender': patientGender,
      'patient_Age': patientAge,
      'doctor_phone': doctorPhone,
      'patient_phone': patientPhone,
    };
  }
}
