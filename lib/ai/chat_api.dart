// import 'package:google_cloud_language/google_cloud_language.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatAPI {
  static const String apiKey = 'AIzaSyCG-t1hNRxsMaSsKrGIoyAtWzODNanlp94';
  static const String apiUrl = 'https://gemini.googleapis.com/v1/messages:sendMessage';

  static Future<String> sendMessage(String message) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['response'] ?? 'No response from API';
    } else {
      throw Exception('Failed to get response from API');
    }
  }
}
