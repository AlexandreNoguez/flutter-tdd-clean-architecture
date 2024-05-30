import 'package:get/get.dart';
import 'package:treinamento_flutter/domain/usecases/usecases.dart';
import 'package:treinamento_flutter/domain/helpers/helpers.dart';
import 'package:treinamento_flutter/views/login/login_presenter.dart';

import '../dependencies/dependencies.dart';

class GetxLoginPresenter extends GetxController implements LoginPresenter {
  late final Validation validation;
  late final Authentication authentication;

  String? _email;
  String? _password;

  var _emailError = RxString('');
  var _passwordError = RxString('');
  var _mainError = RxString('');
  var _isFormValid = false.obs;
  var _isLoading = false.obs;
  // Atributos para acessar o stream de erros
  @override
  Stream<String?> get emailErrorStream => _emailError.stream;

  @override
  Stream<String?> get passwordErrorStream => _passwordError.stream;

  @override
  Stream<String?> get mainErrorStream => _mainError.stream;

  @override
  Stream<bool> get isFormValidStream => _isFormValid.stream;

  @override
  Stream<bool> get isLoadingStream => _isLoading.stream;

  GetxLoginPresenter({required this.validation, required this.authentication});

  @override
  void validateEmail(String email) {
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: email)!;
    validateForm();
  }

  @override
  void validatePassword(String password) {
    _password = password;
    _passwordError.value =
        validation.validate(field: 'password', value: password)!;
    validateForm();
  }

  void validateForm() {
    _isFormValid.value = _emailError.value == null &&
        _passwordError.value == null &&
        _email != null &&
        _password != null;
  }

  @override
  Future<void> auth() async {
    _isLoading.value = true;
    try {
      await authentication
          .auth(AuthenticationParams(email: _email!, password: _password!));
    } on DomainError catch (error) {
      _mainError.value = error.description;
    } finally {
      _isLoading.value = false;
    }
  }

  @override
  void dispose() {}
}
