class Hospital {
  final String id;
  final String name;
  final String sequenceId;
  final String email;
  final String address;
  final String phone;
  final String picture;
  final String createDate;
  Hospital({
    required this.id,
    required this.name,
    required this.sequenceId,
    required this.email,
    required this.address,
    required this.phone,
    required this.picture,
    required this.createDate,
  });
  factory Hospital.fromJson(Map<String, dynamic> json) {
    return Hospital(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      sequenceId: json['sequence_id'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      picture: json['picture'] ?? '', // Ensure it's not null
      createDate: json['create_date'] ?? '', // Ensure it's not null
    );
  }
}
