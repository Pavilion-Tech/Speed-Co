class ServiceModel {
  String? message;
  bool? status;
  List<ServiceData>? data;

  ServiceModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ServiceData>[];
      json['data'].forEach((v) {
        data!.add( ServiceData.fromJson(v));
      });
    }
  }

}

class ServiceData {
  String? id;
  String? title;
  String? categoryId;
  String? image;

  ServiceData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['category_id'];
    image = json['image'];
  }
}
