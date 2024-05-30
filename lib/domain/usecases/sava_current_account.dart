import 'package:treinamento_flutter/domain/entities/entities.dart';

abstract class SaveCurrentAccount {
  Future<void> save(AccountEntity accountEntity);
}
