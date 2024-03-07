class MessageModel {
  MessageModel({
    required this.toId,
    required this.read,
    required this.messType,
    required this.message,
    required this.fromId,
    required this.sent,
  });
  late final String toId;
  late final String read;
  late final Type messType;
  late final String message;
  late final String fromId;
  late final String sent;

  MessageModel.fromJson(Map<String, dynamic> json) {
    toId = json['toId'].toString();
    read = json['read'].toString();
    messType = json['mess_type'].toString() == Type.images.name
        ? Type.images
        : Type.text;
    message = json['message'].toString();
    fromId = json['fromId'].toString();
    sent = json['sent'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['read'] = read;
    data['mess_type'] = messType;
    data['message'] = message;
    data['fromId'] = fromId;
    data['sent'] = sent;
    return data;
  }
}

enum Type { text, images }
