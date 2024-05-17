import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:treinamento_flutter/views/login/login_page.dart';
import 'package:treinamento_flutter/views/login/login_presenter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    final primaryColor = Color.fromRGBO(33, 150, 243, 1);
    final primaryColorDark = Color.fromRGBO(21, 101, 192, 1);
    final primaryColorLight = Color.fromRGBO(144, 202, 249, 1);

    return MaterialApp(
      title: 'Treinamento Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: primaryColorDark,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColorLight),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          alignLabelWithHint: true,
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(primary: primaryColor),
          buttonColor: primaryColor,
          splashColor: primaryColorLight,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: LoginPage(DummyLoginPresenter()),
    );
  }
}

class DummyLoginPresenter implements LoginPresenter {
  @override
  Stream<String> get emailErrorStream => Stream.empty();

  @override
  Stream<String> get mainErrorStream => Stream.empty();

  @override
  Stream<String> get passwordErrorStream => Stream.empty();

  @override
  Stream<bool> get isFormValidStream => Stream.empty();

  @override
  Stream<bool> get isLoadingStream => Stream.empty();

  @override
  Future<void> auth() async {}

  @override
  void dispose() {}

  @override
  void validateEmail(String email) {}

  @override
  void validatePassword(String password) {}
}
