import 'package:e_commerce/core/database/api/api.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';

abstract class CategoriesService {
  static final _api = Api.getInstance();

  static Future<FakeHttpResponse> getCategories() {
    return _api.queryCategories();
  }
}
