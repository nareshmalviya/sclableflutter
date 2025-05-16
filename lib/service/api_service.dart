import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/user_model.dart';

class ApiService {
  Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users?page=1'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final users = (data['data'] as List).map((e) => User.fromJson(e)).toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
