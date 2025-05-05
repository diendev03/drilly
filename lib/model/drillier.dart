class Drillier {
  String uuid;
  String username;
  String name;
  String email;
  String password;
  String avatar;
  String birthday;
  String phone;
  String createAt;

  // Constructor with all properties
  Drillier({
    required this.uuid,
    required this.email,
    required this.password,
    required this.createAt,
    this.username = "",
    this.name = "",
    this.avatar = '',
    this.birthday = '',
    this.phone = '',
  });

  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "username": username,
      "name": name,
      "email": email,
      "password": password,
      "avatar": avatar,
      "birthday": birthday,
      "phone": phone,
      "create_at": createAt,
    };
  }

  // Convert Map to Drillier
  static Drillier fromMap(Map<String, dynamic> map) {
    return Drillier(
        uuid: map["uuid"],
        username: map['username'] ?? '',
        name: map['name'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        avatar: map['avatar'] ?? '',
        birthday: map['birthday'] ?? '',
        phone: map['phone'] ?? '',
        createAt: map['create_at'] ?? '');
  }

  @override
  String toString() {
    return 'Drillier{uuid: $uuid, username: $username, name: $name, email: $email, password: $password, avatar: $avatar, birthday: $birthday, phone: $phone, createAt: $createAt}';
  }
}
