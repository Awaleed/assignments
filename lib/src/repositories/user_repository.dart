import 'package:injectable/injectable.dart';

import '../data/user_datasource.dart';
import '../models/user_model.dart';

abstract class IUserRepository {
  UserModel getUser();
}

@Singleton(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  final IUserLocalDataSource _localSource;

  UserRepositoryImpl(this._localSource);

  @override
  UserModel getUser() => _localSource.readUser();
}
