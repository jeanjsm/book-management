import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:jsma_app/main.dart';
import 'package:jsma_app/providers/app_providers.dart';
import 'package:jsma_app/screens/search_screen.dart';
import 'package:jsma_app/screens/library_screen.dart';
import 'package:jsma_app/screens/isbn_import_screen.dart';

void main() {
  testWidgets('AppShell renders without error on wide screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(800, 600)),
        child: _buildApp(),
      ),
    );
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(NavigationRail), findsOneWidget);
    expect(find.text('Welcome'), findsOneWidget);
  });

  testWidgets('AppShell renders BottomNavigationBar on narrow screen', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(size: Size(400, 600)),
        child: _buildApp(),
      ),
    );
    expect(find.byType(Scaffold), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.text('Welcome'), findsOneWidget);
  });

  testWidgets('SearchScreen shows idle state with TextField', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider(
            create: (_) => SearchProvider(),
            child: const SearchScreen(),
          ),
        ),
      ),
    );
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Type a query and press search'), findsOneWidget);
  });

  testWidgets('SearchScreen performs search and shows results', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider(
            create: (_) => SearchProvider(),
            child: const SearchScreen(),
          ),
        ),
      ),
    );
    await tester.enterText(find.byType(TextField), 'flutter');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Flutter in Action'), findsOneWidget);
    expect(find.text('Flutter Cookbook'), findsOneWidget);
  });

  testWidgets('LibraryScreen shows loading then empty', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider(
            create: (_) => LibraryProvider(),
            child: const LibraryScreen(),
          ),
        ),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Your library is empty'), findsOneWidget);
  });

  testWidgets('IsbnImportScreen renders and validates empty ISBN', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ChangeNotifierProvider(
            create: (_) => IsbnImportProvider(),
            child: const IsbnImportScreen(),
          ),
        ),
      ),
    );
    expect(find.byType(TextField), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Import'), findsOneWidget);
    await tester.tap(find.widgetWithText(ElevatedButton, 'Import'));
    await tester.pumpAndSettle();
    expect(find.text('ISBN cannot be empty'), findsOneWidget);
  });
}

Widget _buildApp() {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SearchProvider()),
      ChangeNotifierProvider(create: (_) => LibraryProvider()),
      ChangeNotifierProvider(create: (_) => DetailProvider()),
      ChangeNotifierProvider(create: (_) => IsbnImportProvider()),
    ],
    child: const JsmaApp(),
  );
}
