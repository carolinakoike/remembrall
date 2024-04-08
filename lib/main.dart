import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'view/login_view.dart';
import 'view/password_recovery_view.dart'; 

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu App',
      useInheritedMediaQuery: true, 
      locale: DevicePreview.locale(context), 
      builder: DevicePreview.appBuilder, 
      routes: {
        '/': (context) => LoginView(), 
        '/passwordRecovery': (context) => PasswordRecoveryView(), 
      },
    );
  }
}
