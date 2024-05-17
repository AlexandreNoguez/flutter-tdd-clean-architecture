// import 'dart:async';

// import 'package:faker/faker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// import 'package:treinamento_flutter/views/views.dart';

// class LoginPresenterSpy extends Mock implements LoginPresenter {}

// void main() {
//   LoginPresenter presenter = LoginPresenterSpy();
//   StreamController<String> emailErrorController = StreamController<String>();
//   StreamController<String> passwordErrorController = StreamController<String>();
//   StreamController<String> mainErrorController = StreamController<String>();
//   StreamController<bool> isFormValidController = StreamController<bool>();
//   StreamController<bool> isLoadingController = StreamController<bool>();

//   void initStreams() {
//     emailErrorController = StreamController<String>();
//     passwordErrorController = StreamController<String>();
//     mainErrorController = StreamController<String>();
//     isFormValidController = StreamController<bool>();
//     isLoadingController = StreamController<bool>();
//   }

//   void mockStreams() {
//     when(presenter.emailErrorStream)
//         .thenAnswer((_) => emailErrorController.stream);
//     when(presenter.passwordErrorStream)
//         .thenAnswer((_) => passwordErrorController.stream);
//     when(presenter.isFormValidStream)
//         .thenAnswer((_) => isFormValidController.stream);
//     when(presenter.isLoadingStream)
//         .thenAnswer((_) => isLoadingController.stream);
//     when(presenter.mainErrorStream)
//         .thenAnswer((_) => mainErrorController.stream);
//   }

//   void closeStreams() {
//     emailErrorController.close();
//     passwordErrorController.close();
//     isFormValidController.close();
//     isLoadingController.close();
//     mainErrorController.close();
//   }

//   Future<void> loadPage(WidgetTester widgetTester) async {
//     presenter = LoginPresenterSpy();

//     initStreams();
//     mockStreams();

//     final loginPage = MaterialApp(home: LoginPage(presenter));
//     await widgetTester.pumpWidget(loginPage);
//   }

//   tearDown(() {
//     closeStreams();
//   });

//   testWidgets('Should load with correct initial state',
//       (WidgetTester widgetTester) async {
//     await loadPage(widgetTester);

//     final emailTextChildren = find.descendant(
//         of: find.bySemanticsLabel('E-mail'), matching: find.byType(Text));
//     expect(emailTextChildren, findsOneWidget);

//     final passwordTextChildren = find.descendant(
//         of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
//     expect(passwordTextChildren, findsOneWidget);

//     final button =
//         widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton));
//     expect(button.onPressed, null);
//     expect(find.byType(CircularProgressIndicator), findsNothing);
//   });

//   testWidgets(
//       'Should call validateEmail and validatePassword with correct values',
//       (WidgetTester widgetTester) async {
//     await loadPage(widgetTester);

//     final email = faker.internet.email();
//     await widgetTester.enterText(find.bySemanticsLabel('E-mail'), email);
//     verify(presenter.validateEmail(email)).called(1);

//     final password = faker.internet.password();
//     await widgetTester.enterText(find.bySemanticsLabel('Senha'), password);
//     verify(presenter.validatePassword(password)).called(1);
//   });

//   testWidgets('Should throw error with invalid wrong e-mail format',
//       (WidgetTester widgetTester) async {
//     await loadPage(widgetTester);

//     emailErrorController.add('Invalid e-mail format');
//     await widgetTester.pump();

//     expect(find.text('Invalid e-mail format'), findsOneWidget);
//   });

//   testWidgets('Should present no error if e-mail is valid',
//       (WidgetTester widgetTester) async {
//     await loadPage(widgetTester);

//     emailErrorController.add('');
//     await widgetTester.pump();

//     final passwordTextChildren = find.descendant(
//         of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
//     expect(passwordTextChildren, findsOneWidget);
//   });

//   testWidgets('Shoudl enable button if form is valid', (widgetTester) async {
//     await loadPage(widgetTester);

//     isFormValidController.add(true);

//     await widgetTester.pump();

//     final button =
//         widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton));
//     expect(button.onPressed, isNotNull);
//   });

//   testWidgets('Shoudl enable button if form is valid', (widgetTester) async {
//     await loadPage(widgetTester);

//     isFormValidController.add(false);

//     await widgetTester.pump();

//     final button =
//         widgetTester.widget<ElevatedButton>(find.byType(ElevatedButton));
//     expect(button.onPressed, null);
//   });

//   testWidgets('Shoudl enable button if form is valid', (widgetTester) async {
//     await loadPage(widgetTester);

//     isFormValidController.add(true);

//     await widgetTester.pump();

//     await widgetTester.tap(ElevatedButton as FinderBase<Element>);

//     await widgetTester.pump();

//     verify(presenter.auth()).called(1);
//   });
//   testWidgets('Should present loading', (widgetTester) async {
//     await loadPage(widgetTester);

//     isLoadingController.add(true);

//     await widgetTester.pump();
//     await widgetTester.tap(ElevatedButton as FinderBase<Element>);
//     await widgetTester.pump();

//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });

//   testWidgets('Should hide loading', (widgetTester) async {
//     await loadPage(widgetTester);

//     isLoadingController.add(true);
//     await widgetTester.pump();
//     isLoadingController.add(false);
//     await widgetTester.pump();

//     await widgetTester.tap(ElevatedButton as FinderBase<Element>);
//     await widgetTester.pump();

//     expect(find.byType(CircularProgressIndicator), findsNothing);
//   });

//   testWidgets('Should present error message if login failed',
//       (widgetTester) async {
//     await loadPage(widgetTester);

//     mainErrorController.add('main error');
//     await widgetTester.pump();

//     await widgetTester.tap(ElevatedButton as FinderBase<Element>);
//     await widgetTester.pump();

//     expect(find.text('in error'), findsOneWidget);
//   });

//   testWidgets('Should close streams on dispose', (widgetTester) async {
//     await loadPage(widgetTester);

//     addTearDown(() {
//       verify(presenter.dispose()).called(1);
//     });
//   });
// }
