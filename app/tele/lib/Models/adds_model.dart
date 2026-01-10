class AddsModel {
  final String id;
  final int status;
  final String picture;
  final String createDate;

  AddsModel({
    required this.id,
    required this.status,
    required this.picture,
    required this.createDate,
  });
  factory AddsModel.fromJson(Map<String,dynamic> json) {
    return AddsModel(
      id: json['_id'] ?? '', 
      status: json['status'] ?? 0, 
      picture: json['picture'] ?? '', 
      createDate: json['create_date'] ?? ''
      );
  }
}