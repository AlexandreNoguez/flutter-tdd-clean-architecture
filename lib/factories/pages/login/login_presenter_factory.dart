import 'package:treinamento_flutter/presentation/presenters/presenters.dart';
import 'package:treinamento_flutter/views/views.dart';
import 'package:treinamento_flutter/factories/factories.dart';

LoginPresenter makeLoginPresenter() {
  return StreamLoginPresenter(
      authentication: makeRemoteAuthentication(),
      validation: makeLoginValidation());
}
