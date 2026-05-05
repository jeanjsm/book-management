import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/book_list_screen.dart';
import 'screens/book_detail_screen.dart';
import 'screens/book_form_screen.dart';
import 'screens/import_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const BookListScreen(),
    ),
    GoRoute(
      path: '/book/new',
      builder: (context, state) => const BookFormScreen(),
    ),
    GoRoute(
      path: '/book/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BookDetailScreen(id: id);
      },
    ),
    GoRoute(
      path: '/book/:id/edit',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BookFormScreen(id: id);
      },
    ),
    GoRoute(
      path: '/import',
      builder: (context, state) => const ImportScreen(),
    ),
  ],
);
