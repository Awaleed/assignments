import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../data/user_datasource.dart';
import '../models/user_model.dart';

abstract class IUserRepository {
  UserModel getUser();
  Future saveUser([UserModel user]);
}

@Singleton(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  final IUserLocalDataSource _localSource;

  UserRepositoryImpl(this._localSource);

  @override
  UserModel getUser() => _localSource.readUser();
  @override
  Future saveUser([UserModel user]) async {
    if (user == null) {
      final newUser = await GoogleSignIn.standard().signIn();
      _localSource.saveUser(UserModel.fromGoogleSignIn(newUser));
    } else {
      _localSource.saveUser(user);
    }
  }
}
