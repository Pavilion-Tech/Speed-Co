class OrdersModel {
  String? message;
  bool? status;
  Data? data;

  OrdersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  int? pages;
  int? count;
  List<OrderData>? data;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    pages = json['pages'];
    count = json['count'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
  }
}

class OrderData {
  String? id;
  String? serviceId;
  String? serviceTitle;
  String? serviceImage;
  String? userName;
  String? userPhone;
  String? userLatitude;
  String? userLongitude;
  String? userAddress;
  String? providerName;
  String? providerId;
  String? providerLatitude;
  String? providerLongitude;
  String? providerPhoneNumber;
  String? providerImage;
  int? status;
  int? itemNumber;
  String? date;
  String? time;
  List<String>? images;
  String? createdAt;
  String? description;


  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    serviceTitle = json['service_title'];
    serviceImage = json['service_image'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    userLatitude = json['user_latitude'];
    userLongitude = json['user_longitude'];
    userAddress = json['user_address'];
    providerName = json['provider_name'];
    providerId = json['provider_id'];
    providerLatitude = json['provider_latitude'];
    providerLongitude = json['provider_longitude'];
    providerPhoneNumber = json['provider_phone_number'];
    providerImage = json['provider_image'];
    status = json['status'];
    itemNumber = json['item_number'];
    date = json['date'];
    time = json['time'];
    images = json['images'].cast<String>();
    createdAt = json['created_at'];
    description = json['description'];
  }
}
