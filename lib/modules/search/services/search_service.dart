import 'package:e_commerce/core/database/api/api.dart';
import 'package:e_commerce/core/database/fake_http_response.dart';

abstract class SearchService {
  static final _api = Api.getInstance();

  static Future<FakeHttpResponse> searchForProducts(String searchTerm) {
    return _api.searchForProducts(searchTerm);
  }
}
