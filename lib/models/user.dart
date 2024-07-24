class User {
  final String id;
  final String firstname;
  final String lastname;
  final String username;
  final String password;

  User({required this.id, required this.firstname, required this.lastname, required this.username, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'password': password,
    };
  }
}
