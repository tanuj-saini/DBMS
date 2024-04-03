class MessageModel {
  String? sId;
  String? name;
  String? bio;
  String? photoUrl;
  String? phoneNumber;
  List<Chat>? chat;

  MessageModel({
    this.sId,
    this.name,
    this.bio,
    this.photoUrl,
    this.phoneNumber,
    this.chat,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    bio = json['bio'];
    photoUrl = json['photoUrl'];
    phoneNumber = json['phoneNumber'];
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(new Chat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['photoUrl'] = this.photoUrl;
    data['phoneNumber'] = this.phoneNumber;
    if (this.chat != null) {
      data['chat'] = this.chat!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Chat {
  String? reciverId;
  List<ChatDetails>? chatDetails;
  String? sId;

  Chat({this.reciverId, this.chatDetails, this.sId});

  Chat.fromJson(Map<String, dynamic> json) {
    reciverId = json['reciverId'];
    if (json['chatDetails'] != null) {
      chatDetails = <ChatDetails>[];
      json['chatDetails'].forEach((v) {
        chatDetails!.add(new ChatDetails.fromJson(v));
      });
    }
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reciverId'] = this.reciverId;
    if (this.chatDetails != null) {
      data['chatDetails'] = this.chatDetails!.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    return data;
  }
}

class ChatDetails {
  String? reciverId;
  String? message;
  String? time;
  String? sId;

  ChatDetails({this.reciverId, this.message, this.time, this.sId});

  ChatDetails.fromJson(Map<String, dynamic> json) {
    reciverId = json['reciverId'];
    message = json['message'];
    time = json['time'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reciverId'] = this.reciverId;
    data['message'] = this.message;
    data['time'] = this.time;
    data['_id'] = this.sId;

    return data;
  }
}
