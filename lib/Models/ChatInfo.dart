class ChatInfo {
  String? reciverId;
  List<ChatDetails>? chatDetails;
  String? sId;

  ChatInfo({this.reciverId, this.chatDetails, this.sId});

  ChatInfo.fromJson(Map<String, dynamic> json) {
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
  bool? itsMe;
  String? sId;
  int? iV;

  ChatDetails(
      {this.reciverId, this.message, this.itsMe, this.time, this.sId, this.iV});

  ChatDetails.fromJson(Map<String, dynamic> json) {
    reciverId = json['reciverId'];
    message = json['message'];
    time = json['time'];
    sId = json['_id'];
    itsMe = json['itsMe'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reciverId'] = this.reciverId;
    data['message'] = this.message;
    data['time'] = this.time;
    data['_id'] = this.sId;
    data['itsMe'] = this.itsMe;
    data['__v'] = this.iV;
    return data;
  }
}
