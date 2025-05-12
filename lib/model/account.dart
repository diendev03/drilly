class Account {
  String uuid;
  String email;
  String password;
  String createAt;

  // Constructor with all properties
  Account({
    required this.uuid,
    required this.email,
    required this.password,
    required this.createAt,
  });

  Map<String, dynamic> toMap() {
    return {
      "uuid": uuid,
      "email": email,
      "password": password,
      "create_at": createAt,
    };
  }

  // Convert Map to Drillier
  static Account fromMap(Map<String, dynamic> map) {
    return Account(
        uuid: map["uuid"],
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        createAt: map['create_at'] ?? '');
  }

  factory Account.empty() {
    return Account(uuid: "", email: "", password: "", createAt: "");
  }
  @override
  String toString() {
    return 'Drillier{uuid: $uuid, email: $email, password: $password, createAt: $createAt}';
  }
}
