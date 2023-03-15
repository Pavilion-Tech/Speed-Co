class ProviderModel {
  String? message;
  bool? status;
  ProviderData? data;

  ProviderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?  ProviderData.fromJson(json['data']) : null;
  }

}

class ProviderData {
  String? id;
  String? email;
  String? name;
  CategoryId? categoryId;
  String? currentLatitude;
  String? currentLongitude;
  String? firebaseToken;
  String? phoneNumber;
  String? personalPhoto;
  String? currentLanguage;
  String? address;
  int? status;
  int? totalRate;

  ProviderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    categoryId = json['category_id'] != null
        ?  CategoryId.fromJson(json['category_id'])
        : null;
    currentLatitude = json['current_latitude'];
    currentLongitude = json['current_longitude'];
    firebaseToken = json['firebase_token'];
    phoneNumber = json['phone_number'];
    personalPhoto = json['personal_photo'];
    currentLanguage = json['current_language'];
    address = json['address'];
    status = json['status'];
    totalRate = json['total_rate'];
  }

}

class CategoryId {
  String? id;
  String? image;
  String? name;

  CategoryId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
  }

}
