class CategoryModel {
  final int id;
  final String name;

  CategoryModel.fromMap({required Map<String, dynamic> map})
      : id = map['id'] ?? -1,
        name = map['name'] ?? '' {
    if (id == -1 || name.isEmpty) {
      throw Exception();
    }
  }

  static List<CategoryModel> parseList(List<Map<String, dynamic>> list) {
    return list.map((map) => CategoryModel.fromMap(map: map)).toList();
  }
}
