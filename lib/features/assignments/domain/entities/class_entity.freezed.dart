// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'class_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$ClassEntityTearOff {
  const _$ClassEntityTearOff();

  _ClassEntity call(
      {@nullable String id,
      @required String name,
      @required MaterialColor color,
      @required List<AssignmentEntity> assignments}) {
    return _ClassEntity(
      id: id,
      name: name,
      color: color,
      assignments: assignments,
    );
  }
}

// ignore: unused_element
const $ClassEntity = _$ClassEntityTearOff();

mixin _$ClassEntity {
  @nullable
  String get id;
  String get name;
  MaterialColor get color;
  List<AssignmentEntity> get assignments;

  $ClassEntityCopyWith<ClassEntity> get copyWith;
}

abstract class $ClassEntityCopyWith<$Res> {
  factory $ClassEntityCopyWith(
          ClassEntity value, $Res Function(ClassEntity) then) =
      _$ClassEntityCopyWithImpl<$Res>;
  $Res call(
      {@nullable String id,
      String name,
      MaterialColor color,
      List<AssignmentEntity> assignments});
}

class _$ClassEntityCopyWithImpl<$Res> implements $ClassEntityCopyWith<$Res> {
  _$ClassEntityCopyWithImpl(this._value, this._then);

  final ClassEntity _value;
  // ignore: unused_field
  final $Res Function(ClassEntity) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object color = freezed,
    Object assignments = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      color: color == freezed ? _value.color : color as MaterialColor,
      assignments: assignments == freezed
          ? _value.assignments
          : assignments as List<AssignmentEntity>,
    ));
  }
}

abstract class _$ClassEntityCopyWith<$Res>
    implements $ClassEntityCopyWith<$Res> {
  factory _$ClassEntityCopyWith(
          _ClassEntity value, $Res Function(_ClassEntity) then) =
      __$ClassEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {@nullable String id,
      String name,
      MaterialColor color,
      List<AssignmentEntity> assignments});
}

class __$ClassEntityCopyWithImpl<$Res> extends _$ClassEntityCopyWithImpl<$Res>
    implements _$ClassEntityCopyWith<$Res> {
  __$ClassEntityCopyWithImpl(
      _ClassEntity _value, $Res Function(_ClassEntity) _then)
      : super(_value, (v) => _then(v as _ClassEntity));

  @override
  _ClassEntity get _value => super._value as _ClassEntity;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object color = freezed,
    Object assignments = freezed,
  }) {
    return _then(_ClassEntity(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      color: color == freezed ? _value.color : color as MaterialColor,
      assignments: assignments == freezed
          ? _value.assignments
          : assignments as List<AssignmentEntity>,
    ));
  }
}

class _$_ClassEntity with DiagnosticableTreeMixin implements _ClassEntity {
  const _$_ClassEntity(
      {@nullable this.id,
      @required this.name,
      @required this.color,
      @required this.assignments})
      : assert(name != null),
        assert(color != null),
        assert(assignments != null);

  @override
  @nullable
  final String id;
  @override
  final String name;
  @override
  final MaterialColor color;
  @override
  final List<AssignmentEntity> assignments;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClassEntity(id: $id, name: $name, color: $color, assignments: $assignments)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClassEntity'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('assignments', assignments));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ClassEntity &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.assignments, assignments) ||
                const DeepCollectionEquality()
                    .equals(other.assignments, assignments)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(assignments);

  @override
  _$ClassEntityCopyWith<_ClassEntity> get copyWith =>
      __$ClassEntityCopyWithImpl<_ClassEntity>(this, _$identity);
}

abstract class _ClassEntity implements ClassEntity {
  const factory _ClassEntity(
      {@nullable String id,
      @required String name,
      @required MaterialColor color,
      @required List<AssignmentEntity> assignments}) = _$_ClassEntity;

  @override
  @nullable
  String get id;
  @override
  String get name;
  @override
  MaterialColor get color;
  @override
  List<AssignmentEntity> get assignments;
  @override
  _$ClassEntityCopyWith<_ClassEntity> get copyWith;
}
