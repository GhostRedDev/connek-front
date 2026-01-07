import 'dart:convert';
import 'package:http/http.dart' as http;

class SupabaseConfig {
  final String url;
  final String anonKey;

  SupabaseConfig({required this.url, required this.anonKey});

  static Future<SupabaseConfig> fetch(String backendUrl) async {
    try {
      final response = await http.get(Uri.parse('$backendUrl/config/supabase'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return SupabaseConfig(
          url: data['url'],
          anonKey: data['key'],
        );
      } else {
        throw Exception('Failed to load Supabase config: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching Supabase config: $e');
    }
  }
}
