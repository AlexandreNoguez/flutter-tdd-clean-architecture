// import 'package:faker/faker.dart';
// import 'package:http/http.dart';
// import 'package:mockito/mockito.dart';
// import 'package:test/test.dart';

// import 'package:treinamento_flutter/data/http/http.dart';
// import 'package:treinamento_flutter/infra/http/http.dart';

// class ClientSpy extends Mock implements Client {}

// void main() {
//   HttpAdapter sut;
//   ClientSpy client;
//   String url;

//   setUp(() => {
//         client = ClientSpy(),
//         sut = HttpAdapter(client),
//         url = faker.internet.httpUrl()
//       });

//   group('shared', (){
//     test('Should throw server error if invalid method is providade', ()async{
//       final response = sut.request(url: url, method: 'invalid_method');
//       expect(response, throwsA(HttpError.serverError));
//     });
//   });

//   group('post', () {
//     PostExpectation mockRequest() =>  
//     when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers')));

//     void mockResponse(int statusCode, {String body = '{"key":"value"}'}){
//       mockRequest().thenAnswer((_) async => Response(body, statusCode));
//     }
    
//     void mockError(){
//       mockRequest().thenThrow(Exception());
//     }

//     setUp(() => {
//      mockResponse(200)
//     });
//     test('Should call post with correct values', () async {
//       await sut.request(url: url, method: 'post', body: {'key': 'value'});

//       verify(client.post(url,
//           headers: {
//             'content-type': 'application/json',
//             'accept': 'application/json',
//           },
//           body: '{"key":"value"}'));
//     });

//     test('Should call post without body', () async {
//       await sut.request(url: url, method: 'post');

//       verify(client.post(any, headers: anyNamed('headers')));
//     });

//     test('Should return data if post status code 200', () async {
//       final response = await sut.request(url: url, method: 'post');

//       expect(response, {'key': 'value'});
//     });

//     test('Should return null if post status code 200 with no data', () async {
//       mockResponse(200, body: '');

//       final response = await sut.request(url: url, method: 'post');

//       expect(response, null);
//     });
    
//     test('Should return null if post status code 204', () async {
//       mockResponse(204, body: '');

//       final response = await sut.request(url: url, method: 'post');

//       expect(response, null);
//     });
    
//     test('Should return null if post status code 204 with no body', () async {
//       mockResponse(204);

//       final response = await sut.request(url: url, method: 'post');

//       expect(response, null);
//     });
    
//     test('Should return bad request error if post status code 400', () async {
//       mockResponse(400);

//       final response = sut.request(url: url, method: 'post');

//       expect(response, throwsA(HttpError.badRequest));
//     });
    
//     test('Should return bad request error if post status code 400 with empty body', () async {
//       mockResponse(400, body: '');

//       final response = sut.request(url: url, method: 'post');

//       expect(response, throwsA(HttpError.badRequest));
//     });
    
//     test('Should return unauthorized error if post status code 401', () async {
//       mockResponse(401);

//       final response = sut.request(url: url, method: 'post');

//       expect(response, throwsA(HttpError.unauthorized));
//     });

//     test('Should return forbidden error if post status code 403', () async {
//       mockResponse(403);

//       final response = sut.request(url: url, method: 'post');

//       expect(response, throwsA(HttpError.forbidden));
//     });

//     test('Should return not found error if post status code 404', () async {
//       mockResponse(404);

//       final response = sut.request(url: url, method: 'post');

//       expect(response, throwsA(HttpError.notFound));
//     });

//     test('Should return server error if post status code 500', () async {
//       mockResponse(500);

//       final response = sut.request(url: url, method: 'post');

//       expect(response, throwsA(HttpError.serverError));
//     });
    
//     test('Should return server error if post throws', () async {
//       mockError();

//       final response = sut.request(url: url, method: 'post');

//       expect(response, throwsA(HttpError.serverError));
//     });
//   });
// }
