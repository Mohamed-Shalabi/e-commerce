import 'package:e_commerce/shared/local/prefs.dart';
import 'package:e_commerce/shared/styles/app_colors.dart';
import 'package:e_commerce/shared/styles/app_text_styles.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppThemesCubit extends Cubit<AppThemesState> {
  AppThemesCubit() : super(AppThemesInitialState());

  bool get isLight => Prefs.getData<bool>(key: Prefs.isLightThemeKey) ?? true;

  set isLight(bool value) {
    emit(AppThemesToggleLightState());
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
@immutable
abstract class AppThemesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AppThemesInitialState extends AppThemesState {}

class AppThemesToggleLightState extends AppThemesState {}

extension ThemeUtils on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;
}
