import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  // Base URL from previous findings
  final String baseUrl = "https://connek-dev-aa5f5db19836.herokuapp.com";

  ApiService();

  Future<Map<String, String>> _getHeaders({bool isMultipart = false}) async {
    final session = Supabase.instance.client.auth.currentSession;
    final token = session?.accessToken;
    return {
      if (!isMultipart) 'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders();
      print('🚀 API GET: $url');

      final response = await http.get(url, headers: headers);
      return _processResponse(response);
    } catch (e) {
      print('❌ API GET Error: $e');
      throw Exception('API GET Error: $e');
    }
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders();
      print('🚀 API POST: $url');
      if (body != null) print('📦 Body: $body');

      final response = await http.post(
        url,
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );
      return _processResponse(response);
    } catch (e) {
      print('❌ API POST Error: $e');
      throw Exception('API POST Error: $e');
    }
  }

  Future<dynamic> put(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders();
      print('🚀 API PUT: $url');
      if (body != null) print('📦 Body: $body');

      final response = await http.put(
        url,
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );
      return _processResponse(response);
    } catch (e) {
      print('❌ API PUT Error: $e');
      throw Exception('API PUT Error: $e');
    }
  }

  Future<dynamic> delete(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders();
      print('🚀 API DELETE: $url');
      if (body != null) print('📦 Body: $body');

      final response = await http.delete(
        url,
        headers: headers,
        body: body != null ? json.encode(body) : null,
      );
      return _processResponse(response);
    } catch (e) {
      print('❌ API DELETE Error: $e');
      throw Exception('API DELETE Error: $e');
    }
  }

  Future<dynamic> putForm(
    String endpoint, {
    Map<String, dynamic>? fields,
    List<http.MultipartFile>? files,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final request = http.MultipartRequest('PUT', url);
      print('🚀 API PUT Form: $url');
      if (fields != null) print('📝 Fields: $fields');

      final headers = await _getHeaders(isMultipart: true);
      request.headers.addAll(headers);

      if (fields != null) {
        fields.forEach((key, value) {
          if (value is List) {
            for (var item in value) {
              request.fields[key] = item.toString();
            }
          } else {
            request.fields[key] = value.toString();
          }
        });
      }

      if (files != null) {
        request.files.addAll(files);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _processResponse(response);
    } catch (e) {
      print('❌ API PUT Form Error: $e');
      throw Exception('API PUT Form Error: $e');
    }
  }

  // Helper to process response
  dynamic _processResponse(http.Response response) {
    print('📥 Response [${response.statusCode}]: ${response.body}');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    } else {
      // Try to parse error message
      try {
        final errorBody = json.decode(response.body);
        final message =
            errorBody['error'] ??
            errorBody['message'] ??
            errorBody['detail'] ??
            'Error: ${response.statusCode}';
        print('⚠️ API Error Message: $message');
        throw Exception(message);
      } catch (e) {
        if (e is Exception) rethrow;
        throw Exception('API Error: ${response.statusCode}');
      }
    }
  }
}
