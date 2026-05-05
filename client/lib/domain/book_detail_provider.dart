import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/api_provider.dart';
import '../data/models/book.dart';

final bookDetailProvider = FutureProvider.family<Book, int>((ref, id) async {
  final api = ref.watch(apiClientProvider);
  return api.getBook(id);
});
