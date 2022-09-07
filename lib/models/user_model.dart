class UserModel {
  final String name, email, password, phone, country, city, address;

  UserModel.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        email = map['email'],
        password = map['password'],
        phone = map['phone'],
        country = map['country'],
        city = map['city'],
        address = map['address'];
}
