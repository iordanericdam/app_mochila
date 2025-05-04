class User {
  final String name;
  final String email;
  final String token;
  final String? url_photo;

  User(
      {required this.name,
      required this.email,
      required this.token,
      this.url_photo});

  String get user_name {
    return name;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        token: json['token'],
        name: json['name'],
        email: json['email'],
        url_photo: json['url_photo']);
  }

  Map<String, dynamic> toJson() =>
      {'token': token, 'name': name, 'email': email, 'url_photo': url_photo};

  @override
  String toString() {
    return 'User{name: $name, email: $email,token:$token,url_photo:$url_photo}';
  }
}
