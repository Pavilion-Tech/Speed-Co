class OrdersModel {
  String? message;
  bool? status;
  Data? data;

  OrdersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  String? userName;
  int? status;
  int? itemNumber;
  String? date;
  String? time;
  String? serviceImage;
  String? description;
  List<String>? images;
  String? createdAt;
  String? providerName;
  String? providerId;


  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    status = json['status'];
    itemNumber = json['item_number'];
    date = json['date'];
    time = json['time'];
    serviceImage = json['service_image'];
    description = json['description'];
    images = json['images'].cast<String>();
    createdAt = json['created_at'];
    providerName = json['provider_name'];
    providerId = json['provider_id'];

  }

}
