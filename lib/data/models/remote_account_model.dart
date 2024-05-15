import 'package:meta/meta.dart';
import '../../domain/entities/entities.dart';

import '../http/http.dart';

class RemoteAccountModel {
  final String accessToken;
  final String name;

  RemoteAccountModel({@required this.accessToken, @required this.name});

  factory RemoteAccountModel.fromJson(Map json) {
    if (!json.containsKey('accessToken')) {
      throw HttpError.forbidden;
    }
    return RemoteAccountModel(
      accessToken: json['accessToken'] ?? '',
      name: json['name'] ?? '',
    );
  }

  AccountEntity toEntity() {
    return AccountEntity(accessToken);
  }
}
