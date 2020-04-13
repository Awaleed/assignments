// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'class_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ClassModel _$ClassModelFromJson(Map<String, dynamic> json) {
  return _ClassModel.fromJson(json);
}

class _$ClassModelTearOff {
  const _$ClassModelTearOff();

  _ClassModel call(
      {@required String id,
      @required String name,
      @required int color,
      @nullable List<Map<String, dynamic>> assignments}) {
    return _ClassModel(
      id: id,
      name: name,
      color: color,
      assignments: assignments,
    );
  }
}

// ignore: unused_element
const $ClassModel = _$ClassModelTearOff();

mixin _$ClassModel {
  String get id;
  String get name;
  int get color;
  @nullable
  List<Map<String, dynamic>> get assignments;

  Map<String, dynamic> toJson();
  $ClassModelCopyWith<ClassModel> get copyWith;
}

abstract class $ClassModelCopyWith<$Res> {
  factory $ClassModelCopyWith(
          ClassModel value, $Res Function(ClassModel) then) =
      _$ClassModelCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      int color,
      @nullable List<Map<String, dynamic>> assignments});
}

class _$ClassModelCopyWithImpl<$Res> implements $ClassModelCopyWith<$Res> {
  _$ClassModelCopyWithImpl(this._value, this._then);

  final ClassModel _value;
  // ignore: unused_field
  final $Res Function(ClassModel) _then;

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
      color: color == freezed ? _value.color : color as int,
      assignments: assignments == freezed
          ? _value.assignments
          : assignments as List<Map<String, dynamic>>,
    ));
  }
}

abstract class _$ClassModelCopyWith<$Res> implements $ClassModelCopyWith<$Res> {
  factory _$ClassModelCopyWith(
          _ClassModel value, $Res Function(_ClassModel) then) =
      __$ClassModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      int color,
      @nullable List<Map<String, dynamic>> assignments});
}

class __$ClassModelCopyWithImpl<$Res> extends _$ClassModelCopyWithImpl<$Res>
    implements _$ClassModelCopyWith<$Res> {
  __$ClassModelCopyWithImpl(
      _ClassModel _value, $Res Function(_ClassModel) _then)
      : super(_value, (v) => _then(v as _ClassModel));

  @override
  _ClassModel get _value => super._value as _ClassModel;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object color = freezed,
    Object assignments = freezed,
  }) {
    return _then(_ClassModel(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      color: color == freezed ? _value.color : color as int,
      assignments: assignments == freezed
          ? _value.assignments
          : assignments as List<Map<String, dynamic>>,
    ));
  }
}

@JsonSerializable()
class _$_ClassModel with DiagnosticableTreeMixin implements _ClassModel {
  _$_ClassModel(
      {@required this.id,
      @required this.name,
      @required this.color,
      @nullable this.assignments})
      : assert(id != null),
        assert(name != null),
        assert(color != null);

  factory _$_ClassModel.fromJson(Map<String, dynamic> json) =>
      _$_$_ClassModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int color;
  @override
  @nullable
  final List<Map<String, dynamic>> assignments;

  bool _didentity = false;
  ClassEntity _entity;

  @override
  ClassEntity get entity {
    if (_didentity == false) {
      _didentity = true;
      _entity = ClassEntity(
        id: this.id,
        name: this.name,
        color: Colors.primaries.firstWhere((c) => c.value == this.color),
        assignments: this
            .assignments
            .map(
              (a) => AssignmentModel.fromJson(a)
                  .entity
                  .copyWith(classEntity: this.entity),
            )
            .toList(),
      );
    }
    return _entity;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ClassModel(id: $id, name: $name, color: $color, assignments: $assignments, entity: $entity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ClassModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('assignments', assignments))
      ..add(DiagnosticsProperty('entity', entity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ClassModel &&
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
  _$ClassModelCopyWith<_ClassModel> get copyWith =>
      __$ClassModelCopyWithImpl<_ClassModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ClassModelToJson(this);
  }
}

abstract class _ClassModel implements ClassModel {
  factory _ClassModel(
      {@required String id,
      @required String name,
      @required int color,
      @nullable List<Map<String, dynamic>> assignments}) = _$_ClassModel;

  factory _ClassModel.fromJson(Map<String, dynamic> json) =
      _$_ClassModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get color;
  @override
  @nullable
  List<Map<String, dynamic>> get assignments;
  @override
  _$ClassModelCopyWith<_ClassModel> get copyWith;
}
