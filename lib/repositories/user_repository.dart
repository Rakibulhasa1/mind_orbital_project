import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class UserRepository {
  final String baseUrl = "https://669666110312447373c26117.mockapi.io/users";

  Future<void> register(User user) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register user');
    }
  }

  Future<User> login(String username, String password) async {
    final response = await http.get(Uri.parse('$baseUrl?username=$username&password=$password'));

    if (response.statusCode == 200) {
      final List users = json.decode(response.body);
      if (users.isNotEmpty) {
        return User.fromJson(users[0]);
      } else {
        throw Exception('Invalid username or password');
      }
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> update(User user) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update user');
    }
  }
}
