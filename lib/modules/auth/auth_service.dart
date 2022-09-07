import 'dart:convert';

import 'package:e_commerce/shared/dummy_data/api/api.dart';
import 'package:e_commerce/shared/local/prefs.dart';

class AuthService {
  final api = Api.getInstance();
}

class AuthLocalService {
  Map<String, dynamic> getUser() {
    return json.decode(Prefs.getData<String>(key: Prefs.userKey) ?? '{}');
  }
}
