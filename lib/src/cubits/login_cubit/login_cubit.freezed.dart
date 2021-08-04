// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'login_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$LoginStateTearOff {
  const _$LoginStateTearOff();

// ignore: unused_element
  LoginStateInitial initial() {
    return const LoginStateInitial();
  }

// ignore: unused_element
  LoginStateLoading loading() {
    return const LoginStateLoading();
  }

// ignore: unused_element
  LoginStateSuccess success() {
    return const LoginStateSuccess();
  }

// ignore: unused_element
  LoginStateFailure failure({String message}) {
    return LoginStateFailure(
      message: message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $LoginState = _$LoginStateTearOff();

/// @nodoc
mixin _$LoginState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult success(),
    @required TResult failure(String message),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult success(),
    TResult failure(String message),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(LoginStateInitial value),
    @required TResult loading(LoginStateLoading value),
    @required TResult success(LoginStateSuccess value),
    @required TResult failure(LoginStateFailure value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(LoginStateInitial value),
    TResult loading(LoginStateLoading value),
    TResult success(LoginStateSuccess value),
    TResult failure(LoginStateFailure value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res> implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  final LoginState _value;
  // ignore: unused_field
  final $Res Function(LoginState) _then;
}

/// @nodoc
abstract class $LoginStateInitialCopyWith<$Res> {
  factory $LoginStateInitialCopyWith(
          LoginStateInitial value, $Res Function(LoginStateInitial) then) =
      _$LoginStateInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoginStateInitialCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateInitialCopyWith<$Res> {
  _$LoginStateInitialCopyWithImpl(
      LoginStateInitial _value, $Res Function(LoginStateInitial) _then)
      : super(_value, (v) => _then(v as LoginStateInitial));

  @override
  LoginStateInitial get _value => super._value as LoginStateInitial;
}

/// @nodoc
class _$LoginStateInitial implements LoginStateInitial {
  const _$LoginStateInitial();

  @override
  String toString() {
    return 'LoginState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoginStateInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult success(),
    @required TResult failure(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(failure != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult success(),
    TResult failure(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(LoginStateInitial value),
    @required TResult loading(LoginStateLoading value),
    @required TResult success(LoginStateSuccess value),
    @required TResult failure(LoginStateFailure value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(failure != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(LoginStateInitial value),
    TResult loading(LoginStateLoading value),
    TResult success(LoginStateSuccess value),
    TResult failure(LoginStateFailure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class LoginStateInitial implements LoginState {
  const factory LoginStateInitial() = _$LoginStateInitial;
}

/// @nodoc
abstract class $LoginStateLoadingCopyWith<$Res> {
  factory $LoginStateLoadingCopyWith(
          LoginStateLoading value, $Res Function(LoginStateLoading) then) =
      _$LoginStateLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoginStateLoadingCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateLoadingCopyWith<$Res> {
  _$LoginStateLoadingCopyWithImpl(
      LoginStateLoading _value, $Res Function(LoginStateLoading) _then)
      : super(_value, (v) => _then(v as LoginStateLoading));

  @override
  LoginStateLoading get _value => super._value as LoginStateLoading;
}

/// @nodoc
class _$LoginStateLoading implements LoginStateLoading {
  const _$LoginStateLoading();

  @override
  String toString() {
    return 'LoginState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoginStateLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult success(),
    @required TResult failure(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(failure != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult success(),
    TResult failure(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(LoginStateInitial value),
    @required TResult loading(LoginStateLoading value),
    @required TResult success(LoginStateSuccess value),
    @required TResult failure(LoginStateFailure value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(failure != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(LoginStateInitial value),
    TResult loading(LoginStateLoading value),
    TResult success(LoginStateSuccess value),
    TResult failure(LoginStateFailure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoginStateLoading implements LoginState {
  const factory LoginStateLoading() = _$LoginStateLoading;
}

/// @nodoc
abstract class $LoginStateSuccessCopyWith<$Res> {
  factory $LoginStateSuccessCopyWith(
          LoginStateSuccess value, $Res Function(LoginStateSuccess) then) =
      _$LoginStateSuccessCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoginStateSuccessCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateSuccessCopyWith<$Res> {
  _$LoginStateSuccessCopyWithImpl(
      LoginStateSuccess _value, $Res Function(LoginStateSuccess) _then)
      : super(_value, (v) => _then(v as LoginStateSuccess));

  @override
  LoginStateSuccess get _value => super._value as LoginStateSuccess;
}

/// @nodoc
class _$LoginStateSuccess implements LoginStateSuccess {
  const _$LoginStateSuccess();

  @override
  String toString() {
    return 'LoginState.success()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is LoginStateSuccess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult success(),
    @required TResult failure(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(failure != null);
    return success();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult success(),
    TResult failure(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(LoginStateInitial value),
    @required TResult loading(LoginStateLoading value),
    @required TResult success(LoginStateSuccess value),
    @required TResult failure(LoginStateFailure value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(failure != null);
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(LoginStateInitial value),
    TResult loading(LoginStateLoading value),
    TResult success(LoginStateSuccess value),
    TResult failure(LoginStateFailure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class LoginStateSuccess implements LoginState {
  const factory LoginStateSuccess() = _$LoginStateSuccess;
}

/// @nodoc
abstract class $LoginStateFailureCopyWith<$Res> {
  factory $LoginStateFailureCopyWith(
          LoginStateFailure value, $Res Function(LoginStateFailure) then) =
      _$LoginStateFailureCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$LoginStateFailureCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateFailureCopyWith<$Res> {
  _$LoginStateFailureCopyWithImpl(
      LoginStateFailure _value, $Res Function(LoginStateFailure) _then)
      : super(_value, (v) => _then(v as LoginStateFailure));

  @override
  LoginStateFailure get _value => super._value as LoginStateFailure;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(LoginStateFailure(
      message: message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$LoginStateFailure implements LoginStateFailure {
  const _$LoginStateFailure({this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'LoginState.failure(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is LoginStateFailure &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $LoginStateFailureCopyWith<LoginStateFailure> get copyWith =>
      _$LoginStateFailureCopyWithImpl<LoginStateFailure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult success(),
    @required TResult failure(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(failure != null);
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult success(),
    TResult failure(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(LoginStateInitial value),
    @required TResult loading(LoginStateLoading value),
    @required TResult success(LoginStateSuccess value),
    @required TResult failure(LoginStateFailure value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(success != null);
    assert(failure != null);
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(LoginStateInitial value),
    TResult loading(LoginStateLoading value),
    TResult success(LoginStateSuccess value),
    TResult failure(LoginStateFailure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class LoginStateFailure implements LoginState {
  const factory LoginStateFailure({String message}) = _$LoginStateFailure;

  String get message;
  @JsonKey(ignore: true)
  $LoginStateFailureCopyWith<LoginStateFailure> get copyWith;
}
