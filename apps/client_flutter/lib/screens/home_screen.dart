import 'package:flutter/material.dart';

/// Home screen with quick actions and overview.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Welcome',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Card(
          child: ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Library'),
            subtitle: const Text('Browse your collection'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Library tab handles navigation via shell
            },
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Search'),
            subtitle: const Text('Find new books'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Search tab handles navigation via shell
            },
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text('Import by ISBN'),
            subtitle: const Text('Scan or type an ISBN'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // ISBN tab handles navigation via shell
            },
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Recent',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        const _EmptyRecent(),
      ],
    );
  }
}

class _EmptyRecent extends StatelessWidget {
  const _EmptyRecent();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.history,
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 8),
            Text(
              'No recent activity',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
