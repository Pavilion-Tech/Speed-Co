class CategoriesModel {
  String? message;
  bool? status;
  List<CategoriesData>? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <CategoriesData>[];
      json['data'].forEach((v) {
        data!.add( CategoriesData.fromJson(v));
      });
    }
  }

}

class CategoriesData {
  String? id;
  String? title;
  String? image;

  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
  }
}
