// ignore_for_file: file_names

class UserModel {
  UserModel({
    required this.image,
    required this.created,
    required this.name,
    required this.details,
    required this.isOnline,
    required this.id,
    required this.lastActive,
    required this.tokenPush,
  });
  late final String image;
  late final String created;
  late final String name;
  late final String details;
  late final bool isOnline;
  late final String id;
  late final String lastActive;
  late final String tokenPush;

  UserModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    created = json['created'];
    name = json['name'];
    details = json['details'];
    isOnline = json['is_online'];
    id = json['id'];
    lastActive = json['last_active'];
    tokenPush = json['tokenPush'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['created'] = created;
    data['name'] = name;
    data['details'] = details;
    data['is_online'] = isOnline;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['tokenPush'] = tokenPush;
    return data;
  }
}
