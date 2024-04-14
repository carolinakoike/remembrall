import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'view/login_view.dart';
import 'view/password_recovery_view.dart';
import 'view/register_view.dart'; 
import 'view/shopping_list_view.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu App',
      useInheritedMediaQuery: true, 
      locale: DevicePreview.locale(context), 
      builder: DevicePreview.appBuilder, 
      routes: {
        '/': (context) => const LoginView(), 
        '/passwordRecovery': (context) => const PasswordRecoveryView(), 
        '/signup': (context) => const SignUpView(),
        '/list':(context) => const ShoppingListView(),
      },
    );
  }
}
