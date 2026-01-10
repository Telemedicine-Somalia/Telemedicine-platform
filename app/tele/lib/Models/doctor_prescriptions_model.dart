class DoctorPrescriptionModel {
  final String id;
  final List<Medicines> medicines;
  final String sequenceId;
  final DateTime createDate;
  final String doctorName;
  final String patientName;
  final String patientToken;
  final String doctorToken;
  final String patientId;
  final String doctorId;
  final String appointmentId;
  final String patientPhone;
  final String doctorPhone;
  final String patientProfile;
  final String patientGender;
  final int patientAge;
  final String shiftTime;
  final String shiftDay;
  final String extraDetails;

  DoctorPrescriptionModel({
    required this.id,
    required this.medicines,
    required this.sequenceId,
    required this.createDate,
    required this.doctorName,
    required this.patientName,
    required this.patientToken,
    required this.doctorToken,
    required this.patientId,
    required this.doctorId,
    required this.appointmentId,
    required this.patientPhone,
    required this.doctorPhone,
    required this.patientProfile,
    required this.patientGender,
    required this.patientAge,
    required this.shiftTime,
    required this.shiftDay,
    required this.extraDetails,
  });

  factory DoctorPrescriptionModel.fromJson(Map<String, dynamic> json) {
    return DoctorPrescriptionModel(
      id: json['_id'] ?? '',
      medicines: (json['medicines'] as List)
          .map((e) => Medicines.fromJson(e))
          .toList(),
      sequenceId: json['sequence_id'] ?? '',
      createDate: DateTime.parse(json['create_date']),
      doctorName: json['doctor_name'] ?? '',
      patientName: json['patient_name'] ?? '',
      patientToken: json['patient_token'] ?? '',
      doctorToken: json['doctor_token'] ?? '',
      patientId: json['patient_id'] ?? '',
      doctorId: json['doctor_id'] ?? '',
      appointmentId: json['appointment_id'] ?? '',
      patientPhone: json['patient_phone'] ?? '',
      doctorPhone: json['doctor_phone'] ?? '',
      patientProfile: json['patient_profile'] ?? '',
      patientGender: json['patient_Gender'] ?? '',
      patientAge: json['patient_Age'] ?? 0,
      shiftTime: json['shift_time'] ?? '',
      shiftDay: json['shift_day'] ?? '',
      extraDetails: json['extra_detail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'medicines': medicines.map((e) => e.toJson()).toList(),
      'sequence_id': sequenceId,
      'create_date': createDate.toIso8601String(),
      'doctor_name': doctorName,
      'patient_name': patientName,
      'patient_token': patientToken,
      'doctor_token': doctorToken,
      'patient_id': patientId,
      'doctor_id': doctorId,
      'appointment_id': appointmentId,
      'patient_phone': patientPhone,
      'doctor_phone': doctorPhone,
      'patient_profile': patientProfile,
      'patient_Gender': patientGender,
      'patient_Age': patientAge,
      'shift_time': shiftTime,
      'shift_day': shiftDay,
      'extra_detail': extraDetails,
    };
  }
}

class Medicines {
  final String id;
  final double duration;
  final String medicineName;
  final double dosage;
  final String frequency;

  Medicines({
    required this.id,
    required this.duration,
    required this.medicineName,
    required this.dosage,
    required this.frequency,
  });

  factory Medicines.fromJson(Map<String, dynamic> json) {
    return Medicines(
      id: json['_id'] ?? '',
      duration: (json['duration'] ?? 0).toDouble(),
      medicineName: json['medicine_name'] ?? '',
      dosage: (json['dosage'] ?? 0).toDouble(),
      frequency: json['frequency'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'duration': duration,
      'medicine_name': medicineName,
      'dosage': dosage,
      'frequency': frequency,
    };
  }
}
