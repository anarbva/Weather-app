import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather_app/core/app_constants/text/api_data.dart';

import 'package:weather_app/core/services/models/result.dart';

class HttpServices {
  static Future<Result> get({required String endpoint}) async {
    final Uri uri = Uri.parse('${ApiData.url}$endpoint&appId=${ApiData.apiKey}');

    try {
      final http.Response response = await http.get(uri);
      log('response.body: ${response.statusCode}');
      log('response.body: ${response.body}');
      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      switch (response.statusCode) {
        case 200:
          return Success(data: data);

        default:
          return Failure(error: data['message'], statusCode: data['cod']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}