import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'view/login_view.dart'; // Atualize este caminho conforme sua estrutura de diretórios

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
      home: LoginView(), // Use LoginView aqui
    );
  }
}
