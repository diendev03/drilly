class Profile {
  String uuid;
  String name;
  String avatar;
  String birthday;
  String phone;
  int follower;
  int following;
  int achievements;

  Profile({
    required this.uuid,
    required this.name,
    required this.avatar,
    required this.birthday,
    required this.phone,
    this.follower = 0,
    this.following = 0,
    this.achievements = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "name": name,
      "avatar": avatar,
      "birthday": birthday,
      "phone": phone,
      "follower": follower,
      "following": following,
      "achievements": achievements,
    };
  }

  static Profile fromMap(Map<String, dynamic> map) {
    return Profile(
      uuid: map["uuid"],
      name: map['name'] ?? '',
      avatar: map['avatar'] ?? '',
      birthday: map['birthday'] ?? '',
      phone: map['phone'] ?? '',
      follower: map['follower'] ?? 0,
      following: map['following'] ?? 0,
      achievements: map['achievements'] ?? 0,
    );
  }

  factory Profile.empty({
    String uuid = "",
    String name = "",
    String avatar = "",
    String birthday = "",
    String phone = "",
    int follower = 0,
    int following = 0,
    int achievements = 0,
  }) {
    return Profile(
      uuid: uuid,
      name: name,
      avatar: avatar,
      birthday: birthday,
      phone: phone,
      follower: follower,
      following: following,
      achievements: achievements,
    );
  }

  @override
  String toString() {
    return 'Profile{uuid: $uuid, name: $name, avatar: $avatar, birthday: $birthday, phone: $phone, follower: $follower, following: $following, achievements: $achievements}';
  }
}
