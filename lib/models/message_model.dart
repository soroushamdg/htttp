import 'dart:convert';

enum Sender { user, server }

class Message {
  String msg;
  Sender sender;

  Message({
    required this.msg,
    required this.sender,
  });

  Map<String, dynamic> toMap() {
    return {
      'msg': msg,
      'sender': sender.index,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      msg: map['msg'] ?? '',
      sender: Sender.values[map['sender']],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source));
}
