import 'dart:convert';

import 'package:e_commerce/shared/dummy_data/api/api.dart';
import 'package:e_commerce/shared/local/prefs.dart';

abstract class AuthService {
  final _api = Api.getInstance();
}

abstract class AuthLocalService {
  static Map<String, dynamic> getUser() {
    return json.decode(Prefs.getData<String>(key: Prefs.userKey) ?? '{}');
  }
}
