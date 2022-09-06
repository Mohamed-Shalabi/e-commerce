import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/dummy_data/api/api.dart';
import 'package:e_commerce/shared/local/prefs.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();
  await Api.initialize();

  final result = Api.getInstance().queryUser();
  print(result);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppThemes, AppThemeState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          themeMode: state.isLight ? ThemeMode.light : ThemeMode.dark,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          onGenerateRoute: Routes.onGenerateRoute,
        );
      },
    );
  }
}
