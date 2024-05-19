import 'package:equatable/equatable.dart';

import '../dependencies/dependencies.dart';

class RequireFieldValidation extends Equatable implements FieldValidation {
  final String field;

  List get props => [field];

  RequireFieldValidation(this.field);

  String? validate(String value) {
    return value.isNotEmpty ? null : 'Campo obrigatório.';
  }
}
