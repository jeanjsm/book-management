import 'package:flutter/foundation.dart';

enum AppStatus { idle, loading, success, empty, error }

class AppState {
  const AppState({
    required this.status,
    this.data,
    this.errorMessage,
  });

  final AppStatus status;
  final dynamic data;
  final String? errorMessage;

  AppState copyWith({
    AppStatus? status,
    dynamic data,
    String? errorMessage,
  }) {
    return AppState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class SearchProvider extends ChangeNotifier {
  AppState _state = const AppState(status: AppStatus.idle);
  AppState get state => _state;

  String _query = '';
  String get query => _query;

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      _state = const AppState(status: AppStatus.idle);
      _query = '';
      notifyListeners();
      return;
    }

    _query = query;
    _state = const AppState(status: AppStatus.loading);
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      final results = <String>[];
      if (query.toLowerCase().contains('flutter')) {
        results.addAll(['Flutter in Action', 'Flutter Cookbook']);
      }

      if (results.isEmpty) {
        _state = const AppState(status: AppStatus.empty);
      } else {
        _state = AppState(status: AppStatus.success, data: results);
      }
      notifyListeners();
    } catch (e) {
      _state = AppState(status: AppStatus.error, errorMessage: e.toString());
      notifyListeners();
    }
  }
}

class LibraryProvider extends ChangeNotifier {
  AppState _state = const AppState(status: AppStatus.loading);
  AppState get state => _state;

  Future<void> load() async {
    _state = const AppState(status: AppStatus.loading);
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      final items = <String>[];
      if (items.isEmpty) {
        _state = const AppState(status: AppStatus.empty);
      } else {
        _state = AppState(status: AppStatus.success, data: items);
      }
      notifyListeners();
    } catch (e) {
      _state = AppState(status: AppStatus.error, errorMessage: e.toString());
      notifyListeners();
    }
  }
}

class DetailProvider extends ChangeNotifier {
  AppState _state = const AppState(status: AppStatus.idle);
  AppState get state => _state;

  Future<void> loadDetail(String id) async {
    _state = const AppState(status: AppStatus.loading);
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _state = AppState(status: AppStatus.success, data: 'Detail for $id');
      notifyListeners();
    } catch (e) {
      _state = AppState(status: AppStatus.error, errorMessage: e.toString());
      notifyListeners();
    }
  }
}

class IsbnImportProvider extends ChangeNotifier {
  AppState _state = const AppState(status: AppStatus.idle);
  AppState get state => _state;

  Future<void> import(String isbn) async {
    if (isbn.trim().isEmpty) {
        _state = const AppState(status: AppStatus.error, errorMessage: 'ISBN cannot be empty');
      notifyListeners();
      return;
    }

    _state = const AppState(status: AppStatus.loading);
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      _state = AppState(status: AppStatus.success, data: 'Imported $isbn');
      notifyListeners();
    } catch (e) {
      _state = AppState(status: AppStatus.error, errorMessage: e.toString());
      notifyListeners();
    }
  }
}
