// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bookmanagementclient/data/api_client.dart';
import 'package:bookmanagementclient/data/api_provider.dart';
import 'package:bookmanagementclient/data/models/book.dart';
import 'package:bookmanagementclient/main.dart';

class _FakeApiClient extends ApiClient {
  _FakeApiClient() : super(baseUrl: 'http://localhost');

  @override
  Future<List<Book>> getBooks({
    int page = 0,
    int size = 20,
    String sortBy = 'title',
    String sort = 'ASC',
    String? title,
  }) async {
    return [];
  }
}

void main() {
  testWidgets('App renders root screen', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [apiClientProvider.overrideWithValue(_FakeApiClient())],
        child: const MyApp(),
      ),
    );
    await tester.pump();

    expect(find.text('My Books'), findsOneWidget);
  });
}
