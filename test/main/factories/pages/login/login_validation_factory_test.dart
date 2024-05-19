import 'package:test/test.dart';

import 'package:treinamento_flutter/validation/validators/validators.dart';
import 'package:treinamento_flutter/factories/factories.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeLoginValidation();

    expect(validations, [
      RequireFieldValidation('email'),
      EmailValidation('email'),
      RequireFieldValidation('password')
    ]);
  });
}
