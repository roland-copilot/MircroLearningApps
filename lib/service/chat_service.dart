import 'package:dio/dio.dart';

class ChatService {
  final Dio _dio = Dio();
  final String _apiKey = 'sk-1bLJoJloDsZCgwz6WKG_cw';
  final String _endpoint = 'https://ai.sumopod.com/v1/chat/completions';

  Future<String> sendMessage(String message, {List<Map<String, String>> previousMessages = const []}) async {
    try {
      List<Map<String, String>> messages = List.from(previousMessages);
      messages.add({
        "role": "user",
        "content": message
      });

      final response = await _dio.post(
        _endpoint,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $_apiKey',
          },
        ),
        data: {
          "model": "gpt-4o-mini",
          "messages": messages,
          "temperature": 0.7
        },
      );

      if (response.statusCode == 200) {
        return response.data['choices'][0]['message']['content'];
      } else {
        return 'Error: ${response.statusMessage}';
      }
    } catch (e) {
      return 'Sorry, I encountered an error. Please try again.';
    }
  }
}
