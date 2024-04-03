// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String id;
  final String bio;
  final String photoUrl;
  String? token;
  final String phoneNumber;
  final List<dynamic> chat;

  UserModel({
    required this.name,
    required this.id,
    required this.bio,
    required this.photoUrl,
    required this.token,
    required this.phoneNumber,
    required this.chat,
  });

  UserModel copyWith({
    String? name,
    String? id,
    String? bio,
    String? photoUrl,
    String? token,
    String? phoneNumber,
    List<dynamic>? chat,
  }) {
    return UserModel(
      name: name ?? this.name,
      id: id ?? this.id,
      bio: bio ?? this.bio,
      photoUrl: photoUrl ?? this.photoUrl,
      token: token ?? this.token,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      chat: chat ?? this.chat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'bio': bio,
      'photoUrl': photoUrl,
      'token': token,
      'phoneNumber': phoneNumber,
      'chat': chat,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'] as String,
        id: map['_id'] as String,
        bio: map['bio'] as String,
        photoUrl: map['photoUrl'] as String,
        token: map['token'] != null ? map['token'] as String : null,
        phoneNumber: map['phoneNumber'] as String,
        chat: List<Map<String, dynamic>>.from(
            //i change chat as default and also token to final
            map['chat']?.map((x) => Map<String, dynamic>.from(x))));
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, id: $id, bio: $bio, photoUrl: $photoUrl, token: $token, phoneNumber: $phoneNumber, chat: $chat)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.id == id &&
        other.bio == bio &&
        other.photoUrl == photoUrl &&
        other.token == token &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.chat, chat);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        bio.hashCode ^
        photoUrl.hashCode ^
        token.hashCode ^
        phoneNumber.hashCode ^
        chat.hashCode;
  }
}
