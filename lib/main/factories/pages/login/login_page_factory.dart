import 'package:flutter/material.dart';
import 'package:treinamento_flutter/main/factories/factories.dart';
import 'package:treinamento_flutter/views/login/login_page.dart';

Widget makeLoginPage() {
  return LoginPage(makeGetxLoginPresenter());
}
