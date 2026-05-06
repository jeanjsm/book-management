import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

export 'package:dio/dio.dart' show DioException, Response, RequestOptions;

/// Exceptiones specific to the JSMA API client.
abstract class ApiException implements Exception {
  const ApiException(this.message);
  final String message;
  @override
  String toString() => 'ApiException: $message';
}

class UnknownApiException extends ApiException {
  const UnknownApiException(super.message);
}

class NetworkException extends ApiException {
  const NetworkException(super.message);
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException(super.message);
}

class NotFoundException extends ApiException {
  const NotFoundException(super.message);
}

class ServerException extends ApiException {
  const ServerException(super.message);
}

class ValidationException extends ApiException {
  const ValidationException(super.message, {this.errors = const {}});
  final Map<String, List<String>> errors;
}

/// Configuration for [JsmaClient].
class ClientConfig {
  const ClientConfig({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 30),
    this.enableLogging = false,
  });

  final String baseUrl;
  final Duration timeout;
  final bool enableLogging;
}

/// JSMA API client backed by Dio.
class JsmaClient {
  JsmaClient({required ClientConfig config}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: config.timeout,
        receiveTimeout: config.timeout,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      ),
    );

    if (config.enableLogging) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (Object? o) {
            // ignore: avoid_print
            print('[JsmaClient] $o');
          },
        ),
      );
    }

    // Unified error handling interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException err, ErrorInterceptorHandler handler) {
          final status = err.response?.statusCode;
          final data = err.response?.data;
          final msg = _extractMessage(data) ?? err.message ?? 'Unknown error';

          if (err.type == DioExceptionType.connectionError ||
              err.type == DioExceptionType.connectionTimeout ||
              err.type == DioExceptionType.receiveTimeout) {
            handler.reject(
              DioException(
                requestOptions: err.requestOptions,
                error: NetworkException(msg),
              ),
            );
            return;
          }

          final exception = switch (status) {
            null => UnknownApiException(msg),
            401 || 403 => UnauthorizedException(msg),
            404 => NotFoundException(msg),
            422 => ValidationException(msg, errors: _extractValidationErrors(data)),
            >= 500 => ServerException(msg),
            _ => UnknownApiException(msg),
          };

          handler.reject(
            DioException(
              requestOptions: err.requestOptions,
              error: exception,
            ),
          );
        },
      ),
    );
  }

  late final Dio _dio;

  static String? _extractMessage(dynamic data) {
    if (data is Map<String, dynamic>) {
      final msg = data['message'] ?? data['error'] ?? data['detail'];
      if (msg is String) return msg;
    }
    return null;
  }

  static Map<String, List<String>> _extractValidationErrors(dynamic data) {
    if (data is Map<String, dynamic>) {
      final errors = data['errors'] ?? data['validation_errors'];
      if (errors is Map) {
        return errors.map(
          (k, v) => MapEntry(
            k.toString(),
            (v is List) ? v.cast<String>() : [v.toString()],
          ),
        );
      }
    }
    return const {};
  }

  /// Configure a bearer token for authenticated requests.
  void setAuthToken(String token) {
    _dio.options.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
  }

  /// Remove the bearer token.
  void clearAuthToken() {
    _dio.options.headers.remove(HttpHeaders.authorizationHeader);
  }

  /// Perform a GET request.
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _safeCall(() => _dio.get<T>(path, queryParameters: queryParameters, options: options));

  /// Perform a POST request.
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _safeCall(() => _dio.post<T>(path, data: data, queryParameters: queryParameters, options: options));

  /// Perform a PUT request.
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _safeCall(() => _dio.put<T>(path, data: data, queryParameters: queryParameters, options: options));

  /// Perform a PATCH request.
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _safeCall(() => _dio.patch<T>(path, data: data, queryParameters: queryParameters, options: options));

  /// Perform a DELETE request.
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) => _safeCall(() => _dio.delete<T>(path, data: data, queryParameters: queryParameters, options: options));

  Future<Response<T>> _safeCall<T>(Future<Response<T>> Function() call) async {
    try {
      return await call();
    } on DioException catch (e) {
      if (e.error is ApiException) rethrow;
      rethrow;
    }
  }
}
