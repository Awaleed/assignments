import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import './bloc.dart';
import '../model/preferences_model.dart';

class PreferencesBloc extends HydratedBloc<PreferencesEvent, PreferencesState> {
  @override
  PreferencesState get initialState {
    return super.initialState ??
        PreferencesLoaded(
            preferences: Preferences(appTheme: Colors.blue.value));
  }

  @override
  Stream<PreferencesState> mapEventToState(
    PreferencesEvent event,
  ) async* {
    if (event is PreferencesChanged)
      yield PreferencesLoaded(preferences: event.preferences);
    else if (event is GetPreferences)
      yield PreferencesLoaded(
          preferences: (state as PreferencesLoaded).preferences);
  }

  @override
  PreferencesState fromJson(Map<String, dynamic> json) {
    return PreferencesLoaded(preferences: Preferences.fromJson(json));
  }

  @override
  Map<String, dynamic> toJson(PreferencesState state) {
    return (state as PreferencesLoaded).preferences.toJson();
  }
}
