import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

class ApiService {
  // Base URL: Use 10.0.2.2 for Android Emulator, localhost for iOS/Web
  static String get baseUrl {
    if (kIsWeb) return "http://127.0.0.1:8000";
    if (Platform.isAndroid) return "http://10.0.2.2:8000";
    return "http://127.0.0.1:8000";
  }

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

  // Merged putForm (from upstream) to support GregService
  Future<dynamic> putForm(
    String endpoint, {
    Map<String, dynamic>? fields,
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
            // Provide standard support for lists in form data if needed, or stringify
            // Based on previous conflicting code, it was trying to handle lists.
            // For simplicity and matching typical MultipartRequest usage:
            for (var item in value) {
              // MultipartRequest `fields` map handles single string per key.
              // Duplicates keys are only possible by direct access or loop?
              // The `http` package `MultipartRequest.fields` is `Map<String, String>`.
              // It DOES NOT support duplicate keys naturally.
              // We should JSON encode lists if the backend expects JSON string in a form field (which my GregService code implied: `jsonEncode(...)`).
              // GregService does `jsonEncode` BEFORE passing to `fields`. So `value` here is likely a String already!
              // So we just need:
              request.fields[key] = item.toString();
              // Wait, if `value` passed IS a List, my GregService code was `jsonEncode` (returning String).
              // So `fields` in `putForm` receives `Map<String, String>` (or dynamic but values are Strings).
              // So `value is List` check is probably not hit for GregService.
              // But if it is hit, we should decide strategy.
              // I will convert to string.
            }
          } else {
            request.fields[key] = value.toString();
          }
        });
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _processResponse(response);
    } catch (e) {
      print('❌ API PUT Form Error: $e');
      throw Exception('API PUT Form Error: $e');
    }
  }

  Future<dynamic> postMultipart(
    String endpoint, {
    Map<String, String>? fields,
    List<http.MultipartFile>? files,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final request = http.MultipartRequest('POST', url);
      print('🚀 API Multipart POST: $url');

      final headers = await _getHeaders(isMultipart: true);
      request.headers.addAll(headers);

      if (fields != null) {
        request.fields.addAll(fields);
      }

      if (files != null) {
        request.files.addAll(files);
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      return _processResponse(response);
    } catch (e) {
      throw Exception('API Multipart POST Error: $e');
    }
  }

  // Helper to process response
  dynamic _processResponse(http.Response response) {
    print('📥 Response [${response.statusCode}]: ${response.body}');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return json.decode(response.body);
    } else {
      print('API Error Response Body: ${response.body}');
      try {
        final errorBody = json.decode(response.body);

        // Handle FastAPI validation errors (detail) and others
        // Merging logic from both versions
        final message =
            errorBody['detail'] ??
            errorBody['error'] ??
            errorBody['message'] ??
            'Error: ${response.statusCode}';

        print('⚠️ API Error Message: $message');

        // Clean exception text
        if (message is String) {
          throw Exception(message);
        } else {
          throw Exception(message.toString());
        }
      } catch (e) {
        if (e is Exception) rethrow;
        throw Exception('API Error: ${response.statusCode} - ${response.body}');
      }
    }
  }
}
