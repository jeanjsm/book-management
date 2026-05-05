import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/api_provider.dart';
import '../data/models/book.dart';

final createBookProvider = FutureProvider.family<Book, Book>((ref, book) async {
  final api = ref.read(apiClientProvider);
  return api.createBook(book);
});

final updateBookProvider = FutureProvider.family<Book, UpdateParams>((ref, params) async {
  final api = ref.read(apiClientProvider);
  return api.updateBook(params.id, title: params.title, author: params.author, number: params.number);
});

final deleteBookProvider = FutureProvider.family<void, int>((ref, id) async {
  final api = ref.read(apiClientProvider);
  return api.deleteBook(id);
});

class UpdateParams {
  final int id;
  final String? title;
  final String? author;
  final int? number;

  UpdateParams({required this.id, this.title, this.author, this.number});
}
