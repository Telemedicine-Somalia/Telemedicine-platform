class PatientTransectionModel {
  final String id;
  final int status;
  final double amount;
  final String senderPhone;  
  final String reciverPhone;  
  final String doctorName; 
  final String patientName;
  final String createDate;
  PatientTransectionModel({
    required this.id,
    required this.status,
    required this.amount,
    required this.senderPhone,
    required this.reciverPhone,
    required this.doctorName,
    required this.patientName,
    required this.createDate
  });

  factory PatientTransectionModel.fromJson(Map<String,dynamic>json) {
    return PatientTransectionModel(
      id: json['_id'] ?? '', 
      status: json['status'] ?? 0, 
      amount: (json['amount'] ?? 0).toDouble(), 
      senderPhone: json['sender_phone'] ?? '', 
      reciverPhone: json['reciver_phone'] ?? '', 
      doctorName: json['doctor_name'] ?? '', 
      patientName: json['patient_name'] ?? '',
      createDate: json['create_date'] ?? ''
      );
  }
}