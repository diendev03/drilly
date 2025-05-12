class Profile {
  String uuid;
  String username;
  String name;
  String avatar;
  String birthday;
  String phone;
  int follower;
  int following;
  int achievements;

  Profile({
    required this.uuid,
    required this.username,
    required this.name,
    required this.avatar,
    required this.birthday,
    required this.phone,
    this.follower = 0,
    this.following = 0,
    this.achievements = 0,
  });

  // Chuyển Profile thành Map để lưu trữ
  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "username": username,
      "name": name,
      "avatar": avatar,
      "birthday": birthday,
      "phone": phone,
      "follower": follower,
      "following": following,
      "achievements": achievements,
    };
  }

  // Tạo Profile từ Map
  static Profile fromMap(Map<String, dynamic> map) {
    return Profile(
      uuid: map["uuid"],
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      avatar: map['avatar'] ?? '',
      birthday: map['birthday'] ?? '',
      phone: map['phone'] ?? '',
      follower: map['follower'] ?? 0,
      following: map['following'] ?? 0,
      achievements: map['achievements'] ?? 0,
    );
  }

  // Factory method để tạo Profile trống
  factory Profile.empty(String uuid) {
    return Profile(
      uuid: uuid,
      username: "",
      name: "",
      avatar: "",
      birthday: "",
      phone: "",
      follower: 0,
      following: 0,
      achievements: 0,
    );
  }

  @override
  String toString() {
    return 'Profile{uuid: $uuid, username: $username, name: $name, avatar: $avatar, birthday: $birthday, phone: $phone, follower: $follower, following: $following, achievements: $achievements}';
  }
}
