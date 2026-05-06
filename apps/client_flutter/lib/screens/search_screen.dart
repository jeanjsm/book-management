import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_providers.dart';
import 'detail_screen.dart';

/// Search screen with query and results.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _controller.text.trim();
    context.read<SearchProvider>().search(query);
  }

  void _goToDetail(String title) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DetailScreen(id: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SearchProvider>();
    final state = provider.state;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search books...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  context.read<SearchProvider>().search('');
                },
              ),
              border: const OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _performSearch(),
          ),
        ),
        Expanded(child: _buildBody(state)),
      ],
    );
  }

  Widget _buildBody(AppState state) {
    switch (state.status) {
      case AppStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case AppStatus.error:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Search failed',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  state.errorMessage ?? 'Unknown error',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _performSearch,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      case AppStatus.idle:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search,
                  size: 48,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  'Type a query and press search',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        );
      case AppStatus.empty:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.search_off,
                  size: 48,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  'No results found',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ),
          ),
        );
      case AppStatus.success:
        final results = state.data as List<dynamic>? ?? [];
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final item = results[index].toString();
            return ListTile(
              title: Text(item),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _goToDetail(item),
            );
          },
        );
    }
  }
}
