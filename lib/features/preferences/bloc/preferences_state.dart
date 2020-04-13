import 'package:assignments/features/preferences/model/preferences_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class PreferencesState extends Equatable {
  const PreferencesState();
}

class PreferencesLoaded extends PreferencesState {
  final Preferences preferences;

  PreferencesLoaded({@required this.preferences});
  @override
  List<Object> get props => [preferences];
}
