import 'dart:convert';

class ReciverUser {
  String? sId;
  String? name;
  String? bio;
  String? photoUrl;
  String? phoneNumber;
  List<dynamic>? chat;

  ReciverUser({
    this.sId,
    this.name,
    this.bio,
    this.photoUrl,
    this.phoneNumber,
    this.chat,
  });

  ReciverUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    bio = json['bio'];
    photoUrl = json['photoUrl'];
    phoneNumber = json['phoneNumber'];
    if (json['chat'] != null) {
      chat = <dynamic>[];
      json['chat'].forEach((v) {
        chat!.add(v);
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
      data['chat'] = this.chat!.toList();
    }

    return data;
  }
}
