import 'dart:convert';

extension ToJson on String {
  dynamic get toJson => json.decode(this);
}