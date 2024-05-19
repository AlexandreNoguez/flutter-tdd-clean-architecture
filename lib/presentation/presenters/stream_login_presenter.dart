import 'dart:async';

import 'package:treinamento_flutter/domain/usecases/usecases.dart';
import 'package:treinamento_flutter/domain/helpers/helpers.dart';
import 'package:treinamento_flutter/views/login/login_presenter.dart';

import '../dependencies/dependencies.dart';

class LoginState {
  String? email;
  String? password;
  String? mainError;
  String? emailError;
  String? passwordError;
  bool isLoading = false;

  bool get isFormValid =>
      emailError == null &&
      passwordError == null &&
      email != null &&
      password != null;
}

class StreamLoginPresenter implements LoginPresenter {
  late final Validation validation;
  late final Authentication authentication;

  var _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  // Atributos para acessar o stream de erros
  @override
  Stream<String?> get emailErrorStream =>
      _controller.stream.map((state) => state.emailError).distinct();

  @override
  Stream<String?> get passwordErrorStream =>
      _controller.stream.map((state) => state.passwordError).distinct();

  @override
  Stream<String?> get mainErrorStream =>
      _controller.stream.map((state) => state.mainError).distinct();

  @override
  Stream<bool> get isFormValidStream =>
      _controller.stream.map((state) => state.isFormValid).distinct();

  @override
  Stream<bool> get isLoadingStream =>
      _controller.stream.map((state) => state.isLoading).distinct();

  StreamLoginPresenter(
      {required this.validation, required this.authentication});

  void _update() => _controller.add(_state);

  @override
  void validateEmail(String email) {
    _state.email = email;
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  @override
  void validatePassword(String password) {
    _state.password = password;
    _state.passwordError =
        validation.validate(field: 'password', value: password);
    _update();
  }

  @override
  Future<void> auth() async {
    _state.isLoading = true;
    _update();
    try {
      await authentication.auth(AuthenticationParams(
          email: _state.email!, password: _state.password!));
    } on DomainError catch (error) {
      _state.mainError = error.description;
    } finally {
      _state.isLoading = false;
      _update();
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
