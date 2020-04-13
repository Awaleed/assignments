import 'package:assignments/features/preferences/model/preferences_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

abstract class PreferencesEvent extends Equatable {
  const PreferencesEvent();
}

class PreferencesChanged extends PreferencesEvent {
  final Preferences preferences;
  const PreferencesChanged({@required this.preferences});

  @override
  List<Object> get props => [preferences];
}

class GetPreferences extends PreferencesEvent {
  const GetPreferences();

  @override
  List<Object> get props => [];
}
