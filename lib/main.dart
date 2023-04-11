import 'package:e_commerce/core/database/api/api.dart';
import 'package:e_commerce/core/local/prefs.dart';
import 'package:e_commerce/core/styles/app_themes.dart';
import 'package:e_commerce/modules/auth/blocs/shipping/shipping_data_provider.dart';
import 'package:e_commerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stateful_bloc/flutter_stateful_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();
  await Api.init();
  initializeDateFormatting();

  runApp(
    StatefulProvider(
      app: ObjectProvider(
        create: (_) => ShippingDataProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateConsumer<AppThemesState>(
      initialState: AppThemesState.initialState,
      builder: (context, state) {
        return MaterialApp(
          title: 'Market App',
          themeMode: state.themeMode,
          theme: AppThemesCubit.lightTheme,
          darkTheme: AppThemesCubit.darkTheme,
          onGenerateRoute: Routes.onGenerateRoute,
        );
      },
    );
  }
}
