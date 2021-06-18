class UserPageModel {
  late String type;
  late String date;
  late double value;
  late String username;
  late String password;
  late String token;
  UserPageModel(
    this.type,
    this.value,
    this.date,
  );

  UserPageModel.fromJson(Map<String, dynamic> json) {
    type = json['tipo'] ?? '';
    date = json['data'] ?? '';
    value = json['valor'] ?? 0.0;
    username = json['username'] ?? '';
    password = json['password'] ?? '';
    token = json['token'] ?? '';
  }

  @override
  String toString() {
    return 'UserPageModel{type: $type, date: $date, value: $value, username: $username, password: $password, token: $token}';
  }
}
