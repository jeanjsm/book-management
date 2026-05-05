import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/api_provider.dart';
import '../data/models/book.dart';
import '../data/models/importer_dto.dart';

final searchCblProvider = FutureProvider.family<List<ImporterDto>, String>((ref, isbn) async {
  final api = ref.read(apiClientProvider);
  return api.searchCbl(isbn);
});

final searchSkoobProvider = FutureProvider.family<List<ImporterDto>, String>((ref, isbn) async {
  final api = ref.read(apiClientProvider);
  return api.searchSkoob(isbn);
});

final importBookProvider = FutureProvider.family<Book, ImportParams>((ref, params) async {
  final api = ref.read(apiClientProvider);
  return api.importBook(params.isbn, number: params.number);
});

class ImportParams {
  final String isbn;
  final int number;

  ImportParams({required this.isbn, this.number = 1});
}
