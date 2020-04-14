// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'assignment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
AssignmentModel _$AssignmentModelFromJson(Map<String, dynamic> json) {
  return _AssignmentModel.fromJson(json);
}

class _$AssignmentModelTearOff {
  const _$AssignmentModelTearOff();

  _AssignmentModel call(
      {@required String id,
      @required String course,
      @required int type,
      @required String name,
      @required int dueDate,
      @required int creationDate,
      @required String notes,
      @required bool completed}) {
    return _AssignmentModel(
      id: id,
      course: course,
      type: type,
      name: name,
      dueDate: dueDate,
      creationDate: creationDate,
      notes: notes,
      completed: completed,
    );
  }
}

// ignore: unused_element
const $AssignmentModel = _$AssignmentModelTearOff();

mixin _$AssignmentModel {
  String get id;
  String get course;
  int get type;
  String get name;
  int get dueDate;
  int get creationDate;
  String get notes;
  bool get completed;

  Map<String, dynamic> toJson();
  $AssignmentModelCopyWith<AssignmentModel> get copyWith;
}

abstract class $AssignmentModelCopyWith<$Res> {
  factory $AssignmentModelCopyWith(
          AssignmentModel value, $Res Function(AssignmentModel) then) =
      _$AssignmentModelCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String course,
      int type,
      String name,
      int dueDate,
      int creationDate,
      String notes,
      bool completed});
}

class _$AssignmentModelCopyWithImpl<$Res>
    implements $AssignmentModelCopyWith<$Res> {
  _$AssignmentModelCopyWithImpl(this._value, this._then);

  final AssignmentModel _value;
  // ignore: unused_field
  final $Res Function(AssignmentModel) _then;

  @override
  $Res call({
    Object id = freezed,
    Object course = freezed,
    Object type = freezed,
    Object name = freezed,
    Object dueDate = freezed,
    Object creationDate = freezed,
    Object notes = freezed,
    Object completed = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      course: course == freezed ? _value.course : course as String,
      type: type == freezed ? _value.type : type as int,
      name: name == freezed ? _value.name : name as String,
      dueDate: dueDate == freezed ? _value.dueDate : dueDate as int,
      creationDate:
          creationDate == freezed ? _value.creationDate : creationDate as int,
      notes: notes == freezed ? _value.notes : notes as String,
      completed: completed == freezed ? _value.completed : completed as bool,
    ));
  }
}

abstract class _$AssignmentModelCopyWith<$Res>
    implements $AssignmentModelCopyWith<$Res> {
  factory _$AssignmentModelCopyWith(
          _AssignmentModel value, $Res Function(_AssignmentModel) then) =
      __$AssignmentModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String course,
      int type,
      String name,
      int dueDate,
      int creationDate,
      String notes,
      bool completed});
}

class __$AssignmentModelCopyWithImpl<$Res>
    extends _$AssignmentModelCopyWithImpl<$Res>
    implements _$AssignmentModelCopyWith<$Res> {
  __$AssignmentModelCopyWithImpl(
      _AssignmentModel _value, $Res Function(_AssignmentModel) _then)
      : super(_value, (v) => _then(v as _AssignmentModel));

  @override
  _AssignmentModel get _value => super._value as _AssignmentModel;

  @override
  $Res call({
    Object id = freezed,
    Object course = freezed,
    Object type = freezed,
    Object name = freezed,
    Object dueDate = freezed,
    Object creationDate = freezed,
    Object notes = freezed,
    Object completed = freezed,
  }) {
    return _then(_AssignmentModel(
      id: id == freezed ? _value.id : id as String,
      course: course == freezed ? _value.course : course as String,
      type: type == freezed ? _value.type : type as int,
      name: name == freezed ? _value.name : name as String,
      dueDate: dueDate == freezed ? _value.dueDate : dueDate as int,
      creationDate:
          creationDate == freezed ? _value.creationDate : creationDate as int,
      notes: notes == freezed ? _value.notes : notes as String,
      completed: completed == freezed ? _value.completed : completed as bool,
    ));
  }
}

@JsonSerializable()
class _$_AssignmentModel
    with DiagnosticableTreeMixin
    implements _AssignmentModel {
  _$_AssignmentModel(
      {@required this.id,
      @required this.course,
      @required this.type,
      @required this.name,
      @required this.dueDate,
      @required this.creationDate,
      @required this.notes,
      @required this.completed})
      : assert(id != null),
        assert(course != null),
        assert(type != null),
        assert(name != null),
        assert(dueDate != null),
        assert(creationDate != null),
        assert(notes != null),
        assert(completed != null);

  factory _$_AssignmentModel.fromJson(Map<String, dynamic> json) =>
      _$_$_AssignmentModelFromJson(json);

  @override
  final String id;
  @override
  final String course;
  @override
  final int type;
  @override
  final String name;
  @override
  final int dueDate;
  @override
  final int creationDate;
  @override
  final String notes;
  @override
  final bool completed;

  bool _didentity = false;
  AssignmentEntity _entity;

  @override
  AssignmentEntity get entity {
    if (_didentity == false) {
      _didentity = true;
      _entity = AssignmentEntity(
        id: this.id,
        courseId: this.course,
        course: null,
        type: AssignmentType.values[this.type],
        name: this.name,
        dueDate: DateTime.fromMillisecondsSinceEpoch(this.dueDate),
        creationDate: DateTime.fromMillisecondsSinceEpoch(this.creationDate),
        notes: this.notes,
        completed: this.completed,
      );
    }
    return _entity;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AssignmentModel(id: $id, course: $course, type: $type, name: $name, dueDate: $dueDate, creationDate: $creationDate, notes: $notes, completed: $completed, entity: $entity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AssignmentModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('course', course))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('dueDate', dueDate))
      ..add(DiagnosticsProperty('creationDate', creationDate))
      ..add(DiagnosticsProperty('notes', notes))
      ..add(DiagnosticsProperty('completed', completed))
      ..add(DiagnosticsProperty('entity', entity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AssignmentModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.course, course) ||
                const DeepCollectionEquality().equals(other.course, course)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.dueDate, dueDate) ||
                const DeepCollectionEquality()
                    .equals(other.dueDate, dueDate)) &&
            (identical(other.creationDate, creationDate) ||
                const DeepCollectionEquality()
                    .equals(other.creationDate, creationDate)) &&
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
      const DeepCollectionEquality().hash(course) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(dueDate) ^
      const DeepCollectionEquality().hash(creationDate) ^
      const DeepCollectionEquality().hash(notes) ^
      const DeepCollectionEquality().hash(completed);

  @override
  _$AssignmentModelCopyWith<_AssignmentModel> get copyWith =>
      __$AssignmentModelCopyWithImpl<_AssignmentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AssignmentModelToJson(this);
  }
}

abstract class _AssignmentModel implements AssignmentModel {
  factory _AssignmentModel(
      {@required String id,
      @required String course,
      @required int type,
      @required String name,
      @required int dueDate,
      @required int creationDate,
      @required String notes,
      @required bool completed}) = _$_AssignmentModel;

  factory _AssignmentModel.fromJson(Map<String, dynamic> json) =
      _$_AssignmentModel.fromJson;

  @override
  String get id;
  @override
  String get course;
  @override
  int get type;
  @override
  String get name;
  @override
  int get dueDate;
  @override
  int get creationDate;
  @override
  String get notes;
  @override
  bool get completed;
  @override
  _$AssignmentModelCopyWith<_AssignmentModel> get copyWith;
}
