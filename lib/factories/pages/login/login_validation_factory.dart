import 'package:treinamento_flutter/presentation/dependencies/dependencies.dart';
import 'package:treinamento_flutter/validation/dependencies/dependencies.dart';
import 'package:treinamento_flutter/validation/validators/validators.dart';

Validation makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    RequireFieldValidation('email'),
    EmailValidation('email'),
    RequireFieldValidation('password')
  ];
}
