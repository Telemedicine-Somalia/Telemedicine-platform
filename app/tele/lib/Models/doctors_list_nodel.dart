class DoctorList {
  final String id;
  final int status;
  final String name;
  final String sequenceid;
  final String email;
  final double consultationfee;
  final int experienceyears;
  final String speciality;
  final String countries;
  final String phone;
  final String picture;
  final String createDate;
  final String hospitalname;
  final double rating;
  final String doctorToken;
  DoctorList({
    required  this.id,
    required this.status,
    required this.name,
    required this.sequenceid,
    required this.email,
    required this.consultationfee,
    required this.experienceyears,
    required this.speciality,
    required this.countries,
    required this.phone,
    required this.picture,
    required this.createDate,
    required this.hospitalname,
    required this.rating,
    required this.doctorToken,
  });
  factory DoctorList.fromJson(Map<String,dynamic> json) {
    return DoctorList(
      id: json['_id'] ?? '', 
      status: json['status'] ?? 0, 
      name: json['name'] ?? 'unknow', 
      sequenceid: json['sequence_id'] ?? '', 
      email: json['email'] ?? 'unknow', 
      consultationfee: (json['consultation_fee'] ?? 0).toDouble(), 
      experienceyears: json['experience_years'] ?? 0, 
      speciality: json['speciality'] ?? "", 
      countries: json['countries'] ?? '', 
      phone: json['phone'] ?? '', 
      picture: json['picture'] ?? '', 
      createDate: json['create_date'] ?? '', 
      hospitalname: json['hospital_name'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      doctorToken: json['token'] ?? ''
      );
  }
}