import 'dart:convert';
import 'package:flutter/foundation.dart';
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

      final encodedBody = body != null ? json.encode(body) : null;
      if (encodedBody != null) print('📦 Encoded JSON Body: $encodedBody');

      final response = await http.post(
        url,
        headers: headers,
        body: encodedBody,
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

  Future<dynamic> postUrlEncoded(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders();
      headers['Content-Type'] = 'application/x-www-form-urlencoded';

      debugPrint('🚀 API POST URL-Encoded: $url');
      debugPrint('📦 Headers: $headers');

      // Build body string supporting repeated keys for lists
      final List<String> parts = [];
      body.forEach((key, value) {
        if (value is List) {
          for (var item in value) {
            parts.add(
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(item.toString())}',
            );
          }
        } else if (value != null) {
          parts.add(
            '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(value.toString())}',
          );
        }
      });
      final bodyString = parts.join('&');
      debugPrint('📦 FINAL BODY SENT TO SERVER (POST): $bodyString');

      final response = await http.post(
        url,
        headers: headers,
        body: bodyString,
        encoding: Encoding.getByName('utf-8'),
      );
      return _processResponse(response);
    } catch (e) {
      print('❌ API POST URL-Encoded Error: $e');
      throw Exception('API POST URL-Encoded Error: $e');
    }
  }

  Future<dynamic> putUrlEncoded(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders();
      headers['Content-Type'] = 'application/x-www-form-urlencoded';

      debugPrint('🚀 API PUT URL-Encoded: $url');
      debugPrint('📦 Headers: $headers');

      // Build body string supporting repeated keys for lists
      final List<String> parts = [];
      body.forEach((key, value) {
        if (value is List) {
          for (var item in value) {
            parts.add(
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(item.toString())}',
            );
          }
        } else if (value != null) {
          parts.add(
            '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(value.toString())}',
          );
        }
      });
      final bodyString = parts.join('&');
      debugPrint('📦 FINAL BODY SENT TO SERVER: $bodyString');

      final response = await http.put(
        url,
        headers: headers,
        body: bodyString,
        encoding: Encoding.getByName('utf-8'),
      );
      return _processResponse(response);
    } catch (e) {
      print('❌ API PUT URL-Encoded Error: $e');
      throw Exception('API PUT URL-Encoded Error: $e');
    }
  }

  Future<dynamic> delete(String endpoint, {Map<String, dynamic>? body}) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders();
      headers['Content-Type'] = 'application/x-www-form-urlencoded';

      debugPrint('🚀 API PUT URL-Encoded: $url');
      debugPrint('📦 Headers: $headers');

      // Build body string supporting repeated keys for lists
      final List<String> parts = [];
      if (body != null) {
        body.forEach((key, value) {
          if (value is List) {
            for (var item in value) {
              parts.add(
                '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(item.toString())}',
              );
            }
          } else if (value != null) {
            parts.add(
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(value.toString())}',
            );
          }
        });
      }
      final bodyString = parts.join('&');
      debugPrint('📦 FINAL BODY SENT TO SERVER: $bodyString');

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

  Future<dynamic> postForm(
    String endpoint, {
    Map<String, dynamic>? fields,
    List<http.MultipartFile>? files,
  }) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final request = http.MultipartRequest('POST', url);
      print('🚀 API POST Form: $url');
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
      print('❌ API POST Form Error: $e');
      throw Exception('API POST Form Error: $e');
    }
  }

  Future<Uint8List> getBytes(String endpoint) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final headers = await _getHeaders();
      print('🚀 API GET BYTES: $url');

      final response = await http.get(url, headers: headers);
      
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response.bodyBytes;
      } else {
         _processResponse(response); // Will throw exception
         throw Exception('Failed to load bytes');
      }
    } catch (e) {
      print('❌ API GET BYTES Error: $e');
      throw Exception('API GET BYTES Error: $e');
    }
  }

  // Helper to process response
  dynamic _processResponse(http.Response response) {
    print('📥 Response [${response.statusCode}]: ${response.body}');
    
    // Handle 503 Service Unavailable globally
    if (response.statusCode == 503) {
      throw Exception('Servicio no disponible momentáneamente. Por favor intenta más tarde.');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      final decodedBody = response.body;
      dynamic decoded;
      try {
        decoded = json.decode(decodedBody);
      } catch (e) {
        print('⚠️ API Response is not valid JSON: $decodedBody');
        print('📥 RAW BODY: $decodedBody');
        throw Exception(
          'API Error (${response.statusCode}): Response is not valid JSON.',
        );
      }

      if (decoded is Map && decoded['success'] == false) {
        final message =
            decoded['error']?.toString() ??
            decoded['message']?.toString() ??
            'API Error: success=false';
        print('⚠️ API logical error: $message');
        throw Exception(message);
      }
      return decoded;
    } else {
      // Try to parse error message
      final errorBody = response.body;
      try {
        final decodedError = json.decode(errorBody);
        final message =
            decodedError['error']?.toString() ??
            decodedError['message']?.toString() ??
            decodedError['detail']?.toString() ??
            'Error: ${response.statusCode}';
        print('⚠️ API Error Message: $message');
        throw Exception(message);
      } catch (e) {
        print('⚠️ API Error Body is not valid JSON: $errorBody');
        throw Exception(
          'API Error (${response.statusCode}): ${errorBody.length > 200 ? "${errorBody.substring(0, 200)}..." : errorBody}',
        );
      }
    }
  }
}
