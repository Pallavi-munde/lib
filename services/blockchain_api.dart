import 'dart:convert';
import 'package:http/http.dart' as http;

class BlockchainApi {
  static const baseUrl = 'http://localhost:8080';

  static Future<List<dynamic>> fetchProjects() async {
    final res = await http.get(Uri.parse('$baseUrl/projects'));
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> mintCredit(int amount) async {
    final res = await http.post(
      Uri.parse('$baseUrl/mint-credit'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'amount': amount}),
    );
    return jsonDecode(res.body);
  }
}