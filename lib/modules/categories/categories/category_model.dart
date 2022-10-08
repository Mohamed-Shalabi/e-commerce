class CategoryModel {
  final int id;
  final String name;

  CategoryModel.fromMap({required Map<String, dynamic> map})
      : id = map['id'],
        name = map['name'];

  static List<CategoryModel> parseList(List<Map<String, dynamic>> list) {
    return list.map((map) => CategoryModel.fromMap(map: map)).toList();
  }
}
