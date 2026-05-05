import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/book_detail_provider.dart';
import '../../domain/book_actions_provider.dart';
import '../../domain/book_list_provider.dart';

class BookDetailScreen extends ConsumerWidget {
  final int id;

  const BookDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookAsync = ref.watch(bookDetailProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/book/$id/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Delete book?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
                  ],
                ),
              );
              if (confirm == true) {
                await ref.read(deleteBookProvider(id).future);
                ref.invalidate(bookListProvider(BookListParams()));
                if (context.mounted) context.pop();
              }
            },
          ),
        ],
      ),
      body: bookAsync.when(
        data: (book) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (book.coverUrl != null && book.coverUrl!.isNotEmpty)
                Center(
                  child: CachedNetworkImage(
                    imageUrl: book.coverUrl!,
                    height: 240,
                    fit: BoxFit.contain,
                    placeholder: (_, __) => const SizedBox(height: 240, child: Center(child: CircularProgressIndicator())),
                    errorWidget: (_, __, ___) => const SizedBox(height: 240, child: Center(child: Icon(Icons.broken_image))),
                  ),
                ),
              const SizedBox(height: 16),
              Text(book.title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('Author: ${book.author}', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Text('Number: ${book.number}'),
              const SizedBox(height: 8),
              Text('Paid: R\$ ${book.paidPrice}'),
              const SizedBox(height: 4),
              Text('Label: R\$ ${book.labelPrice}'),
              if (book.barcode != null) ...[
                const SizedBox(height: 8),
                Text('Barcode: ${book.barcode}'),
              ],
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
