import '../dependencies/dependencies.dart';

class RequireFieldValidation implements FieldValidation {
  final String field;

  RequireFieldValidation(this.field);

  String? validate(String value) {
    return value.isNotEmpty ? null : 'Campo obrigatório.';
  }
}
