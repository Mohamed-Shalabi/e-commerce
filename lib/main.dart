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

  runApp(
    BlocProvider(
      create: (_) => AppThemesCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = context.watch<AppThemesCubit>().isLight;
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: isLight ? ThemeMode.light : ThemeMode.dark,
      theme: AppThemesCubit.lightTheme,
      darkTheme: AppThemesCubit.darkTheme,
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
