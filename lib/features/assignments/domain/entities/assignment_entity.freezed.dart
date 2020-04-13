// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'assignment_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$AssignmentEntityTearOff {
  const _$AssignmentEntityTearOff();

  _AssignmentEntity call(
      {@required String id,
      @required AssignmentType type,
      @required String name,
      @nullable ClassEntity classEntity,
      @required DateTime dueDate,
      @required String notes,
      @required bool completed}) {
    return _AssignmentEntity(
      id: id,
      type: type,
      name: name,
      classEntity: classEntity,
      dueDate: dueDate,
      notes: notes,
      completed: completed,
    );
  }
}

// ignore: unused_element
const $AssignmentEntity = _$AssignmentEntityTearOff();

mixin _$AssignmentEntity {
  String get id;
  AssignmentType get type;
  String get name;
  @nullable
  ClassEntity get classEntity;
  DateTime get dueDate;
  String get notes;
  bool get completed;

  $AssignmentEntityCopyWith<AssignmentEntity> get copyWith;
}

abstract class $AssignmentEntityCopyWith<$Res> {
  factory $AssignmentEntityCopyWith(
          AssignmentEntity value, $Res Function(AssignmentEntity) then) =
      _$AssignmentEntityCopyWithImpl<$Res>;
  $Res call(
      {String id,
      AssignmentType type,
      String name,
      @nullable ClassEntity classEntity,
      DateTime dueDate,
      String notes,
      bool completed});

  $ClassEntityCopyWith<$Res> get classEntity;
}

class _$AssignmentEntityCopyWithImpl<$Res>
    implements $AssignmentEntityCopyWith<$Res> {
  _$AssignmentEntityCopyWithImpl(this._value, this._then);

  final AssignmentEntity _value;
  // ignore: unused_field
  final $Res Function(AssignmentEntity) _then;

  @override
  $Res call({
    Object id = freezed,
    Object type = freezed,
    Object name = freezed,
    Object classEntity = freezed,
    Object dueDate = freezed,
    Object notes = freezed,
    Object completed = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      type: type == freezed ? _value.type : type as AssignmentType,
      name: name == freezed ? _value.name : name as String,
      classEntity: classEntity == freezed
          ? _value.classEntity
          : classEntity as ClassEntity,
      dueDate: dueDate == freezed ? _value.dueDate : dueDate as DateTime,
      notes: notes == freezed ? _value.notes : notes as String,
      completed: completed == freezed ? _value.completed : completed as bool,
    ));
  }

  @override
  $ClassEntityCopyWith<$Res> get classEntity {
    if (_value.classEntity == null) {
      return null;
    }
    return $ClassEntityCopyWith<$Res>(_value.classEntity, (value) {
      return _then(_value.copyWith(classEntity: value));
    });
  }
}

abstract class _$AssignmentEntityCopyWith<$Res>
    implements $AssignmentEntityCopyWith<$Res> {
  factory _$AssignmentEntityCopyWith(
          _AssignmentEntity value, $Res Function(_AssignmentEntity) then) =
      __$AssignmentEntityCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      AssignmentType type,
      String name,
      @nullable ClassEntity classEntity,
      DateTime dueDate,
      String notes,
      bool completed});

  @override
  $ClassEntityCopyWith<$Res> get classEntity;
}

class __$AssignmentEntityCopyWithImpl<$Res>
    extends _$AssignmentEntityCopyWithImpl<$Res>
    implements _$AssignmentEntityCopyWith<$Res> {
  __$AssignmentEntityCopyWithImpl(
      _AssignmentEntity _value, $Res Function(_AssignmentEntity) _then)
      : super(_value, (v) => _then(v as _AssignmentEntity));

  @override
  _AssignmentEntity get _value => super._value as _AssignmentEntity;

  @override
  $Res call({
    Object id = freezed,
    Object type = freezed,
    Object name = freezed,
    Object classEntity = freezed,
    Object dueDate = freezed,
    Object notes = freezed,
    Object completed = freezed,
  }) {
    return _then(_AssignmentEntity(
      id: id == freezed ? _value.id : id as String,
      type: type == freezed ? _value.type : type as AssignmentType,
      name: name == freezed ? _value.name : name as String,
      classEntity: classEntity == freezed
          ? _value.classEntity
          : classEntity as ClassEntity,
      dueDate: dueDate == freezed ? _value.dueDate : dueDate as DateTime,
      notes: notes == freezed ? _value.notes : notes as String,
      completed: completed == freezed ? _value.completed : completed as bool,
    ));
  }
}

class _$_AssignmentEntity
    with DiagnosticableTreeMixin
    implements _AssignmentEntity {
  const _$_AssignmentEntity(
      {@required this.id,
      @required this.type,
      @required this.name,
      @nullable this.classEntity,
      @required this.dueDate,
      @required this.notes,
      @required this.completed})
      : assert(id != null),
        assert(type != null),
        assert(name != null),
        assert(dueDate != null),
        assert(notes != null),
        assert(completed != null);

  @override
  final String id;
  @override
  final AssignmentType type;
  @override
  final String name;
  @override
  @nullable
  final ClassEntity classEntity;
  @override
  final DateTime dueDate;
  @override
  final String notes;
  @override
  final bool completed;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AssignmentEntity(id: $id, type: $type, name: $name, classEntity: $classEntity, dueDate: $dueDate, notes: $notes, completed: $completed)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AssignmentEntity'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('classEntity', classEntity))
      ..add(DiagnosticsProperty('dueDate', dueDate))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('completed', completed));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AssignmentEntity &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.classEntity, classEntity) ||
                const DeepCollectionEquality()
                    .equals(other.classEntity, classEntity)) &&
            (identical(other.dueDate, dueDate) ||
                const DeepCollectionEquality()
                    .equals(other.dueDate, dueDate)) &&
            (identical(other.notes, notes) ||
                const DeepCollectionEquality().equals(other.notes, notes)) &&
            (identical(other.completed, completed) ||
                const DeepCollectionEquality()
                    .equals(other.completed, completed)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(classEntity) ^
      const DeepCollectionEquality().hash(dueDate) ^
      const DeepCollectionEquality().hash(notes) ^
      const DeepCollectionEquality().hash(completed);

  @override
  _$AssignmentEntityCopyWith<_AssignmentEntity> get copyWith =>
      __$AssignmentEntityCopyWithImpl<_AssignmentEntity>(this, _$identity);
}

abstract class _AssignmentEntity implements AssignmentEntity {
  const factory _AssignmentEntity(
      {@required String id,
      @required AssignmentType type,
      @required String name,
      @nullable ClassEntity classEntity,
      @required DateTime dueDate,
      @required String notes,
      @required bool completed}) = _$_AssignmentEntity;

  @override
  String get id;
  @override
  AssignmentType get type;
  @override
  String get name;
  @override
  @nullable
  ClassEntity get classEntity;
  @override
  DateTime get dueDate;
  @override
  String get notes;
  @override
  bool get completed;
  @override
  _$AssignmentEntityCopyWith<_AssignmentEntity> get copyWith;
}
