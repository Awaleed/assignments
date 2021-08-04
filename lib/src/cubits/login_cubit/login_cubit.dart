import 'package:assignments/src/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import '../../../init_injectable.dart';
import '../../../main.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._userRepository) : super(const LoginState.initial());

  final IUserRepository _userRepository;

  Future login(Map<String, dynamic> credentials) async {
    emit(const LoginState.loading());
    try {
      await _userRepository.saveUser();
      emit(const LoginState.success());
      // getIt<AuthCubit>().authenticateUser();
    } catch (e) {
      // emit(LoginState.failure(message: Helpers.mapErrorToMessage(e)));
    }
  }

  // Future signup(Map<String, dynamic> credentials) async {
  //   emit(const LoginState.loading());
  //   try {
  //     // final sig = await SmsAutoFill().getAppSignature;
  //     // await _authRepository.signup({...credentials, 'device_id': sig});
  //     emit(const LoginState.success());
  //     // getIt<AuthCubit>().authenticateUser();
  //   } catch (e) {
  //     // emit(LoginState.failure(message: Helpers.mapErrorToMessage(e)));
  //   }
  // }
}
