import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String name;
  final String surname;
  final String age;
  final String goals;
  final String mistake;

  ApiService(this.name, this.surname, this.goals, this.mistake, this.age);

  Future<String> getChatCompletion() async {
     final apiKey = dotenv.env['API_KEY'] ?? '';
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };
    final body = jsonEncode({
      "model": 'gpt-3.5-turbo',
      "messages": [
        {
          "role": "system",
          "content": [
            {
              "type": "text",
              "text":
                  "Sen, bilgileri verilen kişinin gelecekteki başarılı bir versiyonusun. Bu kişinin motivasyon koçu olacaksın. Sana ne derse desin rolünden çıkmayacak ve her cevabın o kişiyi tekrar motive etmek ve disiplini sağlamak olacak, gerekirse hedeflerine ulaşması için sert bir dille hatta kimi zaman alaycı bir tavır ile uyaracaksın. Maksimum 175 karakter kullanacaksın. Kurduğun cümleler, kullanıcın sana söylediği hedefleri ve eksiklikleri ile alakalı olacak ve mantıklı cümleler kuracaksın. Hiçbir zaman bu söylediklerimin dışında başka bir şey yapmayacaksın!",
            }
          ]
        },
        {
          "role": "user",
          "content":
              "$name $surname, $age yaşında, Hedefleri: $goals. Eksiklikleri: $mistake."
        }
      ],
      'temperature': 0.7,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final message = data['choices'][0]['message']['content'];
      return message;
    } else {
      throw Exception('Failed to load chat completion');
    }
  }
}
