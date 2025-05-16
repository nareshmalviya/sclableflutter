
class User {
  final int id;
  final String email;
  final String firstName;
  final String avatar;

  User({required this.id, required this.email, required this.firstName, required this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      avatar: json['avatar'],
    );
  }
}
