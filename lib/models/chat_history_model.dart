class ChatHistoryModel {
  String? message;
  bool? status;
  List<ChatHistoryData>? data;

  ChatHistoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ChatHistoryData>[];
      json['data'].forEach((v) {
        data!.add( ChatHistoryData.fromJson(v));
      });
    }
  }

}

class ChatHistoryData {
  String? id;
  String? serviceImage;
  String? userName;
  String? userPhone;
  String? userLatitude;
  String? userLongitude;
  String? providerName;
  String? providerId;
  int? status;
  int? itemNumber;
  String? date;
  String? time;
  String? description;
  List<Messages>? messages;
  String? createdAt;



  ChatHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceImage = json['service_image'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    userLatitude = json['user_latitude'];
    userLongitude = json['user_longitude'];
    providerName = json['provider_name'];
    providerId = json['provider_id'];
    status = json['status'];
    itemNumber = json['item_number'];
    date = json['date'];
    time = json['time'];
    description = json['description'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

}

class Messages {
  int? messageType;
  String? sender;
  String? message;
  String? sId;
  String? date;
  String? uploadedMessageFile;


  Messages.fromJson(Map<String, dynamic> json) {
    messageType = json['message_type'];
    sender = json['sender'];
    message = json['message'];
    sId = json['_id'];
    date = json['date'];
    uploadedMessageFile = json['uploaded_message_file'];
  }
}
