// import 'dart:async';

// import 'package:treinamento_flutter/domain/usecases/authentication.dart';

// import '../dependencies/dependencies.dart';

// class LoginState {
//   String? email;
//   String? password;
//   String? emailError;
//   String? passwordError;
//   bool get isFormValid =>
//       emailError == null &&
//       passwordError == null &&
//       email != null &&
//       password != null;
// }

// class StreamLoginPresenter {
//   final Validation validation;
//   final Authenticaton authenticaton;
//   final _controller = StreamController<LoginState>.broadcast();

//   var _state = LoginState();

//   // Atributos para acessar o stream de erros
//   Stream<String?> get emailErrorStream =>
//       _controller.stream.map((state) => state.emailError).distinct();
//   Stream<String?> get passwordErrorStream =>
//       _controller.stream.map((state) => state.passwordError).distinct();
//   Stream<bool> get isFormValidStream =>
//       _controller.stream.map((state) => state.isFormValid).distinct();

//   StreamLoginPresenter({required this.validation, required this.authenticaton});

//   void _update() => _controller.add(_state);

//   void validateEmail(String email) {
//     _state.email = email;
//     _state.emailError = validation.validate(field: 'email', value: email);
//     _update();
//   }

//   void validatePassword(String password) {
//     _state.password = password;
//     _state.passwordError =
//         validation.validate(field: 'password', value: password);
//     _update();
//   }

//   Furute<void> auth() async {
//     if (_state.email != null && _state.password != null) {
//       await authenticaton.auth(
//           AuthenticationParams(email: _state.email, password: _state.password));
//     }
//   }

//   void dispose() {
//     _controller.close();
//   }
// }
