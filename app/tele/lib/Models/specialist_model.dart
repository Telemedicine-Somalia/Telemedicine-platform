class SpecialistModel {
  final String id;
  final String name;
  final String sequenceId;
  final String extraDetail;
  final String picture;
  final String createDate;
  SpecialistModel({
    required this.id,
    required this.name,
    required this.sequenceId,
    required this.extraDetail,
    required this.picture,
    required this.createDate,
  });
  factory SpecialistModel.fromJson(Map<String, dynamic> json) {
    return SpecialistModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown',
      sequenceId: json['sequence_id'] ?? '',
      extraDetail: json['extra_detail'] ?? '',
      picture: json['picture'] ?? '', // Ensure it's not null
      createDate: json['create_date'] ?? '', // Ensure it's not null
    );
  }
}
