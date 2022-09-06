class ExampleModel {
  final int id;

  ExampleModel.fromMap(Map<String, dynamic> map) : id = map['id'];

  static List<ExampleModel> parseList(List<Map<String, dynamic>> mappedList) {
    final result = <ExampleModel>[];

    for (final map in mappedList) {
      result.add(ExampleModel.fromMap(map));
    }

    return result;
  }
}
