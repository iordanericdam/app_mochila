class User {
  final String name;
  final String email;
  final String token;

  User({
    required this.name,
    required this.email,
    required this.token,
  });

  String get user_name {
    return name;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        'token': token,
        'name': name,
        'email': email,
      };

  @override
  String toString() {
    return 'User{name: $name, email: $email,token:$token}';
  }
}
