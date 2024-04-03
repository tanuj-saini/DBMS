// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatModule {
  final String message;
  final String reciverId;
  final String time;
  ChatModule({
    required this.message,
    required this.reciverId,
    required this.time,
  });

  ChatModule copyWith({
    String? message,
    String? reciverId,
    String? time,
  }) {
    return ChatModule(
      message: message ?? this.message,
      reciverId: reciverId ?? this.reciverId,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'reciverId': reciverId,
      'time': time,
    };
  }

  factory ChatModule.fromMap(Map<String, dynamic> map) {
    return ChatModule(
      message: map['message'] as String,
      reciverId: map['reciverId'] as String,
      time: map['time'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModule.fromJson(String source) =>
      ChatModule.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatModule(message: $message, reciverId: $reciverId, time: $time)';

  @override
  bool operator ==(covariant ChatModule other) {
    if (identical(this, other)) return true;

    return other.message == message &&
        other.reciverId == reciverId &&
        other.time == time;
  }

  @override
  int get hashCode => message.hashCode ^ reciverId.hashCode ^ time.hashCode;
}
