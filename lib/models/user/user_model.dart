class UserModel {
  String? message;
  bool? status;
  UserData? data;

  UserModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  String? id;
  String? name;
  String? phoneNumber;
  String? currentLatitude;
  String? currentLongitude;
  String? firebaseToken;
  String? currentLanguage;
  String? personalPhoto;
  int? status;
  String? apiToken;
  String? email;


  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    currentLatitude = json['current_latitude'];
    currentLongitude = json['current_longitude'];
    firebaseToken = json['firebase_token'];
    currentLanguage = json['current_language'];
    personalPhoto = json['personal_photo'];
    status = json['status'];
    apiToken = json['api_token'];
  }

}
