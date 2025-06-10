import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://192.168.1.139:3000';

  static Future<bool> registerUser(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        print('Registration successful: ${response.body}');
        return true;
      } else {
        print('Registration failed: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Registration error: $e');
      return false;
    }
  }

  static Future<Map<String, dynamic>> loginUser(
    String emailOrPhone,
    String password,
  ) async {
    try {
      print('Attempting login with:');
      print('Email/Phone: "$emailOrPhone"');
      print('Password: "$password"');

      final response = await http.post(
        Uri.parse('$baseUrl/users/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'emailOrPhone': emailOrPhone.trim(),
          'password': password.trim(),
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final responseData = jsonDecode(response.body);

      // Accept 200 or 201 as success
      if (response.statusCode == 200 || response.statusCode == 201) {
        final userData =
            responseData['data']['user']['_doc'] ??
            responseData['data']['user'];
        return {
          'success': true,
          'user': userData,
          'message': responseData['data']['message'] ?? 'Login successful',
        };
      } else {
        return {
          'success': false,
          'error':
              responseData['error'] ??
              responseData['message'] ??
              'Login failed with status ${response.statusCode}',
        };
      }
    } catch (e) {
      print('Login error: $e');
      return {'success': false, 'error': 'Network error: ${e.toString()}'};
    }
  }
}
