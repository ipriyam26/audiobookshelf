import 'dart:convert';

import 'package:audiobookshelf/Utils/snakbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

class ApiService {
  static final ApiService _singleton = ApiService._internal();
  static bool _isInitialized = false;

  late String serverUrl;
  late ThemeData theme;
  final Dio dio = Dio();
  String? authToken; // Optional token for authenticated requests
  ApiService._internal();

  static ApiService initialize(
      {required String serverUrl, required ThemeData theme}) {
    if (!_isInitialized) {
      _singleton.serverUrl = serverUrl;
      _singleton.theme = theme;
      _isInitialized = true;
    }
    return _singleton;
  }

  void setAuthToken(String token) {
    authToken = token;
  }

  // Future<ThemeData> getTheme() async {
  //   final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
  //   final themeJson = await jsonDecode(themeStr);
  //   final theme = ThemeDecoder.decodeThemeData(themeJson)!;
  //   return theme;
  // }

  factory ApiService() {
    if (!_isInitialized) {
      throw Exception(
          'ApiService must be initialized first!, Initalize using ApiService.initialize()`');
    }
    return _singleton;
  }
  // ApiService({required this.serverUrl, required this.theme, this.authToken});

  Future<Map<String, dynamic>> _request(String method, String path,
      {Map<String, dynamic>? data, bool isAuth = false}) async {
    try {
      Response response;
      final options = Options(
        headers: isAuth
            ? {'Authorization': 'Bearer $authToken'}
            : null, // Add the header if isAuth is true
      );

      if (method == 'GET') {
        response = await dio.get('$serverUrl/$path', options: options);
      } else if (method == 'POST') {
        response =
            await dio.post('$serverUrl/$path', data: data, options: options);
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

  Future<Map<String, dynamic>> authenticatedGet(String path) async {
    if (authToken == null) {
      throw Exception('No token found!, Use setAuthToken() to set the token');
    }
    return await _request('GET', path, isAuth: true);
  }

  Future<Map<String, dynamic>> authenticatedPost(
      String path, Map<String, dynamic> data) async {
    if (authToken == null) {
      throw Exception('No token found!, Use setAuthToken() to set the token');
    }
    return await _request('POST', path, data: data, isAuth: true);
  }

  // make a get request and if theme is an error show using get snackbar
}
