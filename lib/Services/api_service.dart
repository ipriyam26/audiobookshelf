import 'package:dio/dio.dart';

class ApiService {
  final String serverUrl;
  final Dio dio = Dio();
  ApiService({required this.serverUrl});

  Future<String> get(String path) async {
    try {
      final response = await dio.get('$serverUrl/$path');
      return response.data.toString();
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> post(String path, Map<String, dynamic> data) async {
    try {
      final response = await dio.post('$serverUrl/$path', data: data);
      return response.data.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
