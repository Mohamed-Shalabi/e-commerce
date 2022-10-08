class UserModel {
  final int id;
  final String name, email, password, phone, country, city, address;

  static late UserModel? _instance;

  factory UserModel.getInstance() => _instance!;

  static void init(Map<String, dynamic> map) {
    _instance = UserModel._fromMap(map);
  }

  UserModel._fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        email = map['email'],
        password = map['password'],
        phone = map['phone'],
        country = map['country'],
        city = map['city'],
        address = map['address'];
}
