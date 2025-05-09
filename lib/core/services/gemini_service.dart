import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final GenerativeModel _model;

  GeminiService()
      : _model = GenerativeModel(
          model: 'gemini-1.5-pro',
          apiKey: 'AIzaSyBSI5I4pUp8o1vJ5WjJLuDLyE8bhSFcso4',
        );

  Future<Map<String, dynamic>?> processCommand(String userInput) async {
    try {
      final prompt = '''
You are a smart task assistant. A user will give you a natural language command.

Your job is to:
1. Identify the intent: one of "create", "delete", or "edit"
2. Extract the title and description.
3. Extract datetime (if only time is given, use today’s date. If only date is given, use current time. If none, use DateTime.now()).
4. Respond ONLY in JSON format like this:

{
  "intent": "create",
  "title": "Buy Milk",
  "description": "Buy milk from the store",
  "datetime": "2025-05-09T17:00:00"
}

User Input: "$userInput"
''';

      final response = await _model.generateContent([Content.text(prompt)]);
      final jsonString = response.text?.trim();

      if (jsonString == null) return null;

      final json = jsonDecode(jsonString);
      return json;
    } catch (e) {
      print('Gemini Parsing Error: $e');
      return null;
    }
  }
}
