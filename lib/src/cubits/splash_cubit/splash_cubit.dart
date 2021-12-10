import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../repositories/settings_repository.dart';
import '../../repositories/user_repository.dart';

enum SplashState {
  initial,
  firstLaunch,
  authenticated,
  unauthenticated,
}

@injectable
class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._settingsRepository, this._userRepo)
      : super(SplashState.initial) {
    _startLoading();
  }

  final ISettingsRepository _settingsRepository;
  final IUserRepository _userRepo;

  Future<void> _startLoading() async {
    await _checkIfFirstLaunch();
    await _checkIfAuthenticated();
  }

  Future<void> _checkIfFirstLaunch() async {
    final settings = _settingsRepository.getSettings();
    if (settings.isFirstLaunch) {
      settings.isFirstLaunch = false;
      _settingsRepository.saveSettings(settings);
      emit(SplashState.firstLaunch);
    }
  }

  Future<void> _checkIfAuthenticated() async {
    try {
      if (_userRepo.getUser() != null) {
        emit(SplashState.authenticated);
      } else {
        emit(SplashState.unauthenticated);
      }
    } catch (e) {
      emit(SplashState.unauthenticated);
    }
  }
}
