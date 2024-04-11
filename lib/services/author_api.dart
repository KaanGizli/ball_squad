import 'package:dio/dio.dart';

class AuthorApi {
  final Dio _dio = Dio();

  Future<dynamic> searchAuthor(String authorName) async {
    try {
      final response = await _dio.get('https://openlibrary.org/search/authors.json?q=$authorName');
      return response.data;
    } catch (error) {
      print(error);
      throw Exception('Failed to load author');
    }
  }
}
