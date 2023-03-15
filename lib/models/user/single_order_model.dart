class SingleOrderModel {
  String? message;
  bool? status;
  Data? data;

  SingleOrderModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? providerName;
  String? providerLatitude;
  String? providerLongitude;
  String? userPhone;
  String? serviceImage;
  String? providerPhoneNumber;
  String? providerImage;


  Data.fromJson(Map<String, dynamic> json) {
    providerName = json['provider_name'];
    providerLatitude = json['provider_latitude'];
    providerLongitude = json['provider_longitude'];
    providerImage = json['provider_image'];
    providerPhoneNumber = json['provider_phone_number'];
    userPhone = json['user_phone'];
    serviceImage = json['service_image'];
  }
}
