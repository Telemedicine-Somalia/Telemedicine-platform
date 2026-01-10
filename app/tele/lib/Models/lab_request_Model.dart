class LabRequestModel {
  final String status;
  final String id;
  final List<RequestedTests> requestTests;
  final String sequenceId;
  final String patientId;
  final String doctorId;
  final String appointmentId;
  final String notes;
  final DateTime createDate;
  final String patientGender;
  final int patientAge;
  final String shiftTime;
  final String shiftDay;
  final String patientPhone;
  final String doctorPhone;
  final String doctorName;
  final String patientName;

  LabRequestModel({
    required this.status,
    required this.id,
    required this.requestTests,
    required this.sequenceId,
    required this.patientId,
    required this.doctorId,
    required this.appointmentId,
    required this.notes,
    required this.createDate,
    required this.patientGender,
    required this.patientAge,
    required this.shiftTime,
    required this.shiftDay,
    required this.patientPhone,
    required this.doctorPhone,
    required this.doctorName,
    required this.patientName,
  });

  factory LabRequestModel.fromJson(Map<String, dynamic> json) {
    return LabRequestModel(
      status: json['status'] ?? '',
      id: json['_id'] ?? '',
      requestTests: (json['requested_tests'] as List)
          .map((e) => RequestedTests.fromJson(e))
          .toList(),
      sequenceId: json['sequence_id'] ?? '',
      patientId: json['patient_id'] ?? '',
      doctorId: json['doctor_id'] ?? '',
      appointmentId: json['appointment_id'] ?? '',
      notes: json['notes'] ?? '',
      createDate: DateTime.parse(
        json['create_date'] ?? DateTime.now().toIso8601String(),
      ),
      patientGender: json['patient_Gender'] ?? '',
      patientAge: json['patient_Age'] ?? 0,
      shiftTime: json['shift_time'] ?? '',
      shiftDay: json['shift_day'] ?? '',
      patientPhone: json['patient_phone'] ?? '',
      doctorPhone: json['doctor_phone'] ?? '',
      doctorName: json['doctor_name'] ?? '',
      patientName: json['patient_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      '_id': id,
      'requested_tests': requestTests.map((e) => e.toJson()).toList(),
      'sequence_id': sequenceId,
      'patient_id': patientId,
      'doctor_id': doctorId,
      'appointment_id': appointmentId,
      'notes': notes,
      'create_date': createDate.toIso8601String(),
      'patient_Gender': patientGender,
      'patient_Age': patientAge,
      'shift_time': shiftTime,
      'shift_day': shiftDay,
      'patient_phone': patientPhone,
      'doctor_phone': doctorPhone,
      'doctor_name': doctorName,
      'patient_name': patientName,
    };
  }
}

class RequestedTests {
  final String priority;
  final String id;
  final String testName;
  final String description;

  RequestedTests({
    required this.priority,
    required this.id,
    required this.testName,
    required this.description,
  });

  factory RequestedTests.fromJson(Map<String, dynamic> json) {
    return RequestedTests(
      priority: json['priority'] ?? '',
      id: json['_id'] ?? '',
      testName: json['test_name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'priority': priority,
      '_id': id,
      'test_name': testName,
      'description': description,
    };
  }
}
