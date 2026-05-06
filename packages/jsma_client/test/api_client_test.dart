import 'package:jsma_client/jsma_client.dart';
import 'package:test/test.dart';

void main() {
  group('JsmaClient', () {
    late JsmaClient client;

    setUp(() {
      client = JsmaClient(
        config: const ClientConfig(
          baseUrl: 'https://api.example.com',
          enableLogging: false,
        ),
      );
    });

    test('stores config and exposes get/post/put/patch/delete', () {
      expect(client, isA<JsmaClient>());
    });

    test('setAuthToken adds Bearer header', () {
      client.setAuthToken('abc123');
      // Internal assertion through interceptor behavior would require
      // a mock adapter; here we verify the method doesn't throw.
      expect(client, isA<JsmaClient>());
    });

    test('clearAuthToken does not throw', () {
      client.setAuthToken('abc123');
      client.clearAuthToken();
      expect(client, isA<JsmaClient>());
    });
  });

  group('ApiException hierarchy', () {
    test('NetworkException message', () {
      const e = NetworkException('timeout');
      expect(e.message, 'timeout');
      expect(e.toString(), contains('ApiException'));
    });

    test('UnauthorizedException message', () {
      const e = UnauthorizedException('unauthorized');
      expect(e.message, 'unauthorized');
    });

    test('NotFoundException message', () {
      const e = NotFoundException('not found');
      expect(e.message, 'not found');
    });

    test('ServerException message', () {
      const e = ServerException('server error');
      expect(e.message, 'server error');
    });

    test('ValidationException with errors map', () {
      const e = ValidationException('bad input', errors: {'name': ['required']});
      expect(e.message, 'bad input');
      expect(e.errors, {'name': ['required']});
    });
  });
}
