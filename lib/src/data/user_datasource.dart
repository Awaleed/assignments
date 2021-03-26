import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../init_injectable.dart';
import '../helpers/fake_data_generator.dart';
import '../models/user_model.dart';

const String userBoxName = 'userBox';
const String currentUserKey = 'currentUser';
UserModel get kUser => getIt<IUserLocalDataSource>().readUser();

abstract class IUserLocalDataSource {
  Future<void> saveUser(UserModel user);
  Future<void> updateUser(UserModel user);
  Future<void> removeUser();
  UserModel readUser();
}

@Singleton(as: IUserLocalDataSource)
class UserLocalDataSource extends IUserLocalDataSource {
  UserLocalDataSource() : box = Hive.box<UserModel>(userBoxName);

  final Box box;

  @override
  UserModel readUser() => FakeDataGenerator.userModel;

  @override
  Future<void> removeUser() {
    // TODO: implement removeUser
    throw UnimplementedError();
  }

  @override
  Future<void> saveUser(UserModel user) {
    // TODO: implement saveUser
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(UserModel user) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
