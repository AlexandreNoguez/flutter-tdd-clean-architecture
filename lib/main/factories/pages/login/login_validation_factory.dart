import 'package:treinamento_flutter/main/builders/builders.dart';
import 'package:treinamento_flutter/presentation/dependencies/dependencies.dart';
import 'package:treinamento_flutter/validation/dependencies/dependencies.dart';
import 'package:treinamento_flutter/validation/validators/validators.dart';

Validation makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().build()
  ];
}
