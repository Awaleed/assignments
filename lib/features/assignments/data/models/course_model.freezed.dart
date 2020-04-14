// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'course_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
CourseModel _$CourseModelFromJson(Map<String, dynamic> json) {
  return _CourseModel.fromJson(json);
}

class _$CourseModelTearOff {
  const _$CourseModelTearOff();

  _CourseModel call(
      {@required String id, @required String name, @required int color}) {
    return _CourseModel(
      id: id,
      name: name,
      color: color,
    );
  }
}

// ignore: unused_element
const $CourseModel = _$CourseModelTearOff();

mixin _$CourseModel {
  String get id;
  String get name;
  int get color;

  Map<String, dynamic> toJson();
  $CourseModelCopyWith<CourseModel> get copyWith;
}

abstract class $CourseModelCopyWith<$Res> {
  factory $CourseModelCopyWith(
          CourseModel value, $Res Function(CourseModel) then) =
      _$CourseModelCopyWithImpl<$Res>;
  $Res call({String id, String name, int color});
}

class _$CourseModelCopyWithImpl<$Res> implements $CourseModelCopyWith<$Res> {
  _$CourseModelCopyWithImpl(this._value, this._then);

  final CourseModel _value;
  // ignore: unused_field
  final $Res Function(CourseModel) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object color = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      color: color == freezed ? _value.color : color as int,
    ));
  }
}

abstract class _$CourseModelCopyWith<$Res>
    implements $CourseModelCopyWith<$Res> {
  factory _$CourseModelCopyWith(
          _CourseModel value, $Res Function(_CourseModel) then) =
      __$CourseModelCopyWithImpl<$Res>;
  @override
  $Res call({String id, String name, int color});
}

class __$CourseModelCopyWithImpl<$Res> extends _$CourseModelCopyWithImpl<$Res>
    implements _$CourseModelCopyWith<$Res> {
  __$CourseModelCopyWithImpl(
      _CourseModel _value, $Res Function(_CourseModel) _then)
      : super(_value, (v) => _then(v as _CourseModel));

  @override
  _CourseModel get _value => super._value as _CourseModel;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object color = freezed,
  }) {
    return _then(_CourseModel(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      color: color == freezed ? _value.color : color as int,
    ));
  }
}

@JsonSerializable()
class _$_CourseModel with DiagnosticableTreeMixin implements _CourseModel {
  _$_CourseModel({@required this.id, @required this.name, @required this.color})
      : assert(id != null),
        assert(name != null),
        assert(color != null);

  factory _$_CourseModel.fromJson(Map<String, dynamic> json) =>
      _$_$_CourseModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int color;

  bool _didentity = false;
  CourseEntity _entity;

  @override
  CourseEntity get entity {
    if (_didentity == false) {
      _didentity = true;
      _entity = CourseEntity(
        id: this.id,
        name: this.name,
        color: Colors.primaries.firstWhere((c) => c.value == this.color),
      );
    }
    return _entity;
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'CourseModel(id: $id, name: $name, color: $color, entity: $entity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'CourseModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('entity', entity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CourseModel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(color);

  @override
  _$CourseModelCopyWith<_CourseModel> get copyWith =>
      __$CourseModelCopyWithImpl<_CourseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CourseModelToJson(this);
  }
}

abstract class _CourseModel implements CourseModel {
  factory _CourseModel(
      {@required String id,
      @required String name,
      @required int color}) = _$_CourseModel;

  factory _CourseModel.fromJson(Map<String, dynamic> json) =
      _$_CourseModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get color;
  @override
  _$CourseModelCopyWith<_CourseModel> get copyWith;
}
