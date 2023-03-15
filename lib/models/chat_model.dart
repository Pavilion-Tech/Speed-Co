class ChatModel {
  String? message;
  bool? status;
  Data? data;


  ChatModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? id;
  int? status;
  String? userName;
  List<Messages>? messages;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    userName = json['user_name'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(Messages.fromJson(v));
      });
    }
  }

}

class Messages {
  String? id;
  int? messageType;
  String? sender;
  String? createdAt;
  String? message;


  Messages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageType = json['message_type'];
    sender = json['sender'];
    createdAt = json['created_at'];
    message = json['message'];
  }


}
