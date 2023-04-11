import 'package:e_commerce/core/local/prefs.dart';
import 'package:e_commerce/core/styles/app_colors.dart';
import 'package:e_commerce/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';

class AppThemesCubit extends StatelessCubit<AppThemesState> {
  set isLight(bool value) {
    Prefs.saveOrRemoveData<bool>(
      key: Prefs.isLightThemeKey,
      value: value,
    );

    if (value) {
      emit(AppThemesLightState());
    } else {
      emit(AppThemesDarkState());
    }
  }

  void toggleIsLight() {
    final lastState =
        stateHolder.lastStateOfContextType(AppThemesState) as AppThemesState? ??
            AppThemesState.initialState;

    final isLight = lastState.isLight;

    this.isLight = !isLight;
  }

  static ThemeData get lightTheme => ThemeData(
        colorScheme: ColorSchemes.lightColorScheme,
        textTheme: TextThemes.getTextTheme(isLight: true),
      );

  static ThemeData get darkTheme => ThemeData(
        colorScheme: ColorSchemes.darkColorScheme,
        textTheme: TextThemes.getTextTheme(isLight: false),
      );
}

@immutable
abstract class AppThemesState implements ContextState {
  ThemeMode get themeMode;

  bool get isLight => themeMode == ThemeMode.light;

  static AppThemesState get initialState {
    final isLight = Prefs.getData<bool>(key: Prefs.isLightThemeKey) ?? true;
    if (isLight) {
      return AppThemesLightState();
    }

    return AppThemesDarkState();
  }

  @override
  Set<Type> get parentStates => {AppThemesState};
}

class AppThemesLightState with AppThemesState {
  @override
  ThemeMode get themeMode => ThemeMode.light;
}

class AppThemesDarkState with AppThemesState {
  @override
  ThemeMode get themeMode => ThemeMode.light;
}

extension ThemeUtils on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;
}
