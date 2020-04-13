import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'preferences_model.g.dart';

@JsonSerializable()
class Preferences {
  final int appTheme;

  Preferences({
    @required this.appTheme,
  });
  factory Preferences.fromJson(Map<String, dynamic> json) =>
      _$PreferencesFromJson(json);
  Map<String, dynamic> toJson() => _$PreferencesToJson(this);


}
