import 'package:treinamento_flutter/validation/dependencies/dependencies.dart';
import 'package:treinamento_flutter/validation/validators/validators.dart';

class ValidationBuilder {
  String? fieldName;
  List<FieldValidation> validations = [];

  ValidationBuilder._();

  static ValidationBuilder field(String fieldName) {
    final instance = ValidationBuilder._();
    instance.fieldName = fieldName;
    return instance;
  }

  ValidationBuilder required() {
    validations.add(RequireFieldValidation(fieldName!));
    return this;
  }

  ValidationBuilder email() {
    validations.add(EmailValidation(fieldName!));
    return this;
  }

  List<FieldValidation> build() => validations;
}
