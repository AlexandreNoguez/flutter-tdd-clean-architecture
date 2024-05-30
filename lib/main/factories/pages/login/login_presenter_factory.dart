import 'package:treinamento_flutter/presentation/presenters/presenters.dart';
import 'package:treinamento_flutter/views/views.dart';
import 'package:treinamento_flutter/main/factories/factories.dart';

LoginPresenter makeStreamLoginPresenter() {
  return StreamLoginPresenter(
      authentication: makeRemoteAuthentication(),
      validation: makeLoginValidation());
}

LoginPresenter makeGetxLoginPresenter() {
  return StreamLoginPresenter(
      authentication: makeRemoteAuthentication(),
      validation: makeLoginValidation());
}
