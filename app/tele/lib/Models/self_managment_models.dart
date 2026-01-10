class SelfManagmentModels {
  final String id;
  final String title;
  final String extraDetail;
  final String picture;
  final String createDate;
  SelfManagmentModels({
    required this.id,
    required this.title,
    required this.extraDetail,
    required this.picture,
    required this.createDate,
  });
  factory SelfManagmentModels.fromJson(Map<String,dynamic> json) {
    return SelfManagmentModels(
      id: json['_id'] ?? '', 
      title: json['title'] ?? '', 
      extraDetail: json['extra_detail'] ?? '', 
      picture: json['picture'] ?? '', 
      createDate: json['create_date'] ?? ''
      );
  }
}