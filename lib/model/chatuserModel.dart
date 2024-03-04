// ignore_for_file: file_names

class UserModel {
  UserModel({
    required this.image,
    required this.created,
    required this.name,
    required this.email,
    required this.details,
    required this.isOnline,
    required this.id,
    required this.lastActive,
    required this.tokenPush,
  });
  late String created;
  late String image;
  late String name;
  late String email;
  late String details;
  late bool isOnline;
  late String id;
  late String lastActive;
  late String tokenPush;

  UserModel.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? "";
    created = json['created'] ?? "";
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    details = json['details'] ?? "";
    isOnline = json['is_online'] ?? "";
    id = json['id'];
    lastActive = json['last_active'] ?? "";
    tokenPush = json['tokenPush'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['created'] = created;
    data['name'] = name;
    data['email'] = email;
    data['details'] = details;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['tokenPush'] = tokenPush;
    return data;
  }
}
