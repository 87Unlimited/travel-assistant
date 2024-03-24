import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:travel_assistant/features/auth/presentation/views/login/login_view.dart';

import 'config/theme/theme.dart';
import 'features/auth/presentation/views/register/register_view.dart';
import 'navigation_menu.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const LoginView(),
    );
  }
}
