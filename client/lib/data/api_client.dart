import 'package:dio/dio.dart';
import 'models/book.dart';
import 'models/importer_dto.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({String baseUrl = 'http://localhost:8080'}) : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  Future<List<Book>> getBooks({
    int page = 0,
    int size = 20,
    String sortBy = 'title',
    String sort = 'ASC',
    String? title,
  }) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/v1/book',
      queryParameters: {
        'page': page,
        'size': size,
        'sortBy': sortBy,
        'sort': sort,
        if (title != null && title.isNotEmpty) 'title': title,
      },
    );
    final content = response.data?['content'];
    if (content is! List) {
      throw const FormatException('Invalid book list response: missing content array');
    }

    return content
        .whereType<Map>()
        .map((e) => Book.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<Book> getBook(int id) async {
    final response = await _dio.get<Map<String, dynamic>>('/v1/book/$id');
    return Book.fromJson(response.data!);
  }

  Future<Book> createBook(Book book) async {
    final response = await _dio.post<Map<String, dynamic>>('/v1/book', data: book.toJson());
    return Book.fromJson(response.data!);
  }

  Future<Book> updateBook(int id, {String? title, String? author, int? number}) async {
    final response = await _dio.patch<Map<String, dynamic>>(
      '/v1/book/$id',
      data: {
        if (title != null) 'title': title,
        if (author != null) 'author': author,
        if (number != null) 'number': number,
      },
    );
    return Book.fromJson(response.data!);
  }

  Future<void> deleteBook(int id) async {
    await _dio.delete('/v1/book/$id');
  }

  Future<List<ImporterDto>> searchCbl(String isbn) async {
    final response = await _dio.get<List<dynamic>>('/import/cbl/$isbn');
    return (response.data ?? []).map((e) => ImporterDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<ImporterDto>> searchSkoob(String isbn) async {
    final response = await _dio.get<List<dynamic>>('/import/skoob/$isbn');
    return (response.data ?? []).map((e) => ImporterDto.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Book> importBook(String isbn, {int number = 1}) async {
    final response = await _dio.post<Map<String, dynamic>>(
      '/import/import/$isbn',
      queryParameters: {'number': number},
    );
    return Book.fromJson(response.data!);
  }

  Future<String> getImageUrl(String isbn) async {
    final response = await _dio.get<String>('/import/image/$isbn');
    return response.data ?? '';
  }
}
