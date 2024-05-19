import 'package:treinamento_flutter/presentation/dependencies/dependencies.dart';
import 'package:treinamento_flutter/validation/dependencies/dependencies.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  String? validate({required String field, required String value}) {
    String? error;
    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(value);

      if (error?.isNotEmpty == true) {
        return error;
      }
    }
    return error;
  }
}
