import 'package:http/http.dart';

import 'package:treinamento_flutter/data/http/http.dart';
import 'package:treinamento_flutter/infra/http/http.dart';

HttpClient makeHttpAdapter() {
  final client = Client();
  return HttpAdapter(client);
}
