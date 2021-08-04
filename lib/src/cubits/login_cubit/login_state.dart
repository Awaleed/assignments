part of 'login_cubit.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginStateInitial;
  const factory LoginState.loading() = LoginStateLoading;
  const factory LoginState.success() = LoginStateSuccess;
  const factory LoginState.failure({String message}) = LoginStateFailure;
}
