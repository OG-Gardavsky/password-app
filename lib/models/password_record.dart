class PasswordRecord {
  final String id;
  final String name;
  final String userName;
  final String password;

  PasswordRecord({
    required this.id,
    required this.name,
    required this.userName,
    required this.password,
  });

  factory PasswordRecord.fromJson(Map<String, dynamic> json) {
    return PasswordRecord(
      id: json['id'],
      name: json['name'],
      userName: json['userName'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'userName': userName,
      'password': password,
    };
  }
}
