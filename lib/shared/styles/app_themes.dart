import 'package:e_commerce/shared/local/prefs.dart';
import 'package:e_commerce/shared/styles/app_colors.dart';
import 'package:e_commerce/shared/styles/app_text_styles.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemes extends Cubit<AppThemeState> {
  AppThemes() : super(AppThemeState.initial());

  int get fontSizeAddition {
    return Prefs.getData<int>(key: Prefs.fontSizeAdditionKey) ?? 0;
  }

  set fontSizeAddition(int value) {
    emit(
      state.copyWith(
        state: AppThemeStates.fontSizeAdditionChange,
        fontSizeAddition: value,
      ),
    );
    Prefs.saveOrRemoveData<int>(key: Prefs.fontSizeAdditionKey, value: value);
  }

  bool get isLight => Prefs.getData<bool>(key: Prefs.isLightThemeKey) ?? true;

  set isLight(bool value) {
    emit(state.copyWith(state: AppThemeStates.isLightToggle, isLight: value));
    Prefs.saveOrRemoveData<bool>(key: Prefs.isLightThemeKey, value: value);
  }

  void toggleIsLight() => isLight = !isLight;

  static ThemeData get lightTheme => ThemeData(
        // To get a text style use Theme.of(context).colorScheme
        colorScheme: ColorSchemes.lightColorScheme,
        // to control default TextStyle graphics
        textTheme: TextThemes.getTextTheme(isLight: true),
      );

  static ThemeData get darkTheme => ThemeData(
        // To get a text style use Theme.of(context).colorScheme
        colorScheme: ColorSchemes.darkColorScheme,
        // to control default TextStyle graphics
        textTheme: TextThemes.getTextTheme(isLight: false),
      );
}

enum AppThemeStates { initial, isLightToggle, fontSizeAdditionChange }

@immutable
class AppThemeState extends Equatable {
  final AppThemeStates state;
  final bool isLight;
  final int fontSizeAddition;

  const AppThemeState({
    this.state = AppThemeStates.initial,
    required this.isLight,
    required this.fontSizeAddition,
  });

  AppThemeState.initial()
      : state = AppThemeStates.initial,
        isLight = Prefs.getData<bool>(key: Prefs.isLightThemeKey) ?? true,
        fontSizeAddition =
            Prefs.getData<int>(key: Prefs.fontSizeAdditionKey) ?? 0;

  AppThemeState copyWith({
    required AppThemeStates state,
    bool? isLight,
    int? fontSizeAddition,
  }) {
    return AppThemeState(
      state: state,
      isLight: isLight ?? this.isLight,
      fontSizeAddition: fontSizeAddition ?? this.fontSizeAddition,
    );
  }

  @override
  List<Object?> get props => [state, isLight, fontSizeAddition];
}

extension ThemeUtils on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;
}
