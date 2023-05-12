// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'dart:convert';

Message messageFromJson(String str) => Message.fromJson(json.decode(str));

String messageToJson(Message data) => json.encode(data.toJson());

class Message {
  String message;
  String id;
  bool hasReply;
  bool isReply;
  Message? replies;

  Message({
    required this.message,
    required this.id,
    required this.hasReply,
    required this.isReply,
    this.replies,
  });

  Message copyWith({
    String? message,
    String? id,
    bool? hasReply,
    bool? isReply,
    Message? replies,
  }) =>
      Message(
        message: message ?? this.message,
        id: id ?? this.id,
        hasReply: hasReply ?? this.hasReply,
        isReply: isReply ?? this.isReply,
        replies: replies ?? this.replies,
      );

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        message: json["message"],
        id: json["id"],
        hasReply: json["hasReply"],
        isReply: json["isReply"],
        replies: json["replies"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
        "hasReply": hasReply,
        "isReply": isReply,
        "replies": replies,
      };
}
