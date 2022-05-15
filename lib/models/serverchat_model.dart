import 'dart:convert';
import 'package:htttp/models/message_model.dart';

class ServerChat {
  String url;
  List<Message> messages = [];
  ServerChat({
    required this.url,
    this.messages = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory ServerChat.fromMap(Map<String, dynamic> map) {
    return ServerChat(
      url: map['url'] ?? '',
      messages:
          List<Message>.from(map['messages']?.map((x) => Message.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServerChat.fromJson(String source) =>
      ServerChat.fromMap(json.decode(source));
}
