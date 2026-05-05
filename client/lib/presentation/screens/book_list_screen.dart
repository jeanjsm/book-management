import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/book_list_provider.dart';
import '../widgets/book_card.dart';

class BookListScreen extends ConsumerStatefulWidget {
  const BookListScreen({super.key});

  @override
  ConsumerState<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends ConsumerState<BookListScreen> {
  final _searchController = TextEditingController();
  int _page = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final search = ref.watch(bookSearchProvider);
    final booksAsync = ref.watch(bookListProvider(
      BookListParams(page: _page, title: search.isEmpty ? null : search),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Books'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => context.push('/import'),
            tooltip: 'Import',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by title...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: search.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(bookSearchProvider.notifier).state = '';
                        },
                      )
                    : null,
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => ref.read(bookSearchProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child: booksAsync.when(
              data: (books) {
                if (books.isEmpty) {
                  return const Center(child: Text('No books found'));
                }
                return RefreshIndicator(
                  onRefresh: () async => ref.invalidate(bookListProvider),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: books.length,
                    itemBuilder: (_, index) {
                      final book = books[index];
                      return BookCard(
                        book: book,
                        onTap: () => context.push('/book/${book.id}'),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Center(
                child: Text(
                  err is FormatException
                      ? 'Unexpected response format from the server'
                      : 'Failed to load books',
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/book/new'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
