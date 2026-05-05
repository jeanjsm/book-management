import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/import_provider.dart';
import '../../domain/book_list_provider.dart';

class ImportScreen extends ConsumerStatefulWidget {
  const ImportScreen({super.key});

  @override
  ConsumerState<ImportScreen> createState() => _ImportScreenState();
}

class _ImportScreenState extends ConsumerState<ImportScreen> {
  final _isbnCtrl = TextEditingController();
  final _numberCtrl = TextEditingController(text: '1');
  int _tab = 0;

  @override
  void dispose() {
    _isbnCtrl.dispose();
    _numberCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isbn = _isbnCtrl.text;
    final cblAsync = _tab == 0 && isbn.isNotEmpty ? ref.watch(searchCblProvider(isbn)) : null;
    final skoobAsync = _tab == 1 && isbn.isNotEmpty ? ref.watch(searchSkoobProvider(isbn)) : null;

    return Scaffold(
      appBar: AppBar(title: const Text('Import by ISBN')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _isbnCtrl,
                    decoration: const InputDecoration(
                      hintText: 'ISBN',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => setState(() {}),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _numberCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Nº',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => setState(() {}),
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
          SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('CBL')),
              ButtonSegment(value: 1, label: Text('Skoob')),
            ],
            selected: <int>{_tab},
            onSelectionChanged: (v) => setState(() => _tab = v.first),
          ),
          Expanded(
            child: _tab == 0
                ? (cblAsync?.when(
                      data: (results) => results.isEmpty
                          ? const Center(child: Text('No results found'))
                          : ListView.builder(
                              padding: const EdgeInsets.all(12),
                              itemCount: results.length,
                              itemBuilder: (_, i) {
                                final r = results[i];
                                return ListTile(
                                  leading: r.coverUrl != null
                                      ? Image.network(r.coverUrl!, width: 40, errorBuilder: (_, __, ___) => const Icon(Icons.book))
                                      : const Icon(Icons.book),
                                  title: Text(r.title),
                                  subtitle: Text(r.synopsis, maxLines: 2, overflow: TextOverflow.ellipsis),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.download),
                                    onPressed: () => _import(r.isbn),
                                  ),
                                );
                              },
                            ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, _) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Failed to search CBL. The external service may be unavailable. Please try again later.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ) ??
                    const Center(child: Text('Enter ISBN and tap Search')))
                : (skoobAsync?.when(
                      data: (results) => results.isEmpty
                          ? const Center(child: Text('No results found'))
                          : ListView.builder(
                              padding: const EdgeInsets.all(12),
                              itemCount: results.length,
                              itemBuilder: (_, i) {
                                final r = results[i];
                                return ListTile(
                                  leading: r.coverUrl != null
                                      ? Image.network(r.coverUrl!, width: 40, errorBuilder: (_, __, ___) => const Icon(Icons.book))
                                      : const Icon(Icons.book),
                                  title: Text(r.title),
                                  subtitle: Text(r.synopsis, maxLines: 2, overflow: TextOverflow.ellipsis),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.download),
                                    onPressed: () => _import(r.isbn),
                                  ),
                                );
                              },
                            ),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, _) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Failed to search Skoob. The external service may be unavailable. Please try again later.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ) ??
                    const Center(child: Text('Enter ISBN and tap Search'))),
          ),
        ],
      ),
    );
  }

  Future<void> _import(String isbn) async {
    final number = int.tryParse(_numberCtrl.text) ?? 1;
    await ref.read(importBookProvider(ImportParams(isbn: isbn, number: number)).future);
    ref.invalidate(bookListProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Book imported')));
      context.pop();
    }
  }
}
