import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/api_provider.dart';
import '../data/models/book.dart';

final bookListProvider = FutureProvider.family<List<Book>, BookListParams>((ref, params) async {
  final api = ref.watch(apiClientProvider);
  return api.getBooks(
    page: params.page,
    size: params.size,
    sortBy: params.sortBy,
    sort: params.sort,
    title: params.title,
  );
});

final bookSearchProvider = StateProvider<String>((ref) => '');

class BookListParams {
  final int page;
  final int size;
  final String sortBy;
  final String sort;
  final String? title;

  BookListParams({
    this.page = 0,
    this.size = 20,
    this.sortBy = 'title',
    this.sort = 'ASC',
    this.title,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookListParams &&
          runtimeType == other.runtimeType &&
          page == other.page &&
          size == other.size &&
          sortBy == other.sortBy &&
          sort == other.sort &&
          title == other.title;

  @override
  int get hashCode => page.hashCode ^ size.hashCode ^ sortBy.hashCode ^ sort.hashCode ^ title.hashCode;
}
