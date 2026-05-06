import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_providers.dart';

/// ISBN import screen.
class IsbnImportScreen extends StatefulWidget {
  const IsbnImportScreen({super.key});

  @override
  State<IsbnImportScreen> createState() => _IsbnImportScreenState();
}

class _IsbnImportScreenState extends State<IsbnImportScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _import() {
    final isbn = _controller.text.trim();
    context.read<IsbnImportProvider>().import(isbn);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<IsbnImportProvider>().state;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'ISBN',
              hintText: 'Enter or scan an ISBN',
              prefixIcon: const Icon(Icons.qr_code),
              errorText: state.status == AppStatus.error
                  ? (state.errorMessage ?? 'Invalid input')
                  : null,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _import(),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: state.status == AppStatus.loading ? null : _import,
            icon: state.status == AppStatus.loading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.download),
            label: Text(state.status == AppStatus.loading ? 'Importing...' : 'Import'),
          ),
          if (state.status == AppStatus.success && state.data != null) ...[
            const SizedBox(height: 24),
            Card(
              child: ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: Text(state.data.toString()),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
