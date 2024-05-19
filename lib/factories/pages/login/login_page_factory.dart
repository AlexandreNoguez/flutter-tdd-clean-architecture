import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:treinamento_flutter/data/usecases/usecases.dart';
import 'package:treinamento_flutter/infra/http/http.dart';
import 'package:treinamento_flutter/presentation/presenters/presenters.dart';
import 'package:treinamento_flutter/validation/validators/email_validation.dart';
import 'package:treinamento_flutter/validation/validators/required_field_validation.dart';
import 'package:treinamento_flutter/validation/validators/validation_composite.dart';
import 'package:treinamento_flutter/views/login/login_page.dart';

Widget makeLoginPage() {
  final url = 'http://localhost:3333/api';
  final client = Client();
  final httpAdapter = HttpAdapter(client);
  final remoteAuthentication =
      RemoteAuthentication(httpClient: httpAdapter, url: url);
  final validationComposite = ValidationComposite([
    RequireFieldValidation('email'),
    EmailValidation('email'),
    RequireFieldValidation('password')
  ]);
  final streamLoginPresenter = StreamLoginPresenter(
      authentication: remoteAuthentication, validation: validationComposite);
  return LoginPage(streamLoginPresenter);
}
