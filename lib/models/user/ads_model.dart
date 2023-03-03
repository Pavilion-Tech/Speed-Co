class AdsModel {
  String? message;
  bool? status;
  List<AdsData>? data;

  AdsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <AdsData>[];
      json['data'].forEach((v) {
        data!.add( AdsData.fromJson(v));
      });
    }
  }

}

class AdsData {
  String? id;
  String? title;
  String? description;
  String? link;
  String? backgroundImage;
  int? type;

  AdsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    link = json['link'];
    backgroundImage = json['background_image'];
    type = json['type'];
  }

}
