import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  const UserModel({
    this.name,
    this.email,
    this.phone,
    this.password,
    this.image,
    this.id,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String phone;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String image;
  @HiveField(5)
  final String email;
}
