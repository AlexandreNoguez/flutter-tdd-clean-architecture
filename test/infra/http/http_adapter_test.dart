import 'package:meta/meta.dart';
import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../../../lib/data/http/http_client.dart';

class ClientSpy extends Mock implements Client {}

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Response> request(
      {@required String url, @required String method, Map body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };

    final jsonBody = body != null ? jsonEncode(body) : null;

    final response = await client.post(url, headers: headers, body: jsonBody);
    return response.body.isEmpty ? null : jsonDecode(response.body);
  }
}

void main() {
  HttpAdapter sut;
  ClientSpy client;
  String url;

  setUp(() => {
        client = ClientSpy(),
        sut = HttpAdapter(client),
        url = faker.internet.httpUrl()
      });
  group('post', () {
    PostExpectation mockRequest() =>  when(client.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')));
    setUp(() =>{
      when(client.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"key":"value"}', 200))
    });
    test('Should call post with correct values', () async {
      when(client.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"key":"value"}', 200));

      await sut.request(url: url, method: 'post', body: {'key': 'value'});

      verify(client.post(url,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
          },
          body: '{"key":"value"}'));
    });

    test('Should call post without body', () async {
      when(client.post(any,
              body: anyNamed('body'), headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"key":"value"}', 200));

      await sut.request(url: url, method: 'post');

      verify(client.post(url: url, body: anyNamed('body'), headers: anyNamed('headers')));
    });

    test('Should return data if post status code 200', () async {
      when(client.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"key":"value"}', 200));

      final response = await sut.request(url: url, method: 'post');

      expect(response, {'key': 'value'});
    });

    test('Should return null if post status code 200 with no data', () async {
      when(client.post(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('', 200));

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
  });
}
