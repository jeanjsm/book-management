import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_providers.dart';

/// Detail screen for a book/item.
class DetailScreen extends StatefulWidget {
  const DetailScreen({required this.id, super.key});

  final String id;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DetailProvider>().loadDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DetailProvider>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: _buildBody(state),
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
                  'Failed to load details',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  state.errorMessage ?? 'Unknown error',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<DetailProvider>().loadDetail(widget.id),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      case AppStatus.success:
        final data = state.data?.toString() ?? '';
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 16),
              Text(
                'ID: ${widget.id}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        );
      case AppStatus.idle:
      case AppStatus.empty:
        return const SizedBox.shrink();
    }
  }
}
