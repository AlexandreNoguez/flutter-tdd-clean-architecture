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

  Future<Map> request(
      {@required String url, @required String method, Map body}) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };

    final jsonBody = body != null ? jsonEncode(body) : null;

    final response = await client.post(url, headers: headers, body: jsonBody);
    
    if(response.statusCode == 200){
      return response.body.isEmpty ? null : jsonDecode(response.body);
    }else{
      return null;
    }
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
    PostExpectation mockRequest() =>  
    when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers')));

    void mockResponse(int statusCode, {String body = '{"key":"value"}'}){
      mockRequest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp(() => {
     mockResponse(200)
    });
    test('Should call post with correct values', () async {
      await sut.request(url: url, method: 'post', body: {'key': 'value'});

      verify(client.post(url,
          headers: {
            'content-type': 'application/json',
            'accept': 'application/json',
          },
          body: '{"key":"value"}'));
    });

    test('Should call post without body', () async {
      await sut.request(url: url, method: 'post');

      verify(client.post(any, headers: anyNamed('headers')));
    });

    test('Should return data if post status code 200', () async {
      final response = await sut.request(url: url, method: 'post');

      expect(response, {'key': 'value'});
    });

    test('Should return null if post status code 200 with no data', () async {
      mockResponse(200, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
    
    test('Should return null if post status code 204', () async {
      mockResponse(204, body: '');

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
    
    test('Should return null if post status code 204 with no body', () async {
      mockResponse(204);

      final response = await sut.request(url: url, method: 'post');

      expect(response, null);
    });
  });
}
