import 'package:audiobookshelf/Utils/snakbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  final String serverUrl;
  final ThemeData theme;
  final Dio dio = Dio();
  ApiService({required this.serverUrl, required this.theme});

  Future<Map<String, dynamic>> _request(String method, String path,
      {Map<String, dynamic>? data}) async {
    try {
      Response response;

      if (method == 'GET') {
        response = await dio.get('$serverUrl/$path');
      } else if (method == 'POST') {
        response = await dio.post('$serverUrl/$path', data: data);
      } else {
        throw Exception('Unsupported method: $method');
      }

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        getErrorSnackbar("Error",
            response.statusMessage ?? "Internal Server Error!!!", theme);
        throw Exception('Something went wrong!');
      }
    } catch (e) {
      getErrorSnackbar("Error", e.toString(), theme);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> get(String path) async {
    return await _request('GET', path);
  }

  Future<Map<String, dynamic>> post(
      String path, Map<String, dynamic> data) async {
    return await _request('POST', path, data: data);
  }

  // make a get request and if theme is an error show using get snackbar
}
